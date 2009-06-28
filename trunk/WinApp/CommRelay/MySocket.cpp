// MySocket.cpp

#include "stdafx.h"
#include "MySocket.h"

CMySocket::CMySocket(HWND hnd)
     : CSocket()
{
    accepter = NULL;
}

void CMySocket::setId(HWND hnd)
{
    wh = hnd;
}

void CMySocket::OnReceive(int nErrorCode)
{
    unsigned short len;
    char data[8192];
    RcvData *sData;
    CString from;
    UINT port;

    if(nErrorCode != 0) {
        CString errStr;
        errStr.Format("Err: socket OnReceive : code=%d", nErrorCode);
        AfxMessageBox(errStr);
        return;
    }

    len = CMySocket::ReceiveFrom(data, 8192, from, port);

    if(len == SOCKET_ERROR) {
        AfxMessageBox("Err: socket Receive From");
        return;
    }

    if(len > 8192) {
        //AfxMessageBox("Fail: socket receive long data");
        return;
    }
    sData = (RcvData *)malloc(4+len);
    sData->type = SOCK_RCV;
    sData->len = len;
    memcpy(sData->data, data, len);

    PostMessage(wh, WM_SOCK_RCV, (WPARAM) sData, 0);
}

void CMySocket::Close()
{
    if(accepter != NULL) {
        accepter->Close();
        delete accepter;
        accepter = NULL;
    }
    CSocket::Close();
}

void CMySocket::OnClose(int nErrorCode)
{
    RcvData *data;

    data = (RcvData *)malloc(sizeof(RcvData));
    data->type = SOCK_CLOSE;
    PostMessage(wh, WM_SOCK_RCV, (WPARAM) data, 0);
}
void CMySocket::OnAccept(int nErrorCode)
{
    RcvData *data;
    CMySocket *newSock;

    data = (RcvData *)malloc(sizeof(RcvData));
    
    if(nErrorCode) {
        AfxMessageBox("Error : OnAccept");
        return;
    }

    newSock = new CMySocket;
    newSock->setId(wh);

    if( Accept(*newSock) == 0) {
        AfxMessageBox("Error : Accept");
        return;
    }

    CSocket::Close();
    accepter = newSock;

    data->type = SOCK_ACCEPT;
    PostMessage(wh, WM_SOCK_RCV, (WPARAM)data, 0);
}

