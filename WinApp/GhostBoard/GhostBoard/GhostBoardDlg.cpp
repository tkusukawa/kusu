// GhostBoardDlg.cpp : 実装ファイル
//

#include "stdafx.h"
#include "GhostBoard.h"
#include "GhostBoardDlg.h"
#include "GHostBoardSettings.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

COLORREF CGhostBoardDlg::sm_color[TEMPLATE_NUM] = {
        RGB(255,255,255),
        RGB(255,150,150),
        RGB(150,255,150),
        RGB(150,150,255)
};

// CGhostBoardDlg ダイアログ

CGhostBoardDlg::CGhostBoardDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CGhostBoardDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);

    // メンバ変数初期化
    m_leftDown = false;
    m_initialized = false;
    m_activate = false;
    m_activeKey = false;
    m_mouseDistance = 0;
    m_mouseDistanceFar = 100;
    m_hide = false;
    // デフォルトの透明度、マウス接近時の透明度を設定。
    m_alphaDefault = 150;
    m_alphaMouse = 30;
    // デフォルトのアクティブキーはCtrl+Alt
    m_confCtrl = true;
    m_confShift = false;
    m_confAlt = false;
    m_confWin = false;
    // テンプレート
    for(int i=0; i<TEMPLATE_NUM;i++)
        m_brush[i].CreateSolidBrush(sm_color[i]);
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
    ON_COMMAND(ID_MENU_HIDE, &CGhostBoardDlg::OnMenuHide)
    ON_WM_DESTROY()
    ON_COMMAND(ID_MENU_SETTINGS, &CGhostBoardDlg::OnMenuSettings)
    ON_WM_CTLCOLOR()
END_MESSAGE_MAP()


// CGhostBoardDlg メッセージ ハンドラ

BOOL CGhostBoardDlg::OnInitDialog()
{
    ModifyStyleEx(WS_EX_APPWINDOW, WS_EX_TOOLWINDOW); // タスクバーに表示しない
//    ModifyStyleEx(WS_EX_TOOLWINDOW, WS_EX_APPWINDOW); // タスクバーに表示する
	BOOL ret = CDialog::OnInitDialog();

	// このダイアログのアイコンを設定します。アプリケーションのメイン ウィンドウがダイアログでない場合、
	//  Framework は、この設定を自動的に行います。
	SetIcon(m_hIcon, TRUE);			// 大きいアイコンの設定
	SetIcon(m_hIcon, FALSE);		// 小さいアイコンの設定

    //---- ウィンドウタイトル
    SetWindowText(_T("GhostBoard"));

    //---- テンプレート・履歴初期化
    m_template = 0;
    for(int i=0; i < TEMPLATE_NUM; i++) {
        m_lookupPos[i] = 0;
    }
    m_historyNum = 1;
    m_historyPos = 0;
    m_historyCount = 0;
    m_historyTime[m_historyPos] = CTime::GetCurrentTime();

    //---- 最小化ボタンの表示
    //ModifyStyle(0, WS_MINIMIZEBOX);
    m_hide = false;

    //---- タスクトレイ表示
    m_icon.cbSize = sizeof(NOTIFYICONDATA);
    m_icon.uID = 0;
    m_icon.hWnd = m_hWnd;
    m_icon.uFlags = NIF_ICON | NIF_MESSAGE | NIF_TIP;
    m_icon.hIcon = AfxGetApp()->LoadIcon( IDR_MAINFRAME );
    m_icon.uCallbackMessage = WM_TRYCLK;
    lstrcpy( m_icon.szTip, _T("GhostBoard"));
    // バルーン設定
    m_icon.uTimeout = 10000;
    m_icon.dwInfoFlags = NIIF_NONE|NIIF_NOSOUND;
    lstrcpy(m_icon.szInfoTitle, _T(""));
    lstrcpy(m_icon.szInfo, _T(""));
    ::Shell_NotifyIcon( NIM_ADD, &m_icon );

    //---- クリップボードの監視
    m_nextClipboardViewerHandle = SetClipboardViewer();

    //---- 透明化
    SetViewState();

    //---- アクティブキー＆マウス位置の定期監視タイマースタート
    SetTimer(0, WATCH_INTERVAL, NULL);

    //---- 初期化完了フラグ
    m_initialized = true;

    //---- 前状態の読み出し
    Load();

    //---- ホットキーの設定
    StartHotKey();

	return ret;  // フォーカスをコントロールに設定した場合を除き、TRUE を返します。
}

void CGhostBoardDlg::OnDestroy()
{
    CDialog::OnDestroy();

    // 現在の編集テキストを履歴に格納
    rememberTemplate();

    Save();

    //---- タスクトレイのアイコンを削除
    ::Shell_NotifyIcon( NIM_DELETE, &m_icon );
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
        case VK_PRIOR:
            HistoryBackward();
            return TRUE;
        case VK_NEXT:
            HistoryForward();
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

    // フォーカス状態の確認（ごくまれにフォーカス消失の通知が受けられないので）
    if(m_activate == true && 
        (GetActiveWindow() != this || 
        GetForegroundWindow() != this ||
        GetFocus() != &m_edit)) {
            lostFocus();
    }

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
    if( (!m_confCtrl  || ::GetAsyncKeyState(VK_CONTROL)) &
        (!m_confShift || ::GetAsyncKeyState(VK_SHIFT)) &
        (!m_confAlt   || ::GetAsyncKeyState(VK_MENU)) &
        (!m_confWin   || ::GetAsyncKeyState(VK_LWIN) || ::GetAsyncKeyState(VK_RWIN))) {
        // アクティブキーが押されているなら
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

    // バルーン表示タイムアウトの監視
    if(m_balloonTime != 0) {
        if(m_balloonTime <= WATCH_INTERVAL) {
            m_balloonTime = 0;
            EraseInfo();
        }
        else {
            m_balloonTime -= WATCH_INTERVAL;
        }
    }

    CDialog::OnTimer(nIDEvent);
}


//************************************************** 透明化
void CGhostBoardDlg::SetViewState()
{
    static bool s_active = false;
    static int s_template = 0;

    if(m_activate || m_activeKey) {
        if(s_active == false) {
            TRACE("SetViewState():active\n");
            // アクティブになった時
            s_active = true;
            ModifyStyleEx(WS_EX_TRANSPARENT, 0); // 透過解除
            SetLayeredWindowAttributes(0, 255, LWA_ALPHA); // 表示濃淡100％

            //バルーン表示
            DispInfo(BALLOON_ACTIVE);
        }
    }
    else {
        if(s_active == true) {
            TRACE("SetViewState():alpha\n");
            s_active = false;
            // 非アクティブになった時
            ModifyStyleEx(0, WS_EX_LAYERED | WS_EX_TRANSPARENT); // 透過設定

            //バルーン表示解除
            EraseInfo();
        }

        BYTE alpha;
        if(m_hide) {
            alpha = 0;
        }
        else if(m_mouseDistance > m_mouseDistanceFar) {
            alpha = m_alphaDefault;
        }
        else if(m_alphaDefault > m_alphaMouse) {
            alpha = m_alphaMouse + (m_alphaDefault-m_alphaMouse)*m_mouseDistance/m_mouseDistanceFar;
        }
        else {
            alpha = m_alphaMouse - (m_alphaMouse - m_alphaDefault)*m_mouseDistance/m_mouseDistanceFar;
        }
        SetLayeredWindowAttributes(0, alpha, LWA_ALPHA);
    }

    if(s_template != m_template) {
        // テンプレートグループが変わったときは再描画
        s_template = m_template;
        InvalidateRect(NULL,TRUE);
    }
}

//*************************************************** ウィンドウフォーカスの監視
void CGhostBoardDlg::OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized)
{
    CDialog::OnActivate(nState, pWndOther, bMinimized);

    TRACE("OnActivate:%d\n", nState);
    if(nState == WA_ACTIVE || nState == WA_CLICKACTIVE) {
        getFocus();
    }
    else {
        lostFocus();
    }
}

void CGhostBoardDlg::getFocus()
{
    TRACE("GetFocus\n");
    m_activate = true;
    SetViewState();
}

void CGhostBoardDlg::lostFocus()
{
    TRACE("LostFocus\n");
    rememberTemplate();

    SetTextToClipboard(m_textArray[m_template][m_lookupPos[m_template]]);

    m_activate = false;
    SetViewState();

    Save();
}

//*************************************************** クリップボードの監視と書き込み
void CGhostBoardDlg::OnDrawClipboard()
{
    CDialog::OnDrawClipboard();

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
                if(m_textArray[m_template][m_lookupPos[m_template]] != str) {
                    // 現在参照中と異なる文字列の場合のみ更新する
                    m_historyCount ++;
                    m_historyPos ++;
                    if(m_historyPos>=m_historyNum && m_historyNum < HISTORY_NUM)
                        m_historyNum ++;
                    if(m_historyPos >= m_historyNum) m_historyPos -= m_historyNum;

                    // ヒストリに記入
                    m_textArray[0][m_historyPos] = str;
                    m_historyTime[m_historyPos] = CTime::GetCurrentTime();
                    TRACE("save history:%d\n", m_historyPos);

                    // アクティブでないか、表示中のバッファが更新された場合は表示
                    if(!m_activate || (m_template == 0 && m_lookupPos[0] == m_historyPos)) {
                        m_edit.SetWindowText(str);
                        m_template = 0;
                        m_lookupPos[0] = m_historyPos;
                        SetViewState();
                    }

                    // バルーンにコピー番号を表示
                    DispInfo(BALLOON_COPY);
                }
            }
            else {
                TRACE("TEXT is NULL\n");
            }
            GlobalUnlock(data);
        }
        else {
            TRACE("CLIPBOARD is NULL\n");
        }
    }
    else {
        TRACE("CLIPBOARD is not TEXT\n");
        UINT format=0;
        while(format=EnumClipboardFormats(format)) {
            TRACE("format=%d\n", format);
        }
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
    TRACE("SetTextToClipboard\n");

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
    char buf[SAVE_TEXT_SIZE];

    WINDOWPLACEMENT wPos;
    GetWindowPlacement(&wPos);

    if((err = fopen_s(&fp, "GhostBoard.dat", "w")) != 0) {
        MessageBox(_T("Can not open file <GhostBoard.dat>"));
        return false;
    }
 
    fprintf(fp, "left:%d, top:%d, right:%d, bottom:%d\n", 
         wPos.rcNormalPosition.left, wPos.rcNormalPosition.top, wPos.rcNormalPosition.right, wPos.rcNormalPosition.bottom);
    fprintf(fp, "hide:%d\n", m_hide);
    fprintf(fp, "alphaDefault:%d, alphaMouse:%d\n", m_alphaDefault, m_alphaMouse);
    fprintf(fp, "ctrl:%d, shift:%d, alt:%d, win:%d\n", m_confCtrl, m_confShift, m_confAlt, m_confWin);

    for(int j=1; j<TEMPLATE_NUM; j++) {
        for(int i=0; i<HISTORY_NUM; i++) {
            CString str = m_textArray[j][i];
            if(str != "") {
                str.Replace(_T("\\"), _T("\\\\"));
                str.Replace(_T("\n"), _T("\\n"));
                str.Replace(_T("\r"), _T("\\r"));
                fprintf(fp, "%d:%d:", j, i);
                WideCharToMultiByte(CP_ACP,0,str,-1,buf,SAVE_TEXT_SIZE,NULL,NULL);//コード変換
                fputs(buf, fp);
                fprintf(fp, "\n");
            }
        }
    }
 
    fclose(fp);
    return true;
}

bool CGhostBoardDlg::Load()
{ 
    FILE *fp;
    errno_t err;
    int ret;

    WINDOWPLACEMENT wPos;
    GetWindowPlacement(&wPos);

    if((err = fopen_s(&fp, "GhostBoard.dat", "r")) != 0) {
        return false;
    }
 
    fscanf_s(fp, "left:%d, top:%d, right:%d, bottom:%d\n", 
         &wPos.rcNormalPosition.left, &wPos.rcNormalPosition.top, &wPos.rcNormalPosition.right, &wPos.rcNormalPosition.bottom);
    SetWindowPlacement(&wPos);

    fscanf_s(fp, "hide:%d\n", &m_hide);
    fscanf_s(fp, "alphaDefault:%d, alphaMouse:%d\n", &m_alphaDefault, &m_alphaMouse); 
    fscanf_s(fp, "ctrl:%d, shift:%d, alt:%d, win:%d\n", &m_confCtrl, &m_confShift, &m_confAlt, &m_confWin);

    do{
        int tmp, idx;
        char buf[SAVE_TEXT_SIZE];
        ret = fscanf_s(fp, "%d:%d:", &tmp, &idx);
        if(ret > 0) {
            fgets(buf, SAVE_TEXT_SIZE, fp);
            m_textArray[tmp][idx] = buf;
            m_textArray[tmp][idx].Replace(_T("\r"), _T("")); // 改行文字を削除
            m_textArray[tmp][idx].Replace(_T("\n"), _T("")); // 改行文字を削除
            m_textArray[tmp][idx].Replace(_T("\\r"), _T("\r")); //エスケープした文字を復元
            m_textArray[tmp][idx].Replace(_T("\\n"), _T("\n")); //エスケープした文字を復元
            m_textArray[tmp][idx].Replace(_T("\\\\"), _T("\\")); //エスケープした文字を復元
        }
    }while(ret > 0);

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

    CMenu menu;
    menu.LoadMenu(IDR_MENU_RBUTTON); // IDR_MENU1はResourceViewで追加したメニュー
    menu.CheckMenuItem(ID_MENU_HIDE, m_hide?MF_CHECKED:MF_UNCHECKED); // 非表示状態をチェックで表示
    menu.GetSubMenu(0)->TrackPopupMenu(TPM_LEFTALIGN | TPM_RIGHTBUTTON, pnt.x, pnt.y, this);
}
void CGhostBoardDlg::OnMenuClose()
{
    PostMessage(WM_CLOSE, 0, 0);
}

void CGhostBoardDlg::OnMenuHide()
{
    if(m_hide) {
        //ShowWindow(SW_SHOWNORMAL);
        m_hide = false;
        SetViewState();
        Save();
    }
    else {
        //ShowWindow(SW_HIDE);
        m_hide = true;
        SetViewState();
        Save();
    }
}

void CGhostBoardDlg::OnMenuSettings()
{
    CGhostBoardSettings dlg;
    dlg.m_alphaDefault = m_alphaDefault;
    dlg.m_alphaMouse = m_alphaMouse;
    dlg.m_ctrl = m_confCtrl;
    dlg.m_shift = m_confShift;
    dlg.m_alt = m_confAlt;
    dlg.m_win = m_confWin;
    INT_PTR nResponse = dlg.DoModal();
	if (nResponse == IDOK)
	{
        TRACE("Setting OK\n");
        // 透明度を設定
        m_alphaDefault = dlg.m_alphaDefault;
        m_alphaMouse = dlg.m_alphaMouse;
        // ホットキーを再設定
        StopHotKey();
        m_confCtrl = dlg.m_ctrl;
        m_confShift = dlg.m_shift;
        m_confAlt = dlg.m_alt;
        m_confWin = dlg.m_win;
        StartHotKey();
 
        Save();
	}
	else if (nResponse == IDCANCEL)
	{
        TRACE("Setting Cancel\n");
	}
}

LRESULT CGhostBoardDlg::WindowProc(UINT message, WPARAM wParam, LPARAM lParam) 
{
	switch( message )
	{
	case WM_HOTKEY:	//ホットキーを押しました。
		TRACE( "%d, %d, %d\n", wParam, LOWORD( lParam ), HIWORD( lParam ) );
        if(wParam == m_hotKeyUp) {
            HistoryBackward();
        }
        else if(wParam == m_hotKeyDown) {
            HistoryForward();
        }
        else if(wParam == m_hotKeyLeft) {
            TemplateBackward();
        }
        else if(wParam == m_hotKeyRight) {
            TemplateForward();
        }
        else if(wParam == m_hotKeyEnter) {
            m_edit.SetFocus();
            SetForegroundWindow();
            //SetActiveWindow();
        }
		return 1;
    
    case WM_TRYCLK: //タスクトレイ
        switch(lParam) {
        case WM_LBUTTONDOWN:
            TRACE("WM_LBUTTONDOWN\n");
            SetForegroundWindow();
            return 1;
        case WM_RBUTTONDOWN:
            TRACE("WM_RBUTTONDOWN\n");
            SetForegroundWindow();
            PopUpMenu();
            return 1;
        }
        break;
	}	

	return CDialog::WindowProc(message, wParam, lParam);
}

HBRUSH CGhostBoardDlg::OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor)
{
    HBRUSH hbr = CDialog::OnCtlColor(pDC, pWnd, nCtlColor);

    if(nCtlColor == CTLCOLOR_DLG) {
        TRACE("OnCtlColor() t=%d\n", m_template);
        pDC->SetBkMode(OPAQUE); 
        pDC->SetBkColor(sm_color[m_template]);
        return m_brush[m_template];
    }

    // TODO:  既定値を使用したくない場合は別のブラシを返します。
    return hbr;
}

void CGhostBoardDlg::HistoryBackward()
{
    rememberTemplate();
    // 履歴参照位置を更新
    m_lookupPos[m_template] --;
    if(m_lookupPos[m_template] < 0)
        m_lookupPos[m_template]+=m_template?HISTORY_NUM:m_historyNum;
    // 履歴の内容を編集テキストに表示
    m_edit.SetWindowText(m_textArray[m_template][m_lookupPos[m_template]]);
    // 編集状態でなければクリップボードにコピー
	if(!m_activate) {
	    SetTextToClipboard(m_textArray[m_template][m_lookupPos[m_template]]);
    }
    
    TRACE("HistoryBackward():%d,%d\n", m_template, m_lookupPos[m_template]);

    DispInfo(BALLOON_ACTIVE); // バルーン表示
}

void CGhostBoardDlg::HistoryForward()
{
    rememberTemplate();
    // 履歴参照位置を更新
    m_lookupPos[m_template] ++;
    if(m_template) {
        if(m_lookupPos[m_template] >= HISTORY_NUM)
            m_lookupPos[m_template] -= HISTORY_NUM;
    }
    else {
        if(m_lookupPos[m_template] >= m_historyNum)
            m_lookupPos[m_template] -= m_historyNum;
    }
    // 履歴の内容を編集テキストに表示
    m_edit.SetWindowText(m_textArray[m_template][m_lookupPos[m_template]]);
    // 編集状態でなければクリップボードにコピー
	if(!m_activate) {
	    SetTextToClipboard(m_textArray[m_template][m_lookupPos[m_template]]);
    }

	TRACE("HistoryForward():%d,%d\n", m_template, m_lookupPos[m_template]);
    
    DispInfo(BALLOON_ACTIVE); // バルーン表示
}

void CGhostBoardDlg::TemplateBackward()
{
    rememberTemplate();
    // 参照テンプレートを更新
    m_template --;
    if(m_template < 0) m_template += TEMPLATE_NUM;
    // 履歴の内容を編集テキストに表示
    m_edit.SetWindowText(m_textArray[m_template][m_lookupPos[m_template]]);
    // 編集状態でなければクリップボードにコピー
	if(!m_activate) {
	    SetTextToClipboard(m_textArray[m_template][m_lookupPos[m_template]]);
    }

	TRACE("TemplateBackward():%d,%d\n", m_template, m_lookupPos[m_template]);
    
    DispInfo(BALLOON_ACTIVE); // バルーン表示
    SetViewState();
}

void CGhostBoardDlg::TemplateForward()
{
    rememberTemplate();
    // 参照テンプレートを更新
    m_template ++;
    if(m_template >= TEMPLATE_NUM) m_template -= TEMPLATE_NUM;
    // 履歴の内容を編集テキストに表示
    m_edit.SetWindowText(m_textArray[m_template][m_lookupPos[m_template]]);
    // 編集状態でなければクリップボードにコピー
	if(!m_activate) {
	    SetTextToClipboard(m_textArray[m_template][m_lookupPos[m_template]]);
    }

	TRACE("TemplateBackward():%d,%d\n", m_template, m_lookupPos[m_template]);
    
    DispInfo(BALLOON_ACTIVE); // バルーン表示
    SetViewState();
}

void CGhostBoardDlg::rememberTemplate()
{
    // 現在の編集テキストを履歴orテンプレートに格納
    CString str;
    m_edit.GetWindowText(str);
    m_textArray[m_template][m_lookupPos[m_template]] = str;
}

void CGhostBoardDlg::DispInfo(UINT timeout_ms)
{
    //バルーン表示
    m_icon.uFlags = NIF_INFO;
    if(m_template) {
        // テンプレート表示
        wsprintf(m_icon.szInfo, _T("%c:%d"), " RGB"[m_template], m_lookupPos[m_template]);
    }
    else {
        // クリップボード履歴
        int hisNum = m_lookupPos[0] - m_historyPos;
        if(hisNum>0) hisNum -= m_historyNum;
        hisNum += m_historyCount;
        wsprintf(m_icon.szInfo, _T("%d (%s)"), hisNum, m_historyTime[m_lookupPos[0]].Format("%H:%M:%S"));
    }
    ::Shell_NotifyIcon( NIM_MODIFY, &m_icon );
    m_balloonTime = timeout_ms;
}

void CGhostBoardDlg::EraseInfo()
{
    m_icon.uFlags = NIF_INFO;
    lstrcpy(m_icon.szInfoTitle, _T(""));
    wsprintf(m_icon.szInfo, _T(""));
    ::Shell_NotifyIcon( NIM_MODIFY, &m_icon );
    m_balloonTime = 0;
}

void CGhostBoardDlg::StartHotKey()
{
    int actKey = (m_confCtrl?MOD_CONTROL:0)
               | (m_confShift?MOD_SHIFT:0)
               | (m_confAlt?MOD_ALT:0)
               | (m_confWin?MOD_WIN:0);
    m_hotKeyUp  =(actKey<<8) + VK_UP;   // 履歴前
    m_hotKeyDown=(actKey<<8) + VK_DOWN; // 履歴後
    m_hotKeyLeft =(actKey<<8) + VK_LEFT;   // テンプレート逆
    m_hotKeyRight=(actKey<<8) + VK_RIGHT;  // テンプレート順
    m_hotKeyEnter=(actKey<<8) + VK_RETURN; // フォーカス

    if(!::RegisterHotKey(m_hWnd, m_hotKeyUp,   m_hotKeyUp  >>8, m_hotKeyUp  &0xFF ))
        MessageBox(_T("FAIL: RegisterHotKey(): history prior"));

    if(!::RegisterHotKey(m_hWnd, m_hotKeyDown, m_hotKeyDown>>8, m_hotKeyDown&0xFF ))
        MessageBox(_T("FAIL: RegisterHotKey(): history next"));

    if(!::RegisterHotKey(m_hWnd, m_hotKeyLeft, m_hotKeyLeft>>8, m_hotKeyLeft&0xFF ))
        MessageBox(_T("FAIL: RegisterHotKey(): template prior"));

    if(!::RegisterHotKey(m_hWnd, m_hotKeyRight, m_hotKeyRight>>8, m_hotKeyRight&0xFF ))
        MessageBox(_T("FAIL: RegisterHotKey(): template next"));

    if(!::RegisterHotKey(m_hWnd, m_hotKeyEnter, m_hotKeyEnter>>8, m_hotKeyEnter&0xFF ))
        MessageBox(_T("FAIL: RegisterHotKey(): focus"));
}

void CGhostBoardDlg::StopHotKey()
{
    if(!::UnregisterHotKey(m_hWnd, m_hotKeyUp))
        MessageBox(_T("FAIL: UnregisterHotKey(): history prior"));

    if(!::UnregisterHotKey(m_hWnd, m_hotKeyDown))
        MessageBox(_T("FAIL: UnregisterHotKey(): history next"));

    if(!::UnregisterHotKey(m_hWnd, m_hotKeyLeft))
        MessageBox(_T("FAIL: UnregisterHotKey(): template prior"));

    if(!::UnregisterHotKey(m_hWnd, m_hotKeyRight))
        MessageBox(_T("FAIL: UnregisterHotKey(): template next"));

    if(!::UnregisterHotKey(m_hWnd, m_hotKeyEnter))
        MessageBox(_T("FAIL: UnregisterHotKey(): focus"));
}
