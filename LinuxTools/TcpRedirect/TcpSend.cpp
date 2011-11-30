// TCP send
// (C) Tomohisa Kusukawa 2011

#include <sys/errno.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <netdb.h>
#include <arpa/inet.h>

#define REQ_ARG_NUM 3
#define D_HOST_ARG 1
#define D_PORT_ARG 2
#define HOST_NAME_MAX_LEN 64
#define LISTEN_NUM 5
#define RELAY_BUF_SIZE 16384

int makeSendConnection(char *host, unsigned short port);
int relaySocket(int rcvSocket, int sndSocket, char *buf, int bufSize);

main(int argc, char **argv)
{
    if(argc != REQ_ARG_NUM) {
        printf("usage: %s [destination host] [destination port]\n", argv[0]);
        exit(0);
    }

    int sendSocket = makeSendConnection(argv[D_HOST_ARG], atoi(argv[D_PORT_ARG]));
    if(sendSocket < 0) {
        exit(1);
    }

    fd_set rfds;
    FD_ZERO(&rfds);
    FD_SET(0, &rfds);

    char relayBuf[RELAY_BUF_SIZE];
    for(;;) {
        fd_set rflg = rfds;
        int ret = select(FD_SETSIZE, &rflg, NULL, NULL, NULL);
        if(ret < 0) {
            perror("main:select");
            exit(1);
        }
        else if(ret > 0) {
            int relayRes = 0;
            if(FD_ISSET(0, &rflg)) {
                relayRes = relaySocket(0, sendSocket,
                                       relayBuf, sizeof(relayBuf));
                //printf("%s->:%d[byte]\n", (*pp)->clientHost, relayRes);
            }
            if(relayRes < 0) {
                exit(0);
            }
        }
    }
}

int makeSendConnection(char *host, unsigned short port)
{
    hostent *hp;
    hp=gethostbyname(host);
    if(hp == NULL) {
        perror("makeClientSocket:gethostbyname");
        //exit(1);
        return -1;
    }

    sockaddr_in addr;
    addr.sin_family = AF_INET;
    memcpy(&addr.sin_addr, hp->h_addr, hp->h_length);
    addr.sin_port = htons(port);

    int s = socket(PF_INET, SOCK_STREAM, 0);
    if(s < 0) {
        perror("makeClientSocket:socket");
        //exit(1);
        return -1;
    }

    if(connect(s, (sockaddr*)&addr, sizeof(addr)) < 0) {
        perror("fail:makeClientSocket:connect");
        //exit(1);
        close(s);
        return -1;
    }

    return s;
}

int relaySocket(int rcvSocket, int sndSocket, char *buf, int bufSize)
{
    ssize_t len = recv(rcvSocket, buf, bufSize, 0);
    if(len <= 0) {
        return -1;
    }

    int snd = send(sndSocket, buf, len, 0);
    if(snd <= 0) {
        return -1;
    }

    return len;
}
