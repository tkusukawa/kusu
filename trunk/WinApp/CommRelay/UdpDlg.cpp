// UdpDlg.cpp : インプリメンテーション ファイル
//

#include "stdafx.h"
#include "CommRelay.h"
#include "CommRelayDlg.h"
#include "PortDlg.h"
#include "UdpDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CUdpDlg ダイアログ


CUdpDlg::CUdpDlg(CCommRelayDlg* pParent /*=NULL*/)
	: CPortDlg(CUdpDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CUdpDlg)
		// メモ - ClassWizard はこの位置にマッピング用のマクロを追加または削除します。
	//}}AFX_DATA_INIT
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}


void CUdpDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CUdpDlg)
	DDX_Control(pDX, IDC_EDIT_OWN_ADDR, m_edit_own_addr);
	DDX_Control(pDX, IDC_EDIT_SEND_LINK, m_edit_send_link);
	DDX_Control(pDX, IDC_EDIT_SEND, m_edit_send);
	DDX_Control(pDX, IDC_EDIT_RECEIVE_LINK, m_edit_receive_link);
	DDX_Control(pDX, IDC_EDIT_RECEIVE, m_edit_receive);
	DDX_Control(pDX, IDC_EDIT_OWN_PORT, m_edit_own_port);
	DDX_Control(pDX, IDC_EDIT_DEST_PORT, m_edit_dest_port);
	DDX_Control(pDX, IDC_EDIT_DEST_HOST, m_edit_dest_host);
	DDX_Control(pDX, IDC_CHECK_BIND, m_check_bind);
	DDX_Control(pDX, IDC_BUTTON_SEND, m_button_send);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CUdpDlg, CDialog)
	//{{AFX_MSG_MAP(CUdpDlg)
	ON_WM_CLOSE()
	ON_BN_CLICKED(IDC_CHECK_BIND, OnCheckBind)
	ON_BN_CLICKED(IDC_BUTTON_SEND, OnButtonSend)
	ON_MESSAGE(WM_SOCK_RCV, WmSockRcv)
	ON_EN_CHANGE(IDC_EDIT_RECEIVE_LINK, OnChangeEditReceiveLink)
	ON_EN_CHANGE(IDC_EDIT_SEND_LINK, OnChangeEditSendLink)
	//}}AFX_MSG_MAP
    ON_WM_TIMER()
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CUdpDlg メッセージ ハンドラ

BOOL CUdpDlg::OnInitDialog() 
{
    CString name;

    CDialog::OnInitDialog();
	
    SetIcon(m_hIcon, TRUE);			// 大きいアイコンを設定
	SetIcon(m_hIcon, FALSE);		// 小さいアイコンを設定

    // TODO: この位置に初期化の補足処理を追加してください
    name.Format("Port %d : UDP", portIdx);
    SetWindowText(name);
    parent->notifStatus(portIdx, "[UDP]");
    m_edit_dest_host.SetWindowText("localhost");
    m_edit_dest_port.SetWindowText("10012");
    m_edit_own_port.SetWindowText("10012");
    m_edit_send_link.SetWindowText("0");
    m_edit_receive_link.SetWindowText("0");
    sock.setId(m_hWnd); 
    sock.Create(0,SOCK_DGRAM);

    return TRUE;  // コントロールにフォーカスを設定しないとき、戻り値は TRUE となります
	              // 例外: OCX プロパティ ページの戻り値は FALSE となります
}

void CUdpDlg::OnClose() 
{
    ShowWindow(SW_HIDE);
	//CDialog::OnClose();
}

LRESULT CUdpDlg::WmSockRcv(WPARAM w, LPARAM l)
{
    RcvData *msg;

    msg = (RcvData *) w;

    switch(msg->type) {
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

void CUdpDlg::OnCheckBind() 
{
    CString portStr;
    UINT port;
    char ownAddr[1024], *ownAddrP;

    if(m_check_bind.GetCheck()) {
        m_edit_own_addr.GetWindowText(ownAddr, 1024);
        if(ownAddr[0] == '\0')
            ownAddrP = NULL;
        else
            ownAddrP = ownAddr;

        m_edit_own_port.GetWindowText(portStr);
        port = atoi(portStr);
        sock.Close();
        if(sock.Create(port, SOCK_DGRAM, ownAddrP) == 0) {
            port = sock.GetLastError();
            portStr.Format("Fail:socket bind:%d",port);
            AfxMessageBox(portStr);
            m_check_bind.SetCheck(0);
            return;
        }
        m_edit_own_port.EnableWindow(FALSE);
        m_edit_own_addr.EnableWindow(FALSE);
    }
    else {
        sock.Close();
        if(sock.Create(0,SOCK_DGRAM) == 0) {
            AfxMessageBox("Fail:socket bind");
            m_check_bind.SetCheck(0);
            return;
        }
        m_edit_own_port.EnableWindow(TRUE);
        m_edit_own_addr.EnableWindow(TRUE);

    }
}

void CUdpDlg::OnButtonSend() 
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

void CUdpDlg::sndData(const char *a_data, int a_len)
{
    CString host, port;
    UINT portN;

    m_edit_dest_host.GetWindowText(host);
    m_edit_dest_port.GetWindowText(port);
    portN = atoi(port);
    if(sock.SendTo(a_data, a_len, portN, host) == SOCKET_ERROR) {
        AfxMessageBox("Fail:socket sendTo");
        return;
    }

    parent->notifSndData(portIdx, a_data, a_len);

    dispSndData(a_data, a_len);
}

void CUdpDlg::rcvData(const char *a_data, int a_len)
{
    if(rlyIdRcv != 0) {
        parent->notifRcvData(portIdx, a_data, a_len, rlyIdRcv);
    }

    dispRcvData(a_data, a_len);
}

void CUdpDlg::OnChangeEditReceiveLink() 
{
    char str[16];

    m_edit_receive_link.GetWindowText(str, 16);
    rlyIdRcv = atoi(str);
}

void CUdpDlg::OnChangeEditSendLink() 
{
    char str[16];

    m_edit_send_link.GetWindowText(str, 16);
    rlyIdSnd = atoi(str);
}

