// TcpClientDlg.cpp : インプリメンテーション ファイル
//

#include "stdafx.h"
#include "CommRelay.h"
#include "CommRelayDlg.h"
#include "PortDlg.h"
#include "TcpClientDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CTcpClientDlg ダイアログ


CTcpClientDlg::CTcpClientDlg(CCommRelayDlg* pParent /*=NULL*/)
	: CPortDlg(CTcpClientDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CTcpClientDlg)
		// メモ - ClassWizard はこの位置にマッピング用のマクロを追加または削除します。
	//}}AFX_DATA_INIT
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}


void CTcpClientDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CTcpClientDlg)
	DDX_Control(pDX, IDC_EDIT_STATUS, m_edit_status);
	DDX_Control(pDX, IDC_EDIT_SEND_LINK, m_edit_send_link);
	DDX_Control(pDX, IDC_EDIT_SEND, m_edit_send);
	DDX_Control(pDX, IDC_EDIT_RECEIVE_LINK, m_edit_receive_link);
	DDX_Control(pDX, IDC_EDIT_RECEIVE, m_edit_receive);
	DDX_Control(pDX, IDC_EDIT_HOST, m_edit_host);
	DDX_Control(pDX, IDC_EDIT_CONNECT_LINK, m_edit_connect_link);
	DDX_Control(pDX, IDC_CHECK_CONNECT, m_check_connect);
	DDX_Control(pDX, IDC_BUTTON_SEND, m_button_send);
	DDX_Control(pDX, IDC_EDIT_PORT, m_edit_port);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CTcpClientDlg, CDialog)
	//{{AFX_MSG_MAP(CTcpClientDlg)
	ON_WM_CLOSE()
	ON_BN_CLICKED(IDC_CHECK_CONNECT, OnCheckConnect)
	ON_BN_CLICKED(IDC_BUTTON_SEND, OnButtonSend)
	ON_MESSAGE(WM_SOCK_RCV, WmSockRcv)
	ON_EN_CHANGE(IDC_EDIT_CONNECT_LINK, OnChangeEditConnectLink)
	ON_EN_CHANGE(IDC_EDIT_RECEIVE_LINK, OnChangeEditReceiveLink)
	ON_EN_CHANGE(IDC_EDIT_SEND_LINK, OnChangeEditSendLink)
	//}}AFX_MSG_MAP
    ON_WM_TIMER()
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CTcpClientDlg メッセージ ハンドラ

BOOL CTcpClientDlg::OnInitDialog() 
{
    CString name;

	CDialog::OnInitDialog();
	
    SetIcon(m_hIcon, TRUE);			// 大きいアイコンを設定
	SetIcon(m_hIcon, FALSE);		// 小さいアイコンを設定

    // TODO: この位置に初期化の補足処理を追加してください
    name.Format("Port %d : TCP Client", portIdx);
    SetWindowText(name);
    sock.setId(m_hWnd); 
    parent->notifStatus(portIdx, "[TCP Client] close");
    stat = TCPC_CLOSE;
    m_edit_status.SetWindowText("close");
    m_edit_host.SetWindowText("localhost");
    m_edit_port.SetWindowText("23");
    m_edit_connect_link.SetWindowText("0");
    m_edit_send_link.SetWindowText("0");
    m_edit_receive_link.SetWindowText("0");

    return TRUE;  // コントロールにフォーカスを設定しないとき、戻り値は TRUE となります
	              // 例外: OCX プロパティ ページの戻り値は FALSE となります
}

void CTcpClientDlg::OnClose() 
{
    ShowWindow(SW_HIDE);
	//CDialog::OnClose();
}

void CTcpClientDlg::OnCheckConnect() 
{
    CString hostName, portStr;
    UINT port;

    if(m_check_connect.GetCheck()) {
        if(stat == TCPC_CLOSE) {
            m_edit_host.GetWindowText(hostName);
            m_edit_port.GetWindowText(portStr);
            port = atoi(portStr);
            sock.Close();
            if(sock.Create() == 0) {
                AfxMessageBox("Fail : socket create");
                return;
            }
            if(sock.Connect(hostName, port) == 0) {
                AfxMessageBox("Fail: socket connect");
                return;
            }
            stat = TCPC_CONNECT;
            m_edit_status.SetWindowText("connect");
            parent->notifStatus(portIdx, "[TCP Client] connect");
            parent->notifConnect(portIdx, rlyIdConnect);
            m_button_send.EnableWindow(TRUE);
            m_edit_host.EnableWindow(FALSE);
            m_edit_port.EnableWindow(FALSE);
        }
    }
    else {
        if(stat == TCPC_CONNECT) {
            sock.Close();
            stat = TCPC_CLOSE;
            m_edit_status.SetWindowText("close");
            parent->notifStatus(portIdx, "[TCP Client] close");
            if(rlyIdConnect != 0)
                parent->notifDisconnect(portIdx, rlyIdConnect);
            m_button_send.EnableWindow(FALSE);
            m_edit_host.EnableWindow(TRUE);
            m_edit_port.EnableWindow(TRUE);
            stat = TCPC_CLOSE;
        }
    }
}

LRESULT CTcpClientDlg::WmSockRcv(WPARAM w, LPARAM l)
{
    RcvData *msg;

    msg = (RcvData *) w;

    switch(msg->type) {
    case SOCK_CLOSE:
        if(stat == TCPC_CONNECT) {
            sock.Close();
            m_edit_status.SetWindowText("close");
            m_button_send.EnableWindow(FALSE);
            m_edit_host.EnableWindow(TRUE);
            m_edit_port.EnableWindow(TRUE);
            stat = TCPC_CLOSE;
            m_check_connect.SetCheck(0);
            if(rlyIdConnect != 0)
                parent->notifDisconnect(portIdx, rlyIdConnect);
            parent->notifStatus(portIdx, "[TCP Client] close");
        }
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

void CTcpClientDlg::sndData(const char *a_data, int a_len)
{
    if(stat != TCPC_CONNECT) {
        return;
    }

    sock.Send(a_data, a_len);
    parent->notifSndData(portIdx, a_data, a_len);

    dispSndData(a_data, a_len);
}

void CTcpClientDlg::rcvData(const char *a_data, int a_len)
{
    parent->notifRcvData(portIdx, a_data, a_len, rlyIdRcv);

    dispRcvData(a_data, a_len);
}

void CTcpClientDlg::OnButtonSend() 
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

void CTcpClientDlg::OnChangeEditConnectLink() 
{
    char str[16];

    m_edit_connect_link.GetWindowText(str, 16);
    rlyIdConnect = atoi(str);
}

void CTcpClientDlg::OnChangeEditReceiveLink() 
{
    char str[16];

    m_edit_receive_link.GetWindowText(str, 16);
    rlyIdRcv = atoi(str);
}

void CTcpClientDlg::OnChangeEditSendLink() 
{
    char str[16];

    m_edit_send_link.GetWindowText(str, 16);
    rlyIdSnd = atoi(str);
}

void CTcpClientDlg::connect()
{
    CString hostName, portStr;
    UINT port;

    if(stat == TCPC_CLOSE) {
        m_edit_host.GetWindowText(hostName);
        m_edit_port.GetWindowText(portStr);
        port = atoi(portStr);
        if(sock.Create() == 0) {
            AfxMessageBox("Fail : socket create");
            return;
        }
        if(sock.Connect(hostName, port) == 0) {
            AfxMessageBox("Fail: socket connect");
            return;
        }
        stat = TCPC_CONNECT;
        m_edit_status.SetWindowText("connect");
        m_button_send.EnableWindow(TRUE);
        m_edit_host.EnableWindow(FALSE);
        m_edit_port.EnableWindow(FALSE);
        m_check_connect.SetCheck(1);
        parent->notifStatus(portIdx, "[TCP Client] connect");
        parent->notifConnect(portIdx, rlyIdConnect);
    }
}

void CTcpClientDlg::disconnect()
{
    if(stat == TCPC_CONNECT) {
        sock.Close();
        m_edit_status.SetWindowText("close");
        m_button_send.EnableWindow(FALSE);
        m_edit_host.EnableWindow(TRUE);
        m_edit_port.EnableWindow(TRUE);
        stat = TCPC_CLOSE;
        m_check_connect.SetCheck(0);
        parent->notifDisconnect(portIdx, rlyIdConnect);
        parent->notifStatus(portIdx, "[TCP Client] close");
    }
}
