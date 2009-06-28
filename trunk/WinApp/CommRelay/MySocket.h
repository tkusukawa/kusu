// MySocket.h

#ifndef MY_SOCKET_H
#define MY_SOCKET_H

#define WM_SOCK_RCV WM_USER+1

// msg type def
#define SOCK_RCV 1
#define SOCK_ACCEPT 2
#define SOCK_CLOSE 3

struct RcvData
{
    unsigned short type;
    unsigned short len;
    char           data[1];
};

class CMySocket : public CSocket
{
protected:
    HWND wh;

public:
    CMySocket(HWND hnd = NULL);

    CMySocket *accepter;

    void setId(HWND hnd);

    virtual void OnReceive(int nErrorCode);
    virtual void OnAccept(int nErrorCode);
    virtual void OnClose(int nErrorCode);
    virtual void Close();
};


#endif // MY_SOCKET_H