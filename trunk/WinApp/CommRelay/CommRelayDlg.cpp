// CommRelayDlg.cpp : インプリメンテーション ファイル
//

#include "stdafx.h"
#include "CommRelay.h"
#include "CommRelayDlg.h"
#include "PortDlg.h"
#include "TcpDlg.h"
#include "TcpClientDlg.h"
#include "UdpDlg.h"
#include "DlgComm.h"
#include <mmsystem.h>

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// アプリケーションのバージョン情報で使われている CAboutDlg ダイアログ

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// ダイアログ データ
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard は仮想関数のオーバーライドを生成します
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV のサポート
	//}}AFX_VIRTUAL

// インプリメンテーション
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// メッセージ ハンドラがありません。
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCommRelayDlg ダイアログ

CCommRelayDlg::CCommRelayDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CCommRelayDlg::IDD, pParent),
    m_initialized(false),
    m_logDispCheck(false),
    m_logFileCheck(false)
{
	//{{AFX_DATA_INIT(CCommRelayDlg)
		// メモ: この位置に ClassWizard によってメンバの初期化が追加されます。
	//}}AFX_DATA_INIT
	// メモ: LoadIcon は Win32 の DestroyIcon のサブシーケンスを要求しません。
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);

    m_eventLogList = NULL;
    m_eventLogListTail = &m_eventLogList;


    m_logFileName[0] = '\0';
}

void CCommRelayDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CCommRelayDlg)
	DDX_Control(pDX, IDC_RICHEDIT_LOG, m_richedit_log);
	DDX_Control(pDX, IDC_CHECK_FILE, m_check_file);
	DDX_Control(pDX, IDC_EDIT_FILE, m_edit_file);
	DDX_Control(pDX, IDC_LIST_PORT, m_listPort);
	DDX_Control(pDX, IDC_CHECK_LOG, m_check_log);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CCommRelayDlg, CDialog)
	//{{AFX_MSG_MAP(CCommRelayDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON_LOG_CLEAR, OnButtonLogClear)
	ON_BN_CLICKED(IDC_BUTTON_ADD_TCP_PORT, OnButtonAddTcpPort)
	ON_LBN_DBLCLK(IDC_LIST_PORT, OnDblclkListPort)
	ON_BN_CLICKED(IDC_BUTTON_ADD_TCP_CLIENT_PORT, OnButtonAddTcpClientPort)
	ON_BN_CLICKED(IDC_BUTTON_ADD_UDP_PORT, OnButtonAddUdpPort)
	ON_WM_GETMINMAXINFO()
	ON_WM_SIZE()
	ON_BN_CLICKED(IDC_BUTTON_COM, OnButtonCom)
	ON_BN_CLICKED(IDC_CHECK_FILE, OnCheckFile)
	ON_BN_CLICKED(IDC_BUTTON_FILE, OnButtonFile)
	ON_EN_CHANGE(IDC_EDIT_FILE, OnChangeEditFile)
	//}}AFX_MSG_MAP
    ON_BN_CLICKED(IDC_CHECK_LOG, &CCommRelayDlg::OnBnClickedCheckLog)
    ON_WM_TIMER()
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCommRelayDlg メッセージ ハンドラ

BOOL CCommRelayDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// "バージョン情報..." メニュー項目をシステム メニューへ追加します。

	// IDM_ABOUTBOX はコマンド メニューの範囲でなければなりません。
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// このダイアログ用のアイコンを設定します。フレームワークはアプリケーションのメイン
	// ウィンドウがダイアログでない時は自動的に設定しません。
	SetIcon(m_hIcon, TRUE);			// 大きいアイコンを設定
	SetIcon(m_hIcon, FALSE);		// 小さいアイコンを設定
	
	// TODO: 特別な初期化を行う時はこの場所に追加してください。
    init();

	return TRUE;  // TRUE を返すとコントロールに設定したフォーカスは失われません。
}

void CCommRelayDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// もしダイアログボックスに最小化ボタンを追加するならば、アイコンを描画する
// コードを以下に記述する必要があります。MFC アプリケーションは document/view
// モデルを使っているので、この処理はフレームワークにより自動的に処理されます。

void CCommRelayDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // 描画用のデバイス コンテキスト

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// クライアントの矩形領域内の中央
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// アイコンを描画します。
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// システムは、ユーザーが最小化ウィンドウをドラッグしている間、
// カーソルを表示するためにここを呼び出します。
HCURSOR CCommRelayDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}


void CCommRelayDlg::OnButtonAddTcpPort() 
{
    CString portName;
    int itemNo;
    CTcpDlg *tcpDlg;

    portName.Format("port %d [TCP Server]", m_portNum);
    itemNo = m_listPort.InsertString(-1, portName);

    tcpDlg = new CTcpDlg(this);
    tcpDlg->setPortIdx(m_portNum);
    tcpDlg->Create(IDD_DIALOG_TCP, GetDesktopWindow());
    tcpDlg->ShowWindow(SW_SHOW);
    m_listPort.SetItemData(itemNo, (DWORD)tcpDlg);

    m_portNum ++;
}

void CCommRelayDlg::OnButtonAddTcpClientPort() 
{
    CString portName;
    int itemNo;
    CTcpClientDlg *tcpDlg;

    portName.Format("port %d [TCP Client]", m_portNum);
    itemNo = m_listPort.InsertString(-1, portName);

    tcpDlg = new CTcpClientDlg(this);
    tcpDlg->setPortIdx(m_portNum);
    tcpDlg->Create(IDD_DIALOG_TCP_CLIENT, GetDesktopWindow());
    tcpDlg->ShowWindow(SW_SHOW);
    m_listPort.SetItemData(itemNo, (DWORD)tcpDlg);

    m_portNum ++;
}

void CCommRelayDlg::OnButtonAddUdpPort() 
{
    CString portName;
    int itemNo;
    CUdpDlg *udpDlg;

    portName.Format("port %d [UDP]", m_portNum);
    itemNo = m_listPort.InsertString(-1, portName);

    udpDlg = new CUdpDlg(this);
    udpDlg->setPortIdx(m_portNum);
    udpDlg->Create(IDD_DIALOG_UDP, GetDesktopWindow());
    udpDlg->ShowWindow(SW_SHOW);
    m_listPort.SetItemData(itemNo, (DWORD)udpDlg);

    m_portNum ++;
}

void CCommRelayDlg::OnButtonCom() 
{
    CString portName;
    int itemNo;
    CDlgComm *commDlg;

    portName.Format("port %d [COM]", m_portNum);
    itemNo = m_listPort.InsertString(-1, portName);

    commDlg = new CDlgComm(this);
    commDlg->setPortIdx(m_portNum);
    commDlg->Create(IDD_DIALOG_COMM, GetDesktopWindow());
    commDlg->ShowWindow(SW_SHOW);
    m_listPort.SetItemData(itemNo, (DWORD)commDlg);

    m_portNum ++;
}

void CCommRelayDlg::OnDblclkListPort() 
{
    int item;
    CPortDlg *portDlg;

    item = m_listPort.GetCurSel();
    
    portDlg = (CPortDlg *)m_listPort.GetItemData(item);

    portDlg->ShowWindow(SW_SHOW);
	
}

void CCommRelayDlg::notifRcvData(int port, const char *data, int len, int relayId)
{
    eventContainer* newNode;

    newNode = (eventContainer *)malloc(sizeof(eventContainer)+len);
    newNode->m_port = port;
    newNode->m_evnt = eRcv;
    newNode->m_time = timeGetTime();
    newNode->m_len  = len;
    memcpy(newNode->m_data, data, len);
    newNode->m_next = NULL;

    *m_eventLogListTail = newNode;
    m_eventLogListTail = &(newNode->m_next);

    KillTimer(EVENT_WRITE_LOG);
    SetTimer(EVENT_WRITE_LOG, LOG_LAG, NULL);

    if(relayId != 0) {
        for(int i = 0; i < m_portNum; i++) {
            CPortDlg *portDlg;
            portDlg = (CPortDlg *)m_listPort.GetItemData(i);
            portDlg->rlySndData(relayId, data, len);
        }
    }
}

void CCommRelayDlg::notifSndData(int port, const char *data, int len)
{
    eventContainer* newNode;

    newNode = (eventContainer *)malloc(sizeof(eventContainer)+len);
    newNode->m_port = port;
    newNode->m_evnt = eSnd;
    newNode->m_time = timeGetTime();
    newNode->m_len  = len;
    memcpy(newNode->m_data, data, len);
    newNode->m_next = NULL;

    *m_eventLogListTail = newNode;
    m_eventLogListTail = &(newNode->m_next);

    KillTimer(EVENT_WRITE_LOG);
    SetTimer(EVENT_WRITE_LOG, LOG_LAG, NULL);
}

void CCommRelayDlg::notifConnect(int port, int rlyId)
{
    eventContainer* newNode;

    newNode = (eventContainer *)malloc(sizeof(eventContainer));
    newNode->m_port = port;
    newNode->m_evnt = eCnct;
    newNode->m_time = timeGetTime();
    newNode->m_len  = 0;
    newNode->m_next = NULL;

    *m_eventLogListTail = newNode;
    m_eventLogListTail = &(newNode->m_next);

    KillTimer(EVENT_WRITE_LOG);
    SetTimer(EVENT_WRITE_LOG, LOG_LAG, NULL);

    if(rlyId != 0) {
        for(int i = 0; i < m_portNum; i++) {
            CPortDlg *portDlg;
            portDlg = (CPortDlg *)m_listPort.GetItemData(i);
            portDlg->rlyConnect(rlyId);
        }
    }
}

void CCommRelayDlg::notifDisconnect(int port, int rlyId)
{
    eventContainer* newNode;

    newNode = (eventContainer *)malloc(sizeof(eventContainer));
    newNode->m_port = port;
    newNode->m_evnt = eDiscnct;
    newNode->m_time = timeGetTime();
    newNode->m_len  = 0;
    newNode->m_next = NULL;

    *m_eventLogListTail = newNode;
    m_eventLogListTail = &(newNode->m_next);

    KillTimer(EVENT_WRITE_LOG);
    SetTimer(EVENT_WRITE_LOG, LOG_LAG, NULL);

    if(rlyId != 0) {
        for(int i = 0; i < m_portNum; i++) {
            CPortDlg *portDlg;
            portDlg = (CPortDlg *)m_listPort.GetItemData(i);
            portDlg->rlyDisconnect(rlyId);
        }
    }
}

void CCommRelayDlg::notifStatus(int port, const char *text)
{
    CString portName;
    DWORD portDlg;

    portName.Format("port %d:%s", port, text);

    portDlg = m_listPort.GetItemData(port);
    m_listPort.DeleteString(port);
    m_listPort.InsertString(port,portName);
    m_listPort.SetItemData(port, portDlg);
}

void CCommRelayDlg::OnGetMinMaxInfo(MINMAXINFO FAR* lpMMI) 
{
	if (m_hWnd) {
        lpMMI->ptMinTrackSize.x = m_szMin.cx;
        lpMMI->ptMinTrackSize.y = m_szMin.cy;
    }
	
	CDialog::OnGetMinMaxInfo(lpMMI);
}

void CCommRelayDlg::OnSize(UINT nType, int cx, int cy) 
{
    CRect rc;

    CDialog::OnSize(nType, cx, cy);

    if(m_initialized) {
        GetClientRect(&rc);

        m_richedit_log.MoveWindow(m_logRect.left, m_logRect.top, 
            rc.right-m_dlgRect.right+m_logRect.right-m_logRect.left,
            rc.bottom-m_dlgRect.bottom+m_logRect.bottom-m_logRect.top);
    }
}


void CCommRelayDlg::OnCheckFile() 
{
    m_logFileCheck = (m_check_file.GetCheck() != 0);
    if(m_logFileCheck) {
        if(m_logFileName[0] == '\0') {
            m_logFileCheck = 0;
            m_check_file.SetCheck(0);
        }
    }
}

void CCommRelayDlg::OnButtonFile() 
{

    CString fileName;
    CFileDialog dlg(FALSE);

    if(dlg.DoModal() == IDCANCEL)
        return;

    fileName = dlg.GetPathName();
    m_edit_file.SetWindowText(fileName);
}

void CCommRelayDlg::OnChangeEditFile() 
{
    m_edit_file.GetWindowText(m_logFileName, 1024);	
    if(m_logFileName[0] == '\0') {
        m_logFileCheck = 0;
        m_check_file.SetCheck(0);
        m_check_file.EnableWindow(FALSE);
    }
    else {
        m_check_file.EnableWindow(TRUE);
    }
}

void CCommRelayDlg::OnBnClickedCheckLog()
{
    m_logDispCheck = (m_check_log.GetCheck() != 0);
}

void CCommRelayDlg::OnTimer(UINT_PTR nIDEvent)
{
    switch(nIDEvent) {
        case EVENT_WRITE_LOG:
            KillTimer(EVENT_WRITE_LOG);
            if(m_eventLogList != NULL) {
                eventContainer* node;
                node = m_eventLogList;
                m_eventLogList = node->m_next;
                if(m_eventLogList == NULL)
                    m_eventLogListTail = &m_eventLogList;
                timerWrite(node);
                free(node);
                SetTimer(EVENT_WRITE_LOG, LOG_LAG, NULL);
            }
            break;
        default:
        CDialog::OnTimer(nIDEvent);
    }
}

void CCommRelayDlg::timerWrite(eventContainer* node) 
{
    CString str, tmp;
    DWORD timeDiff = node->m_time - m_startTime;

    switch(node->m_evnt) {
        case eCnct:
            str.Format("%d.%03d port%d Cnct\r\n", timeDiff/1000, timeDiff%1000, node->m_port);
            break;
        case eDiscnct:
            str.Format("%d.%03d port%d Discnct\r\n", timeDiff/1000, timeDiff%1000, node->m_port);
            break;
        case eSnd:
            str.Format("%d.%03d port%d Snd\r\n", timeDiff/1000, timeDiff%1000, node->m_port);
            break;
        case eRcv:
            str.Format("%d.%03d port%d Rcv\r\n", timeDiff/1000, timeDiff%1000, node->m_port);
            break;
    }
    switch(node->m_evnt) {
        case eRcv:
        case eSnd:
            for(int i = 0; i < node->m_len; i++) {
                if(i == node->m_len -1)
                    tmp.Format("%02X\r\n", ((const unsigned char *)node->m_data)[i]);
                else
                    tmp.Format("%02X,", ((const unsigned char *)node->m_data)[i]);

                str = str + tmp;
            }
            break;
    }
    printLog(str);
}

