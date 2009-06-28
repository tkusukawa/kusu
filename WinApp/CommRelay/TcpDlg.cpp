// TcpDlg.cpp : インプリメンテーション ファイル
//

#include "stdafx.h"
#include "CommRelay.h"
#include "CommRelayDlg.h"
#include "PortDlg.h"
#include "TcpDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CTcpDlg ダイアログ


CTcpDlg::CTcpDlg(CCommRelayDlg* pParent /*=NULL*/)
	: CPortDlg(CTcpDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CTcpDlg)
	//}}AFX_DATA_INIT
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}


void CTcpDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CTcpDlg)
	DDX_Control(pDX, IDC_CHECK_LISTEN, m_checkListen);
	DDX_Control(pDX, IDC_EDIT_RECEIVE, m_edit_receive);
	DDX_Control(pDX, IDC_EDIT_RELAY_C, m_edit_relay_c);
	DDX_Control(pDX, IDC_EDIT_RELAY_RECEIVE, m_edit_relay_receive);
	DDX_Control(pDX, IDC_EDIT_RELAY_SEND, m_edit_relay_send);
	DDX_Control(pDX, IDC_EDIT_SEND, m_edit_send);
	DDX_Control(pDX, IDC_EDIT_STATUS, m_edit_status);
	DDX_Control(pDX, IDC_BUTTON_CLOSE, m_button_close);
	DDX_Control(pDX, IDC_EDIT_PORT, m_edit_port);
	DDX_Control(pDX, IDC_BUTTON_SEND, m_button_send);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CTcpDlg, CDialog)
	//{{AFX_MSG_MAP(CTcpDlg)
	ON_WM_CLOSE()
	ON_WM_SIZE()
	ON_BN_CLICKED(IDC_BUTTON_CLOSE, OnButtonClose)
	ON_BN_CLICKED(IDC_BUTTON_SEND, OnButtonSend)
	ON_EN_CHANGE(IDC_EDIT_RELAY_C, OnChangeEditRelayC)
	ON_EN_CHANGE(IDC_EDIT_RELAY_RECEIVE, OnChangeEditRelayReceive)
	ON_EN_CHANGE(IDC_EDIT_RELAY_SEND, OnChangeEditRelaySend)
	ON_MESSAGE(WM_SOCK_RCV, WmSockRcv)
	ON_BN_CLICKED(IDC_CHECK_LISTEN, OnCheckListen)
	//}}AFX_MSG_MAP
    ON_WM_TIMER()
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CTcpDlg メッセージ ハンドラ
BOOL CTcpDlg::OnInitDialog()
{
    CString name;

	CDialog::OnInitDialog();

    SetIcon(m_hIcon, TRUE);			// 大きいアイコンを設定
	SetIcon(m_hIcon, FALSE);		// 小さいアイコンを設定

    // TODO: 特別な初期化を行う時はこの場所に追加してください。
    name.Format("Port %d : TCP Server", portIdx);
    SetWindowText(name);
    sock.setId(m_hWnd); 
    parent->notifStatus(portIdx, "[TCP Server] close");
    m_edit_status.SetWindowText("close");
    m_edit_port.SetWindowText("23");
    m_edit_relay_c.SetWindowText("0");
    m_edit_relay_send.SetWindowText("0");
    m_edit_relay_receive.SetWindowText("0");

	return TRUE;  // TRUE を返すとコントロールに設定したフォーカスは失われません。
}

void CTcpDlg::OnClose() 
{
    ShowWindow(SW_HIDE);
	//CDialog::OnClose();
}

void CTcpDlg::OnSize(UINT nType, int cx, int cy) 
{
	CDialog::OnSize(nType, cx, cy);
}

void CTcpDlg::OnCheckListen() 
{
    UINT port;
    CString strPort;

    if(sock.accepter != NULL) // accept
        return;

    if(m_checkListen.GetCheck() == 0) {
        sock.Close();
        parent->notifStatus(portIdx, "[TCP Server] close");
        m_edit_status.SetWindowText("close");
        m_button_send.EnableWindow(FALSE);
        m_button_close.EnableWindow(FALSE);
        m_edit_port.EnableWindow(TRUE);
        return;
    }

    m_edit_port.GetWindowText(strPort);
    port = atoi(strPort);
    if(sock.Create(port) == 0) {
        AfxMessageBox("Fail : Socket Create");
        return;
    }
    if(sock.Listen() == 0) {
        AfxMessageBox("Fail : Socket Listen");
        return;
    }

    m_edit_port.EnableWindow(FALSE);
    parent->notifStatus(portIdx, "[TCP Server] listen");
    m_edit_status.SetWindowText("listen");
}

LRESULT CTcpDlg::WmSockRcv(WPARAM w, LPARAM l)
{
    RcvData *msg;

    msg = (RcvData *) w;

    switch(msg->type) {
    case SOCK_ACCEPT:
        if(rlyIdConnect != 0)
            parent->notifConnect(portIdx, rlyIdConnect);
        parent->notifStatus(portIdx, "[TCP Server] accept");
        m_edit_status.SetWindowText("accept");
        m_button_send.EnableWindow(TRUE);
        m_button_close.EnableWindow(TRUE);
        break;
    case SOCK_CLOSE:
        sock.Close();
        
        if(rlyIdConnect != 0)
            parent->notifDisconnect(portIdx, rlyIdConnect);
        parent->notifStatus(portIdx, "[TCP Server] close");
        m_edit_status.SetWindowText("close");
        m_button_send.EnableWindow(FALSE);
        m_button_close.EnableWindow(FALSE);
        m_edit_port.EnableWindow(TRUE);

        OnCheckListen();
            
        break;
    case SOCK_RCV:
        rcvData(msg->data, msg->len);
        break;
    default:
        
        AfxMessageBox("@@@@@@");
        break;
    }

    
    free(msg);
    return 0;
}


void CTcpDlg::OnButtonClose() 
{
    m_checkListen.SetCheck(0);
    if(rlyIdConnect != 0)
        parent->notifDisconnect(portIdx, rlyIdConnect);
    sock.Close();
    parent->notifStatus(portIdx, "[TCP Server] close");
    m_edit_status.SetWindowText("close");
    m_button_send.EnableWindow(FALSE);
    m_button_close.EnableWindow(FALSE);
    m_edit_port.EnableWindow(TRUE);
}

void CTcpDlg::OnButtonSend() 
{
    int strP, i, len;
	char c, str[4096], data[1024];

    m_edit_send.GetWindowText(str, 4095);
	strP = 0;
	i = 0;
    len = 0;
	while((i < 1024) && (strP < 4096)) {
		c = str[strP++];

		if(c == '\0')
			break; // 文字列の終端で終了

		if((c >= '0') && (c <= '9')) {
			data[i] <<= 4;
			data[i] += c - '0';
            len = i + 1;
		}
		else if((c >= 'A') && (c <= 'F')) {
			data[i] <<= 4;
			data[i] += c - 'A' + 10;
            len = i + 1;
		}
		else if((c >= 'a') && (c <= 'f')) {
			data[i] <<= 4;
			data[i] += c - 'a' + 10;
            len = i + 1;
		}
		else {
			i ++;
		}
	}

    sndData(data, len);
}

void CTcpDlg::sndData(const char *a_data, int a_len)
{
    if(sock.accepter == NULL) {
        //AfxMessageBox("not connected");
        return;
    }
    sock.accepter->Send(a_data, a_len);
    parent->notifSndData(portIdx, a_data, a_len);

    dispSndData(a_data, a_len);
}

void CTcpDlg::rcvData(const char *a_data, int a_len)
{
    parent->notifRcvData(portIdx, a_data, a_len, rlyIdRcv);

    dispRcvData(a_data, a_len);
}

void CTcpDlg::OnChangeEditRelayC() 
{
    char str[16];

    m_edit_relay_c.GetWindowText(str, 16);
    rlyIdConnect = atoi(str);
}

void CTcpDlg::OnChangeEditRelayReceive() 
{
    char str[16];

    m_edit_relay_receive.GetWindowText(str, 16);
    rlyIdRcv = atoi(str);
}

void CTcpDlg::OnChangeEditRelaySend() 
{
    char str[16];

    m_edit_relay_send.GetWindowText(str, 16);
    rlyIdSnd = atoi(str);
}

void CTcpDlg::disconnect()
{
    if(sock.accepter != NULL) {
        sock.Close();
        
        m_edit_status.SetWindowText("close");
        m_button_send.EnableWindow(FALSE);
        m_button_close.EnableWindow(FALSE);
        m_edit_port.EnableWindow(TRUE);
        parent->notifDisconnect(portIdx, rlyIdConnect);
        parent->notifStatus(portIdx, "[TCP Server] close");
        
        OnCheckListen();
    }
}

