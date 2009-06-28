#include "stdafx.h"
#include "CommRelay.h"
#include "CommRelayDlg.h"
#include "PortDlg.h"
#include "DlgComm.h"
#include "dataPart.h"

int CDlgComm::comOpen(const char *devName, const char *config) 
{
    DCB dcb;
    COMMTIMEOUTS timeout;

	comHdl = CreateFile(devName,
		GENERIC_READ | GENERIC_WRITE,
		0,
		(LPSECURITY_ATTRIBUTES) NULL,
		OPEN_EXISTING,
		FILE_FLAG_OVERLAPPED,
		(HANDLE) NULL);

    if(comHdl == INVALID_HANDLE_VALUE) {
        MessageError("open:");
        return 1;
    }

    if(GetCommState(comHdl, &dcb) == 0) {
        MessageError("GetCommState:");
        CloseHandle(comHdl);
        return 1;
    }
    if(BuildCommDCB(config, &dcb) == 0) {
        MessageError("BuildCommDCB:");
        CloseHandle(comHdl);
        return 1;
    }
    if(SetCommState(comHdl, &dcb) == 0) {
        MessageError("SetCommState:");
        CloseHandle(comHdl);
        return 1;
    }

    timeout.ReadIntervalTimeout = 1;
    timeout.ReadTotalTimeoutConstant = 10;
    timeout.ReadTotalTimeoutMultiplier = 1;
    timeout.WriteTotalTimeoutConstant = 10;
    timeout.WriteTotalTimeoutMultiplier = 1;
    SetCommTimeouts(comHdl, &timeout);


    comReadEvent = CreateEvent(NULL, FALSE, FALSE, NULL);
    comWriteEvent = CreateEvent(NULL, FALSE, FALSE, NULL);

    comReadOverlapped.Offset = 0;
	comReadOverlapped.OffsetHigh = 0;
	comReadOverlapped.hEvent = comReadEvent;
	comReadOverlappedLast = comReadOverlapped;

 	comWriteOverlapped.Offset = 0;
	comWriteOverlapped.OffsetHigh = 0;
	comWriteOverlapped.hEvent = comWriteEvent;

    threadRun = 1;
    thread = CreateThread(NULL, 0, ThreadProc, this, 0, &threadId);

    return 0;
}

int CDlgComm::comClose()
{
    threadRun = 0;
    SetEvent(comReadEvent);

    CloseHandle(comHdl);

    CloseHandle(comReadEvent);
    CloseHandle(comWriteEvent);


    return 0;
}

int CDlgComm::comWrite(const unsigned char *data, int len)
{
    DWORD w;

    WriteFile(comHdl, data, len, &w, &comWriteOverlapped);
    return len;
}

DWORD WINAPI CDlgComm::ThreadProc(LPVOID param)
{
    return ((CDlgComm *)param)->threadProc();
}

DWORD WINAPI CDlgComm::threadProc()
{
    unsigned char data[2048]; 
    DWORD len;
    DWORD sig;
    CommPostData *commPostData;
    
    while(threadRun) { // thread loop
        //comReadOverlapped.Offset = 0;
        //comReadOverlapped.OffsetHigh = 0;
        ReadFile(comHdl, data, 2048, &len, &comReadOverlapped);
        //DWORD err;
        //COMSTAT stat;
        //ClearCommError(comHdl, &err, &stat);
        
        //ResetEvent(comReadEvent);
        sig = WaitForSingleObject(comReadEvent, INFINITE);
        if(threadRun == 0)
            break;
        if(GetOverlappedResult(comHdl, &comReadOverlapped, &len, FALSE) == 0) {
            MessageError("GetOverlappedResult:");
        }

        if( sig == WAIT_ABANDONED) {
            break;
        } else if( sig == WAIT_OBJECT_0) {
            if(len != 0) {
                commPostData = (CommPostData *) malloc(2+len);
                commPostData->len = (unsigned short)len;
                memcpy(commPostData->data, data, len);

                PostMessage(WM_COMM_RCV, (WPARAM) commPostData, 0);
            }
            //ResetEvent(comReadEvent);
        } else {
            MessageError("thread event???");
        }
    }
    threadRun = 0;
    return 0;
}

void CDlgComm::MessageError(const char *text) {
    CString str;
    char *lpMsgBuf;

    FormatMessage(
        FORMAT_MESSAGE_ALLOCATE_BUFFER |
        FORMAT_MESSAGE_FROM_SYSTEM |
        FORMAT_MESSAGE_IGNORE_INSERTS,
        NULL,
        GetLastError(),
        MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // 既定の言語
        (LPTSTR) &lpMsgBuf,
        0,
        NULL);
    
    // 文字列を表示する。
    str = text;
    str += lpMsgBuf;
    MessageBox(str, "Error", MB_OK | MB_ICONINFORMATION);
    
    // バッファを解放する。
    LocalFree(lpMsgBuf);
}    

