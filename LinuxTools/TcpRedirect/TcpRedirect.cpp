// TCP port redirector
// (C) Tomohisa Kusukawa 2009

#include <sys/errno.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <netdb.h>
#include <arpa/inet.h>

#define REQ_ARG_NUM 4
#define L_PORT_ARG 1
#define D_HOST_ARG 2
#define D_PORT_ARG 3
#define HOST_NAME_MAX_LEN 64
#define LISTEN_NUM 5
#define RELAY_BUF_SIZE 16384

struct RelayList {
    char clientHost[HOST_NAME_MAX_LEN];
    int clientSocket;
    int serverSocket;
    RelayList *next;
};

int makeListenSocket(unsigned short port);
int acceptSocket(int listenSocket);
void addRelayNode(RelayList **listPP, fd_set *fds, int cSocket, int sSocket);
void deleteRelayNode(RelayList **listPP, fd_set *fds);
int makeServerConnection(char *host, unsigned short port);
int relaySocket(int rcvSocket, int sndSocket, char *buf, int bufSize);

main(int argc, char **argv)
{
    if(argc != REQ_ARG_NUM) {
        printf("usage: %s [listen port] [destination host] [destination port]\n", argv[0]);
        exit(0);
    }

    int listenSocket = makeListenSocket(atoi(argv[L_PORT_ARG]));

    fd_set rfds;
    FD_ZERO(&rfds);
    FD_SET(listenSocket, &rfds);

    RelayList *relayList = NULL;
    char relayBuf[RELAY_BUF_SIZE];
    for(;;) {
        fd_set rflg = rfds;
        int ret = select(FD_SETSIZE, &rflg, NULL, NULL, NULL);
        if(ret < 0) {
            perror("main:select");
            exit(1);
        }
        else if(ret > 0) {

            RelayList **pp = &relayList;
            while(*pp != NULL) {
                int relayRes = 0;
                if(FD_ISSET((*pp)->clientSocket, &rflg)) {
                    relayRes = relaySocket((*pp)->clientSocket, (*pp)->serverSocket,
                                           relayBuf, sizeof(relayBuf));
                    printf("%s->:%d[byte]\n", (*pp)->clientHost, relayRes);
                }
                else if(FD_ISSET((*pp)->serverSocket, &rflg)) {
                    relayRes = relaySocket((*pp)->serverSocket, (*pp)->clientSocket,
                                           relayBuf, sizeof(relayBuf));
                    printf("%s<-:%d[byte]\n", (*pp)->clientHost, relayRes);
                }
                if(relayRes < 0) {
                    deleteRelayNode(pp, &rfds);
                    continue;
                }
                pp = &((*pp)->next);
            }

            if(FD_ISSET(listenSocket, &rflg)) {
                int clientSocket = acceptSocket(listenSocket);
                if(clientSocket>=0) {
                    int serverSocket = makeServerConnection(argv[D_HOST_ARG], atoi(argv[D_PORT_ARG]));
                    addRelayNode(&relayList, &rfds, clientSocket, serverSocket);
                }
            }
        }
    }
}

int makeListenSocket(unsigned short port)
{
    int s = socket(PF_INET, SOCK_STREAM, 0);
    if(s < 0) {
        perror("makeListenSocket:socket\n");
        exit(1);
    }

    sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = PF_INET;
    addr.sin_addr.s_addr = htonl(INADDR_ANY);
    addr.sin_port = htons(port);

    int temp = 1;
    if(setsockopt(s, SOL_SOCKET, SO_REUSEADDR,&temp, sizeof(temp))) {
        perror("makeListenSocket:setsockopt");
        exit(1);
    }

    if(bind(s, (sockaddr *)&addr, sizeof(addr)) < 0) {
        perror("makeListenSocket:bind");
        exit(1);
    }

    if(listen(s, LISTEN_NUM) < 0) {
        perror("makeListenSocket:listen");
        exit(1);
    }

    return s;
}

int acceptSocket(int listenSocket)
{
    sockaddr_in accept_addr;
    socklen_t accept_len = sizeof(accept_addr);
    int newSocket = accept(listenSocket, (sockaddr *)&accept_addr, &accept_len);
    if(newSocket < 0) {
        perror("acceptSocket:accept");
        exit(1);
    }
    return newSocket;
}

int makeServerConnection(char *host, unsigned short port)
{
    hostent *hp;
    hp=gethostbyname(host);
    if(hp == NULL) {
        perror("makeClientSocket:gethostbyname");
        exit(1);
    }

    sockaddr_in addr;
    addr.sin_family = AF_INET;
    memcpy(&addr.sin_addr, hp->h_addr, hp->h_length);
    addr.sin_port = htons(port);
    
    int s = socket(PF_INET, SOCK_STREAM, 0);
    if(s < 0) {
        perror("makeClientSocket:socket");
        exit(1);
    }

    if(connect(s, (sockaddr*)&addr, sizeof(addr)) < 0) {
        perror("fail:makeClientSocket:connect");
        exit(1);
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

void addRelayNode(RelayList **listPP, fd_set *fds, int cSocket, int sSocket)
{
    sockaddr_in addr;
    socklen_t len = sizeof(addr);
    if(getpeername(cSocket, (sockaddr *)&addr, &len) < 0) {
        perror("addRelayNode:getpeername");
        exit(1);
    }
    RelayList *node = new RelayList;
    if(inet_ntop(AF_INET, &(addr.sin_addr), node->clientHost, HOST_NAME_MAX_LEN) == NULL) {
        perror("addRelayNode:inet_ntop");
        exit(1);
    }
    node->clientSocket = cSocket;
    node->serverSocket = sSocket;
    node->next = *listPP;
    *listPP = node;

    FD_SET(node->clientSocket, fds);
    FD_SET(node->serverSocket, fds);
    printf("connect:%s\n", node->clientHost);
}

void deleteRelayNode(RelayList **listPP, fd_set *fds)
{
    printf("disconnect:%s\n", (*listPP)->clientHost);
    FD_CLR((*listPP)->serverSocket, fds);
    FD_CLR((*listPP)->clientSocket, fds);
    close((*listPP)->clientSocket);
    close((*listPP)->serverSocket);
    RelayList *remove = (*listPP);
    (*listPP) = remove->next;
    delete(remove);
}
