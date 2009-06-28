// GhostBoardDlg.cpp : 実装ファイル
//

#include "stdafx.h"
#include "GhostBoard.h"
#include "GhostBoardDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CGhostBoardDlg ダイアログ




CGhostBoardDlg::CGhostBoardDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CGhostBoardDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);

    // メンバ変数初期化
    m_leftDown = false;
    m_initialized = false;
    m_activate = true;
    m_activeKey = false;
    m_mouseDistance = 0;
    m_mouseDistanceFar = 100;
}

void CGhostBoardDlg::DoDataExchange(CDataExchange* pDX)
{
    CDialog::DoDataExchange(pDX);
    DDX_Control(pDX, IDC_EDIT, m_edit);
}

BEGIN_MESSAGE_MAP(CGhostBoardDlg, CDialog)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	//}}AFX_MSG_MAP
    ON_WM_ACTIVATE()
    ON_WM_SIZE()
    ON_WM_LBUTTONDOWN()
    ON_WM_LBUTTONUP()
    ON_WM_MOUSEMOVE()
    ON_WM_TIMER()
    ON_WM_DRAWCLIPBOARD()
    ON_WM_CHANGECBCHAIN()
    ON_WM_RBUTTONDOWN()
    ON_COMMAND(ID_MENU_CLOSE, &CGhostBoardDlg::OnMenuClose)
    ON_COMMAND(ID_MENU_MINIMIZE, &CGhostBoardDlg::OnMenuMinimize)
END_MESSAGE_MAP()


// CGhostBoardDlg メッセージ ハンドラ

BOOL CGhostBoardDlg::OnInitDialog()
{
//    ModifyStyleEx(WS_EX_APPWINDOW, WS_EX_TOOLWINDOW); // タスクバーに表示しない
//    ModifyStyleEx(WS_EX_TOOLWINDOW, WS_EX_APPWINDOW); // タスクバーに表示する
	CDialog::OnInitDialog();

	// このダイアログのアイコンを設定します。アプリケーションのメイン ウィンドウがダイアログでない場合、
	//  Framework は、この設定を自動的に行います。
	SetIcon(m_hIcon, TRUE);			// 大きいアイコンの設定
	SetIcon(m_hIcon, FALSE);		// 小さいアイコンの設定

    //---- 最小化ボタンの表示
    ModifyStyle(0, WS_MINIMIZEBOX);

    //---- クリップボードの監視
    m_nextClipboardViewerHandle = SetClipboardViewer();

    //---- 透明化
    SetViewState();

    //---- アクティブキー＆マウス位置の定期監視タイマースタート
    SetTimer(0, 100, NULL);

    //---- 初期化完了フラグ
    m_initialized = true;

    //---- 前状態の読み出し
    Load();

    SetWindowText(_T("GhostBoard"));


	return TRUE;  // フォーカスをコントロールに設定した場合を除き、TRUE を返します。
}

// ダイアログに最小化ボタンを追加する場合、アイコンを描画するための
//  下のコードが必要です。ドキュメント/ビュー モデルを使う MFC アプリケーションの場合、
//  これは、Framework によって自動的に設定されます。

void CGhostBoardDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // 描画のデバイス コンテキスト

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// クライアントの四角形領域内の中央
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// アイコンの描画
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// ユーザーが最小化したウィンドウをドラッグしているときに表示するカーソルを取得するために、
//  システムがこの関数を呼び出します。
HCURSOR CGhostBoardDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}

//************************************************** ESCキーの無効化
BOOL CGhostBoardDlg::PreTranslateMessage(MSG *pMsg)
{
    if(pMsg->message == WM_KEYDOWN){
        switch(pMsg->wParam){
        //case VK_RETURN:
        case VK_ESCAPE:
            return TRUE;
        default:
            break;
        }
    }

    return CDialog::PreTranslateMessage(pMsg); 
}

//************************************************** 移動とリサイズ
void CGhostBoardDlg::OnSize(UINT nType, int cx, int cy)
{
    CDialog::OnSize(nType, cx, cy);

    if(!m_initialized) 
        return;

    m_edit.MoveWindow(4,3,cx-7,cy-6);
}

void CGhostBoardDlg::OnLButtonDown(UINT nFlags, CPoint point)
{
    SetCapture();
    GetCursorPos(&m_leftDownCursorPos);
    GetWindowPlacement(&m_leftDownWindowPos);
    m_leftDown = true;
    

    CDialog::OnLButtonDown(nFlags, point);

    //-------------- マウスカーソルの変更
    HCURSOR lhCursor = AfxGetApp()->LoadStandardCursor(IDC_SIZEALL);
    SetCursor(lhCursor);
}

void CGhostBoardDlg::OnLButtonUp(UINT nFlags, CPoint point)
{
    m_leftDown = false;
    ReleaseCapture();

    CDialog::OnLButtonUp(nFlags, point);
}

void CGhostBoardDlg::OnMouseMove(UINT nFlags, CPoint point)
{
    //-------------- マウスカーソルの変更
    HCURSOR lhCursor = AfxGetApp()->LoadStandardCursor(IDC_SIZEALL);
    SetCursor(lhCursor);

    if(m_leftDown) {
        POINT nowCursorPos;
        WINDOWPLACEMENT newWindowPos;

        GetCursorPos(&nowCursorPos);
        newWindowPos = m_leftDownWindowPos;
        newWindowPos.rcNormalPosition.left += 
            nowCursorPos.x - m_leftDownCursorPos.x;
        newWindowPos.rcNormalPosition.right += 
            nowCursorPos.x - m_leftDownCursorPos.x;
        newWindowPos.rcNormalPosition.top += 
            nowCursorPos.y - m_leftDownCursorPos.y;
        newWindowPos.rcNormalPosition.bottom += 
            nowCursorPos.y - m_leftDownCursorPos.y;
        SetWindowPlacement(&newWindowPos);
    }

    CDialog::OnMouseMove(nFlags, point);
}

//************************************************** アクティブキーとマウス位置の監視
void CGhostBoardDlg::OnTimer(UINT_PTR nIDEvent)
{
    POINT mousePnt;
    WINDOWPLACEMENT windowPos;
    UINT dist, distX, distY;

    // マウス位置の監視
    GetCursorPos(&mousePnt);
    GetWindowPlacement(&windowPos);
    
    if(mousePnt.x < windowPos.rcNormalPosition.left) {
        distX = windowPos.rcNormalPosition.left - mousePnt.x;
    }
    else if(mousePnt.x > windowPos.rcNormalPosition.right) {
        distX = mousePnt.x - windowPos.rcNormalPosition.right;
    }
    else {
        distX = 0;
    }

    if(mousePnt.y < windowPos.rcNormalPosition.top) {
        distY = windowPos.rcNormalPosition.top - mousePnt.y;
    }
    else if(mousePnt.y > windowPos.rcNormalPosition.bottom) {
        distY = mousePnt.y - windowPos.rcNormalPosition.bottom;
    }
    else {
        distY = 0;
    }

    dist = distX + distY;
    if(dist > m_mouseDistanceFar)
        dist = m_mouseDistanceFar;

    if(dist != m_mouseDistance) {
        m_mouseDistance = dist;
        SetViewState();
    }

    // アクティブキーの監視
    if (::GetAsyncKeyState(VK_CONTROL) && ::GetAsyncKeyState(VK_MENU)) { // アクティブキーが押されているなら
        if(!m_activeKey) {
            m_activeKey = true;
            SetViewState();
        }
    }
    else{ // アクティブキーが離されているなら
        if(m_activeKey) {
            m_activeKey = false;
            SetViewState();
        }
    }

    CDialog::OnTimer(nIDEvent);
}


//************************************************** 透明化
void CGhostBoardDlg::SetViewState()
{
    if(m_activate || m_activeKey) {
        ModifyStyleEx(WS_EX_TRANSPARENT, 0);
        SetLayeredWindowAttributes(0, 255, LWA_ALPHA);
    }
    else {
        BYTE alpha;

        if(m_mouseDistance > m_mouseDistanceFar) {
            alpha = 200;
        }
        else {
            alpha = 50 + 150*m_mouseDistance/m_mouseDistanceFar;
        }
        ModifyStyleEx(0, WS_EX_LAYERED | WS_EX_TRANSPARENT);
        SetLayeredWindowAttributes(0, alpha, LWA_ALPHA);
    }
}

//*************************************************** ウィンドウフォーカスの監視
void CGhostBoardDlg::OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized)
{
    CDialog::OnActivate(nState, pWndOther, bMinimized);

    if(nState) {
        if(!m_activate) {
            m_activate = true;
            SetViewState();
        }
    }
    else {
        if(m_activate) {
            CString str;
            m_edit.GetWindowText(str);
            SetTextToClipboard(str);
            m_activate = false;
            SetViewState();

            Save();
        }
    }
}

//*************************************************** クリップボードの監視と書き込み
void CGhostBoardDlg::OnDrawClipboard()
{
    CDialog::OnDrawClipboard();
    static CString lastClip;

    for(int i = 0;; i++) {
        if(i >= 3) {
            m_edit.SetWindowText(_T("Open try out"));
            return;
        }
        if(OpenClipboard())
            break;

        Sleep(10);
    }

    if (IsClipboardFormatAvailable(CF_TEXT)) {
        const HGLOBAL data = GetClipboardData(CF_TEXT);
        if (data != (HGLOBAL)0) {
            const char* text = (char*)GlobalLock(data);
            if (text != NULL) {
                CString str(text);
                //if(lastClip == str) { // 前回と同じ内容がコピーされたら表示を更新する
                    m_edit.SetWindowText(str);
                //}
                lastClip = str;
            }
            else {
                //m_edit.SetWindowText(_T("text is NULL"));
            }
            GlobalUnlock(data);
        }
        else {
            //m_edit.SetWindowText(_T("data is NULL"));
        }
    }
    else {
        //m_edit.SetWindowText(_T("Is Not TEXT"));
    }

    CloseClipboard();

    ::SendMessage(m_nextClipboardViewerHandle, WM_DRAWCLIPBOARD, 0, 0L);
}

void CGhostBoardDlg::OnChangeCbChain(HWND hWndRemove, HWND hWndAfter)
{
    CDialog::OnChangeCbChain(hWndRemove, hWndAfter);

    if (hWndRemove == m_nextClipboardViewerHandle)
        m_nextClipboardViewerHandle = hWndAfter;

    if (m_nextClipboardViewerHandle != (HWND)0) {
        /* 次のクリップボード ビューアへ送る */
        ::SendMessage(m_nextClipboardViewerHandle, WM_CHANGECBCHAIN, (WPARAM)hWndRemove, (LPARAM)hWndAfter);
    }
}

bool CGhostBoardDlg::SetTextToClipboard(CString &strText)
{
    // 文字列が空の場合はコピーしない
    if( strText.IsEmpty() )
        return false;

    // グローバルヒープ上にメモリ領域を確保し、文字列をコピー
    int iStrLen = WideCharToMultiByte(CP_ACP,0,strText,-1,NULL,0,NULL,NULL);	//必要なバイト数を取得
    HGLOBAL hMem = ::GlobalAlloc(GMEM_FIXED, iStrLen); // メモリ取得
    char *text = (char *)GlobalLock(hMem); // メモリロック
    WideCharToMultiByte(CP_ACP,0,strText,-1,text,iStrLen,NULL,NULL);//メモリへの書き込み
    ::GlobalUnlock(hMem); // メモリロック解除

    // クリップボードのオープン
    if( !::OpenClipboard(NULL) ) {
        MessageBox(_T("OpenClipboard FAIL"));
        return false;
    }

    ::EmptyClipboard();	// クリップボードの中身を空にする
    ::SetClipboardData(CF_TEXT, hMem); // クリップボードへのセット
    ::CloseClipboard(); // クリップボードのクローズ

    return true;
}

//*************************************************** 状態の保存と読み出し
bool CGhostBoardDlg::Save()
{
    FILE *fp;
    errno_t err;

    WINDOWPLACEMENT wPos;
    GetWindowPlacement(&wPos);

    if((err = fopen_s(&fp, "GhostBoard.dat", "w")) != 0) {
        MessageBox(_T("Can not open file <GhostBoard.dat>"));
        return false;
    }
 
    fprintf(fp, "left:%d, top:%d, right:%d, bottom:%d", 
         wPos.rcNormalPosition.left, wPos.rcNormalPosition.top, wPos.rcNormalPosition.right, wPos.rcNormalPosition.bottom);
 
    fclose(fp);
    return true;
}

bool CGhostBoardDlg::Load()
{ 
    FILE *fp;
    errno_t err;

    WINDOWPLACEMENT wPos;
    GetWindowPlacement(&wPos);

    if((err = fopen_s(&fp, "GhostBoard.dat", "r")) != 0) {
        return false;
    }
 
    fscanf_s(fp, "left:%d, top:%d, right:%d, bottom:%d", 
         &wPos.rcNormalPosition.left, &wPos.rcNormalPosition.top, &wPos.rcNormalPosition.right, &wPos.rcNormalPosition.bottom);

    SetWindowPlacement(&wPos);
 
    fclose(fp);
    return true;
}

//*************************************************** ポップアップメニュー
void CGhostBoardDlg::OnRButtonDown(UINT nFlags, CPoint point)
{
    PopUpMenu();

    CDialog::OnRButtonDown(nFlags, point);
}

void CGhostBoardDlg::PopUpMenu()
{
    POINT pnt;
    GetCursorPos(&pnt);
    static int tgl;

    if(tgl == MF_CHECKED) {
        tgl = MF_UNCHECKED;
        ModifyStyleEx(WS_EX_APPWINDOW, WS_EX_TOOLWINDOW);
//        ModifyStyleEx(WS_EX_TOOLWINDOW, 0, 1);
    }
    else {
        tgl = MF_CHECKED;
        ModifyStyleEx(WS_EX_TOOLWINDOW, WS_EX_APPWINDOW);
//        ModifyStyleEx(0, WS_EX_TOOLWINDOW, 1);
    }


    CMenu menu;
    menu.LoadMenu(IDR_MENU_RBUTTON); // IDR_MENU1はResourceViewで追加したメニュー
    menu.CheckMenuItem(ID_MENU_TASKTRAY, tgl);
    menu.GetSubMenu(0)->TrackPopupMenu(TPM_LEFTALIGN | TPM_RIGHTBUTTON, pnt.x, pnt.y, this);
}
void CGhostBoardDlg::OnMenuClose()
{
    PostMessage(WM_CLOSE, 0, 0);
}

void CGhostBoardDlg::OnMenuMinimize()
{
    ShowWindow(SW_SHOWMINIMIZED);
}
