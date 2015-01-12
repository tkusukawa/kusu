// TCP port redirector
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

#define REQ_ARG_NUM 4
#define L_PORT_ARG 1
#define D_HOST_ARG 2
#define D_PORT_ARG 3
#define HOST_NAME_MAX_LEN 64
#define LISTEN_NUM 5
#define RELAY_BUF_SIZE 16384
#define INTERVAL_SEC 10
#define TIMEOUT_SEC 600 // 600sec == 10min

struct RelayList {
  char clientHost[HOST_NAME_MAX_LEN];
  int clientSocket;
  int serverSocket;
  time_t lastTime;
  RelayList *next;
};

int makeListenSocket(unsigned short port);
int acceptSocket(int listenSocket);
RelayList *addRelayNode(RelayList **listPP, fd_set *fds, int cSocket, int sSocket);
void deleteRelayNode(RelayList **listPP, fd_set *fds);
int makeServerConnection(char *host, unsigned short port);
int relaySocket(int rcvSocket, int sndSocket, char *buf, int bufSize);

main(int argc, char **argv)
{
  time_t tm;
  struct tm *ltm;
  struct timeval tv; // interval (timeout of select func.)

  tm = time(NULL);
  ltm = localtime(&tm);

  if(argc != REQ_ARG_NUM) {
    printf("usage: %s [listen port] [destination host] [destination port]\n", argv[0]);
    exit(0);
  }

  int port = atoi(argv[L_PORT_ARG]);
  int listenSocket = makeListenSocket(port);
  printf("\n[%02d/%02d %02d:%02d:%02d]:%d",
	 ltm->tm_mon+1, ltm->tm_mday, ltm->tm_hour, ltm->tm_min, ltm->tm_sec, listenSocket);
  printf(" Listen Port %d -> %s (%s)\n",
	 port, argv[D_HOST_ARG], argv[D_PORT_ARG]);
  fflush(stdout);
    
  fd_set rfds;
  FD_ZERO(&rfds);
  FD_SET(listenSocket, &rfds);

  RelayList *relayList = NULL;
  char relayBuf[RELAY_BUF_SIZE];
  for(;;) {
    fd_set rflg = rfds;
    tv.tv_sec = INTERVAL_SEC; tv.tv_usec = 0;
    int ret = select(FD_SETSIZE, &rflg, NULL, NULL, &tv);

    tm = time(NULL);
    ltm = localtime(&tm);

    if(ret < 0) {
      perror("main:select");
      exit(1);
    }
    else {
      RelayList **pp = &relayList;
      while(*pp != NULL) {
	int relayRes = 0;
	if(ret > 0 && FD_ISSET((*pp)->clientSocket, &rflg)) {
	  relayRes = relaySocket((*pp)->clientSocket, (*pp)->serverSocket,
				 relayBuf, sizeof(relayBuf));
	  if(relayRes < 0) {
	    printf("[%02d/%02d %02d:%02d:%02d]:%d Disconnect %s by client\n",
		   ltm->tm_mon+1, ltm->tm_mday, ltm->tm_hour, ltm->tm_min, ltm->tm_sec, (*pp)->clientSocket,
		   (*pp)->clientHost);
	    fflush(stdout);
	    deleteRelayNode(pp, &rfds);
	    continue;
	  }
	  //printf("%s->:%d[byte]\n", (*pp)->clientHost, relayRes);
	  (*pp)->lastTime = tm;
	}
	else if(ret > 0 && FD_ISSET((*pp)->serverSocket, &rflg)) {
	  relayRes = relaySocket((*pp)->serverSocket, (*pp)->clientSocket,
				 relayBuf, sizeof(relayBuf));
	  if(relayRes < 0) {
	    printf("[%02d/%02d %02d:%02d:%02d]:%d Disconnect %s by server\n",
		   ltm->tm_mon+1, ltm->tm_mday, ltm->tm_hour, ltm->tm_min, ltm->tm_sec, (*pp)->clientSocket,
		   (*pp)->clientHost);
	    fflush(stdout);
	    deleteRelayNode(pp, &rfds);
	    continue;
	  }
	  //printf("%s<-:%d[byte]\n", (*pp)->clientHost, relayRes);
	  (*pp)->lastTime = tm;
	}

	double dtm = difftime(tm, (*pp)->lastTime);
	if(dtm >= (double)TIMEOUT_SEC) {
	  printf("[%02d/%02d %02d:%02d:%02d]:%d Disconnect %s by TIMEOUT\n",
		 ltm->tm_mon+1, ltm->tm_mday, ltm->tm_hour, ltm->tm_min, ltm->tm_sec, (*pp)->clientSocket,
		 (*pp)->clientHost);
	  fflush(stdout);
	  deleteRelayNode(pp, &rfds);
	  continue;
	}

	pp = &((*pp)->next);
      }

      if(ret > 0 && FD_ISSET(listenSocket, &rflg)) {
	int clientSocket = acceptSocket(listenSocket);
	if(clientSocket>=0) {
	  printf("[%02d/%02d %02d:%02d:%02d]:%d Accept!\n",
		 ltm->tm_mon+1, ltm->tm_mday, ltm->tm_hour, ltm->tm_min, ltm->tm_sec, clientSocket);
	  fflush(stdout);
	  int serverSocket = makeServerConnection(argv[D_HOST_ARG], atoi(argv[D_PORT_ARG]));
	  if(serverSocket >= 0) {
	    RelayList *node = addRelayNode(&relayList, &rfds, clientSocket, serverSocket);
            if(node != NULL) {
	      tm = time(NULL);
	      ltm = localtime(&tm);
	      node->lastTime = tm;
	      printf("[%02d/%02d %02d:%02d:%02d]:%d Connect %s\n",
		     ltm->tm_mon+1, ltm->tm_mday, ltm->tm_hour, ltm->tm_min, ltm->tm_sec, clientSocket,
		     node->clientHost);
	      fflush(stdout);
	    }
	  }
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

int makeServerConnection(char *host, unsigned short port)
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

RelayList *addRelayNode(RelayList **listPP, fd_set *fds, int cSocket, int sSocket)
{
  sockaddr_in addr;
  socklen_t len = sizeof(addr);
  if(getpeername(cSocket, (sockaddr *)&addr, &len) < 0) {
    perror("addRelayNode:getpeername");
    //exit(1);
    close(cSocket);
    close(sSocket);
    return NULL;
  }
  RelayList *node = new RelayList;
  if(inet_ntop(AF_INET, &(addr.sin_addr), node->clientHost, HOST_NAME_MAX_LEN) == NULL) {
    perror("addRelayNode:inet_ntop");
    //exit(1);
    close(cSocket);
    close(sSocket);
    return NULL;
  }
  node->clientSocket = cSocket;
  node->serverSocket = sSocket;
  node->next = *listPP;
  *listPP = node;

  FD_SET(node->clientSocket, fds);
  FD_SET(node->serverSocket, fds);

  return node;
}

void deleteRelayNode(RelayList **listPP, fd_set *fds)
{
  FD_CLR((*listPP)->serverSocket, fds);
  FD_CLR((*listPP)->clientSocket, fds);
  close((*listPP)->clientSocket);
  close((*listPP)->serverSocket);
  RelayList *remove = (*listPP);
  (*listPP) = remove->next;
  delete(remove);
}
