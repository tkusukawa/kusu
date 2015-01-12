// TCP Receive
// (C) Tomohisa Kusukawa 2009-2015

#include <sys/errno.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <netdb.h>
#include <arpa/inet.h>

#define REQ_ARG_NUM 2
#define L_PORT_ARG 1
#define D_HOST_ARG 2
#define D_PORT_ARG 3
#define HOST_NAME_MAX_LEN 64
#define LISTEN_NUM 5
#define RCV_BUF_SIZE 16384

struct RcvList {
    char clientHost[HOST_NAME_MAX_LEN];
    int clientSocket;
    int fileSocket;
    RcvList *next;
};

int makeListenSocket(unsigned short port);
int acceptSocket(int listenSocket);
void addRcvNode(RcvList **listPP, fd_set *fds, int cSocket);
void deleteRcvNode(RcvList **listPP, fd_set *fds);
int rcvSocket(int rcvSocket, char *buf, int bufSize);

main(int argc, char **argv)
{
    if(argc != REQ_ARG_NUM) {
        printf("usage: %s [listen port]\n", argv[0]);
        exit(0);
    }

    int port = atoi(argv[L_PORT_ARG]);
    int listenSocket = makeListenSocket(port);
    printf("\nListen Port %d -> %s (%s)\n",
           port, argv[D_HOST_ARG], argv[D_PORT_ARG]);
    fflush(stdout);
    
    fd_set rfds;
    FD_ZERO(&rfds);
    FD_SET(listenSocket, &rfds);

    RcvList *rcvList = NULL;
    char rcvBuf[RCV_BUF_SIZE];
    for(;;) {
        fd_set rflg = rfds;
        int ret = select(FD_SETSIZE, &rflg, NULL, NULL, NULL);
        if(ret < 0) {
            perror("main:select");
            exit(1);
        }
        else if(ret > 0) {

            RcvList **pp = &rcvList;
            while(*pp != NULL) {
                int rcvRes = 0;
                if(FD_ISSET((*pp)->clientSocket, &rflg)) {
                    rcvRes = rcvSocket((*pp)->clientSocket,
                                           rcvBuf, sizeof(rcvBuf));
                    printf("%s->:%d[byte]\n", (*pp)->clientHost, rcvRes);
		    printf("HEX:");
		    for(int i=0; i < rcvRes; i++) {
		      printf("%02X,",rcvBuf[i]);
		    }
		    printf("\nSTR:");
		    for(int i=0; i < rcvRes; i++) {
		      printf("%c",rcvBuf[i]);
		    }
		    printf("\n");
                }
                if(rcvRes < 0) {
                    deleteRcvNode(pp, &rfds);
                    continue;
                }
                pp = &((*pp)->next);
            }

            if(FD_ISSET(listenSocket, &rflg)) {
                int clientSocket = acceptSocket(listenSocket);
                if(clientSocket>=0) {
                    addRcvNode(&rcvList, &rfds, clientSocket);
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
        //exit(1);
        return -1;
    }
    return newSocket;
}

int rcvSocket(int rcvSocket, char *buf, int bufSize)
{
    ssize_t len = recv(rcvSocket, buf, bufSize, 0);
    if(len <= 0) {
        return -1;
    }
    return len;
}

void addRcvNode(RcvList **listPP, fd_set *fds, int cSocket)
{
    sockaddr_in addr;
    socklen_t len = sizeof(addr);
    if(getpeername(cSocket, (sockaddr *)&addr, &len) < 0) {
        perror("addRcvNode:getpeername");
        //exit(1);
        close(cSocket);
        return;
    }
    RcvList *node = new RcvList;
    if(inet_ntop(AF_INET, &(addr.sin_addr), node->clientHost, HOST_NAME_MAX_LEN) == NULL) {
        perror("addRcvNode:inet_ntop");
        //exit(1);
        close(cSocket);
        return;
    }
    node->clientSocket = cSocket;
    node->next = *listPP;
    *listPP = node;

    FD_SET(node->clientSocket, fds);

    time_t t;
    struct tm *ltm;
    char tms[128];
    time(&t);
    ltm = localtime(&t);
        
    printf("[%02d/%02d %02d:%02d:%02d] %s Connect\n",
           ltm->tm_mon+1, ltm->tm_mday,
           ltm->tm_hour, ltm->tm_min, ltm->tm_sec,
           node->clientHost);
    fflush(stdout);
}

void deleteRcvNode(RcvList **listPP, fd_set *fds)
{
    time_t t;
    struct tm *ltm;
    char tms[128];
    time(&t);
    ltm = localtime(&t);

    printf("[%02d/%02d %02d:%02d:%02d] %s Disconnect \n",
           ltm->tm_mon+1, ltm->tm_mday,
           ltm->tm_hour, ltm->tm_min, ltm->tm_sec,
           (*listPP)->clientHost);
    fflush(stdout);

    FD_CLR((*listPP)->clientSocket, fds);
    close((*listPP)->clientSocket);
    RcvList *remove = (*listPP);
    (*listPP) = remove->next;
    delete(remove);
}
