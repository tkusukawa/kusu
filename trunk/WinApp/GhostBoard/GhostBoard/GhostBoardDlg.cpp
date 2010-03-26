// GhostBoardDlg.cpp : �����t�@�C��
//

#include "stdafx.h"
#include "GhostBoard.h"
#include "GhostBoardDlg.h"
#include "GHostBoardSettings.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

COLORREF CGhostBoardDlg::sm_color[TEMPLATE_NUM+1] = {
        RGB(255,255,255), // �N���b�v�{�[�h����
        RGB(255,150,150), // ��
        RGB(150,255,150), // ��
        RGB(150,150,255), // ��
        RGB(150,150,150)  // �N���b�v�{�[�h NOT TEXT
};

// CGhostBoardDlg �_�C�A���O

CGhostBoardDlg::CGhostBoardDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CGhostBoardDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);

    // �����o�ϐ�������
    m_bootStatus = BS_none;
    m_dispStatus = DS_focus;
    m_cbEventFlg = false;
    m_leftDown = false;
    m_mouseDistance = 0;
    m_mouseDistanceFar = 100;
    // �f�t�H���g�̓����x�A�}�E�X�ڋߎ��̓����x��ݒ�B
    m_alphaActive = 200;
    m_alphaDefault = 150;
    m_alphaMouse = 30;
    // �f�t�H���g�̃A�N�e�B�u�L�[��Ctrl
    m_confCtrl = true;
    m_confShift = false;
    m_confAlt = false;
    m_confWin = false;
    // �f�t�H���g�̃o���[���\���͂���
    m_iconNotif = true;
    // �e���v���[�g
    for(int i=0; i<=TEMPLATE_NUM;i++)
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
    ON_WM_DESTROY()
    ON_COMMAND(ID_MENU_SETTINGS, &CGhostBoardDlg::OnMenuSettings)
    ON_WM_CTLCOLOR()
    ON_COMMAND_RANGE(ID_SEL_HISTORY, ID_SEL_MAX, OnExecMenu)
END_MESSAGE_MAP()


// CGhostBoardDlg ���b�Z�[�W �n���h��

BOOL CGhostBoardDlg::OnInitDialog()
{
    ModifyStyleEx(WS_EX_APPWINDOW, WS_EX_TOOLWINDOW); // �^�X�N�o�[�ɕ\�����Ȃ�
//    ModifyStyleEx(WS_EX_TOOLWINDOW, WS_EX_APPWINDOW); // �^�X�N�o�[�ɕ\������
	BOOL ret = CDialog::OnInitDialog();

	// ���̃_�C�A���O�̃A�C�R����ݒ肵�܂��B�A�v���P�[�V�����̃��C�� �E�B���h�E���_�C�A���O�łȂ��ꍇ�A
	//  Framework �́A���̐ݒ�������I�ɍs���܂��B
	SetIcon(m_hIcon, TRUE);			// �傫���A�C�R���̐ݒ�
	SetIcon(m_hIcon, FALSE);		// �������A�C�R���̐ݒ�

    m_bootStatus = BS_booting;

    //---- �E�B���h�E�^�C�g��
    SetWindowText(_T("GhostBoard"));

    //---- �e���v���[�g�E����������
    m_template = 0;
    for(int i=0; i < TEMPLATE_NUM; i++) {
        m_lookupPos[i] = 0;
    }
    m_historyNum = 1;
    m_historyPos = 0;
    m_historyCount = 0;
    m_historyTime[m_historyPos] = CTime::GetCurrentTime();

    //---- �ŏ����{�^���̕\��
    //ModifyStyle(0, WS_MINIMIZEBOX);

    //---- �^�X�N�g���C�\��
    m_icon.cbSize = sizeof(NOTIFYICONDATA);
    m_icon.uID = 0;
    m_icon.hWnd = m_hWnd;
    m_icon.uFlags = NIF_ICON | NIF_MESSAGE | NIF_TIP;
    m_icon.hIcon = AfxGetApp()->LoadIcon( IDR_MAINFRAME );
    m_icon.uCallbackMessage = WM_TRYCLK;
    lstrcpy( m_icon.szTip, APP_NAME);
    // �o���[���ݒ�
    m_icon.uTimeout = 10000;
    m_icon.dwInfoFlags = NIIF_NONE|NIIF_NOSOUND;
    lstrcpy(m_icon.szInfoTitle, _T(""));
    lstrcpy(m_icon.szInfo, _T(""));
    ::Shell_NotifyIcon( NIM_ADD, &m_icon );

    //---- ������
    SetViewState();

    //---- �A�N�e�B�u�L�[���}�E�X�ʒu�̒���Ď��^�C�}�[�X�^�[�g
    SetTimer(0, WATCH_INTERVAL, NULL);

    //---- �f�t�H���g�̉�ʈʒu��ݒ�
    m_windowPos.rcNormalPosition.right = GetSystemMetrics(SM_CXSCREEN);
    m_windowPos.rcNormalPosition.bottom = GetSystemMetrics(SM_CYSCREEN);
    m_windowPos.rcNormalPosition.left = m_windowPos.rcNormalPosition.right - 400;
    m_windowPos.rcNormalPosition.top = m_windowPos.rcNormalPosition.bottom - 80;
    SetWindowPlacement(&m_windowPos);
    m_chkScrTimer = CHK_SCR_INTERVAL;

    //---- �O��Ԃ̓ǂݏo��
    Load();

    //---- �z�b�g�L�[�̐ݒ�
    StartHotKey();

    m_textArray[0][0] = APP_NAME;
    m_edit.SetWindowText(APP_NAME);

	return ret;  // �t�H�[�J�X���R���g���[���ɐݒ肵���ꍇ�������ATRUE ��Ԃ��܂��B
}

void CGhostBoardDlg::OnDestroy()
{
    CDialog::OnDestroy();

    // �N���b�v�{�[�h�`�G�[������O���Ă��炤
    ChangeClipboardChain(m_nextClipboardViewerHandle);
    m_nextClipboardViewerHandle = 0;

    // ���݂̕ҏW�e�L�X�g�𗚗��Ɋi�[
    rememberTemplate();

    Save();

    //---- �^�X�N�g���C�̃A�C�R�����폜
    ::Shell_NotifyIcon( NIM_DELETE, &m_icon );
}

// �_�C�A���O�ɍŏ����{�^����ǉ�����ꍇ�A�A�C�R����`�悷�邽�߂�
//  ���̃R�[�h���K�v�ł��B�h�L�������g/�r���[ ���f�����g�� MFC �A�v���P�[�V�����̏ꍇ�A
//  ����́AFramework �ɂ���Ď����I�ɐݒ肳��܂��B

void CGhostBoardDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // �`��̃f�o�C�X �R���e�L�X�g

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// �N���C�A���g�̎l�p�`�̈���̒���
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// �A�C�R���̕`��
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// ���[�U�[���ŏ��������E�B���h�E���h���b�O���Ă���Ƃ��ɕ\������J�[�\�����擾���邽�߂ɁA
//  �V�X�e�������̊֐����Ăяo���܂��B
HCURSOR CGhostBoardDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}

//************************************************** ESC�L�[�̖�����
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

//************************************************** �ړ��ƃ��T�C�Y
void CGhostBoardDlg::OnSize(UINT nType, int cx, int cy)
{
    CDialog::OnSize(nType, cx, cy);

    if(m_bootStatus == BS_none) 
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

    //-------------- �}�E�X�J�[�\���̕ύX
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
    //-------------- �}�E�X�J�[�\���̕ύX
    HCURSOR lhCursor = AfxGetApp()->LoadStandardCursor(IDC_SIZEALL);
    SetCursor(lhCursor);

    if(m_leftDown) {
        POINT nowCursorPos;

        GetCursorPos(&nowCursorPos);
        m_windowPos = m_leftDownWindowPos;
        m_windowPos.rcNormalPosition.left += 
            nowCursorPos.x - m_leftDownCursorPos.x;
        m_windowPos.rcNormalPosition.right += 
            nowCursorPos.x - m_leftDownCursorPos.x;
        m_windowPos.rcNormalPosition.top += 
            nowCursorPos.y - m_leftDownCursorPos.y;
        m_windowPos.rcNormalPosition.bottom += 
            nowCursorPos.y - m_leftDownCursorPos.y;
        SetWindowPlacement(&m_windowPos);
    }

    CDialog::OnMouseMove(nFlags, point);
}

//************************************************** �A�N�e�B�u�L�[�ƃ}�E�X�ʒu�̊Ď�
void CGhostBoardDlg::OnTimer(UINT_PTR nIDEvent)
{
    POINT mousePnt;
    UINT dist, distX, distY;

    // �N��������ԍX�V
    if(m_bootStatus == BS_booting) {
        OnCbUpdate(); // �N���O�ɃN���b�v�{�[�h�̓��e���擾���Ă���
        
        //---- �N���b�v�{�[�h�̊Ď��J�n
        m_nextClipboardViewerHandle = SetClipboardViewer();

        m_bootStatus = BS_ready; //---- �N������
    }

    // �N���b�v�{�[�h�C�x���g����
    if(m_cbEventFlg) {
        m_cbEventFlg = false;
        OnCbUpdate();
    }

    // �t�H�[�J�X��Ԃ̊m�F�i�����܂�Ƀt�H�[�J�X�����̒ʒm���󂯂��Ȃ��̂Łj
    if(m_bootStatus == BS_ready) {
        if(m_dispStatus == DS_focus) {
            if(GetActiveWindow() != this || 
               GetForegroundWindow() != this ||
               GetFocus() != &m_edit) {
                lostFocus();
            }
        }
        else { // m_dispStatus != DS_focus
            CWnd *foreground = GetForegroundWindow();
            if(this == foreground) {
                if( GetActiveWindow() == this &&
                    GetFocus() == &m_edit) {
                        getFocus();
                }
            }
            else { // �t�H�[�J�X��߂����߂Ɍ��̃E�B���h�E���L��
                if(foreground != NULL && foreground != m_lastWindow) {
                    m_lastWindow = foreground;
                    TRACE("OtherFocus=%X\n", foreground->m_hWnd);
                }
            }
        }
    }

    // �}�E�X�ʒu�̊Ď�
    GetCursorPos(&mousePnt);
    
    if(mousePnt.x < m_windowPos.rcNormalPosition.left) {
        distX = m_windowPos.rcNormalPosition.left - mousePnt.x;
    }
    else if(mousePnt.x > m_windowPos.rcNormalPosition.right) {
        distX = mousePnt.x - m_windowPos.rcNormalPosition.right;
    }
    else {
        distX = 0;
    }

    if(mousePnt.y < m_windowPos.rcNormalPosition.top) {
        distY = m_windowPos.rcNormalPosition.top - mousePnt.y;
    }
    else if(mousePnt.y > m_windowPos.rcNormalPosition.bottom) {
        distY = mousePnt.y - m_windowPos.rcNormalPosition.bottom;
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

    // �A�N�e�B�u�L�[�̊Ď�
    if( (!m_confCtrl  || ::GetAsyncKeyState(VK_CONTROL)) &
        (!m_confShift || ::GetAsyncKeyState(VK_SHIFT)) &
        (!m_confAlt   || ::GetAsyncKeyState(VK_MENU)) &
        (!m_confWin   || ::GetAsyncKeyState(VK_LWIN) || ::GetAsyncKeyState(VK_RWIN))) {
        // �A�N�e�B�u�L�[��������Ă���Ȃ�
        if(m_dispStatus == DS_none) {
            m_dispStatus = DS_activeKey;
            SetViewState();
        }
        if(m_actKeyStatus != true) { // �����ꂽ�Ȃ�
            m_actKeyStatus = true;
            DispInfo(BALLOON_ACTIVE);

            CheckCbConnect(); // �N���b�v�{�[�h�̐��퐫�m�F
        }
    }
    else{ // �A�N�e�B�u�L�[��������Ă���Ȃ�
        if(m_dispStatus == DS_activeKey) {
            m_dispStatus = DS_none;
            SetViewState();
        }
        if(m_actKeyStatus != false) {
            m_actKeyStatus = false;
            EraseInfo();
        }
    }

    // �o���[���\���^�C���A�E�g�̊Ď�
    if(m_balloonTime != 0) {
        if(m_balloonTime <= WATCH_INTERVAL) {
            m_balloonTime = 0;
            EraseInfo();
        }
        else {
            m_balloonTime -= WATCH_INTERVAL;
        }
    }

    if(m_chkScrTimer > WATCH_INTERVAL) { // ��ʃT�C�Y�m�F�C���^�[�o��
        m_chkScrTimer -= WATCH_INTERVAL;
    }
    else {
        // expire
        m_chkScrTimer = CHK_SCR_INTERVAL;

        int x = GetSystemMetrics(SM_CXSCREEN);
        if(m_windowPos.rcNormalPosition.right > x) {
            x = m_windowPos.rcNormalPosition.right - x;
            m_windowPos.rcNormalPosition.left  -= x;
            m_windowPos.rcNormalPosition.right -= x;
            SetWindowPlacement(&m_windowPos);
        }
        int y = GetSystemMetrics(SM_CYSCREEN);
        if(m_windowPos.rcNormalPosition.bottom > y) {
            y = m_windowPos.rcNormalPosition.bottom - y;
            m_windowPos.rcNormalPosition.top    -= y;
            m_windowPos.rcNormalPosition.bottom -= y;
            SetWindowPlacement(&m_windowPos);
        }
    }

    CDialog::OnTimer(nIDEvent);
}


//************************************************** ������
void CGhostBoardDlg::SetViewState()
{
    static DispStatus s_status = DS_none;
    static int s_template = 0;
    static BYTE s_alpha = 0;

    if(s_status != m_dispStatus) { // ��Ԃ��ω��������ɍs������
        s_status = m_dispStatus;
        switch(m_dispStatus) {
            case DS_none:
                TRACE("SetViewState():none\n");
                s_alpha = 0;
                // ��A�N�e�B�u�ɂȂ�����
                ModifyStyleEx(0, WS_EX_LAYERED | WS_EX_TRANSPARENT); // ���ߐݒ�
                break;
            case DS_activeKey:
                TRACE("SetViewState():active\n");
                // �A�N�e�B�u�ɂȂ�����
                ModifyStyleEx(WS_EX_TRANSPARENT, 0); // ���߉���
                SetLayeredWindowAttributes(0, m_alphaActive, LWA_ALPHA);
                SetWindowPos(&wndTopMost, 0,0,0,0,
                    SWP_NOSIZE|SWP_NOMOVE|SWP_NOACTIVATE);
                break;
            case DS_focus:
                TRACE("SetViewState():focus\n");
                // �t�H�[�J�X���󂯂��Ƃ�
                ModifyStyleEx(WS_EX_TRANSPARENT, 0); // ���߉���
                SetLayeredWindowAttributes(0, 255, LWA_ALPHA);
                SetWindowPos(&wndTopMost, 0,0,0,0,
                    SWP_NOSIZE|SWP_NOMOVE|SWP_NOACTIVATE);
                break;
        }
    }

    if(m_dispStatus == DS_none) {
        // �����x���}�E�X�ʒu����v�Z
        BYTE alpha;
        if(m_mouseDistance > m_mouseDistanceFar) {
            alpha = m_alphaDefault;
        }
        else if(m_alphaDefault > m_alphaMouse) {
            alpha = m_alphaMouse + (m_alphaDefault-m_alphaMouse)*m_mouseDistance/m_mouseDistanceFar;
        }
        else {
            alpha = m_alphaMouse - (m_alphaMouse - m_alphaDefault)*m_mouseDistance/m_mouseDistanceFar;
        }
        if(alpha != s_alpha) { // �v�Z���ʂ��ς���Ă���Γ����x��ύX
            s_alpha = alpha;
            SetLayeredWindowAttributes(0, alpha, LWA_ALPHA);
        }
    }
        
    if(s_template != m_template) {
        // �e���v���[�g�O���[�v���ς�����Ƃ��͍ĕ`��
        s_template = m_template;
        InvalidateRect(NULL,TRUE);
    }
}

//*************************************************** �E�B���h�E�t�H�[�J�X�̊Ď�
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
    if(m_bootStatus == BS_ready) {
        TRACE("GetFocus\n");
        if(CheckCbConnect()) {
            m_dispStatus = DS_focus;
            SetViewState();
        }
    }
}

void CGhostBoardDlg::lostFocus()
{
    TRACE("LostFocus\n");
    m_dispStatus = DS_none;

    if(m_template >= 0) { // ��������^���̏ꍇ��
        // �\�����e�ɃN���b�v�{�[�h�����킹��
        CString str;
        m_edit.GetWindowText(str);
        SetTextToClipboard(str);

        rememberTemplate();
        Save();
    }
    else { // �\���s�̏�Ԃ�������
        // �N���b�v�{�[�h�ɕ\�����e�����킹��
        OnCbUpdate();
    }

    SetViewState();
}

//*************************************************** �N���b�v�{�[�h�̊Ď��Ə�������
void CGhostBoardDlg::OnDrawClipboard()
{
    TRACE("OnDrawClipboard()\n");
    CDialog::OnDrawClipboard();

    m_cbEventFlg = true; // �t���O�Z�b�g�F���̃^�C�}�C�x���g��CB�擾�������s��
    SetTimer(0, WATCH_INTERVAL, NULL);

    ::SendMessage(m_nextClipboardViewerHandle, WM_DRAWCLIPBOARD, 0, 0L);
}

bool CGhostBoardDlg::OnCbUpdate()
{
    static int s_retry=0;
    static int s_count=0;
    int count = s_count++;
    TRACE("%d:OnCbUpdate()\n", count);

    m_cbEventFlg = false;
    BOOL isOpen = OpenClipboard(); // �N���b�v�{�[�h�I�[�v��
    if(isOpen) {
        s_retry = 0;
    }
    else {
        s_retry ++;
        if(s_retry >= CB_RETRY) {
            TRACE("%d:Retry Out!!!!!!!!!!\n", count);
        }
        else {
            m_cbEventFlg = true; // ���g���C
            return false;
        }
    }

    LPWSTR err = NULL;
    CString str("");
    if(!isOpen) {
        err = _T("CRIPBOARD OPEN ERROR\n");
    }
    else if (IsClipboardFormatAvailable(CF_TEXT)) {
        const HGLOBAL data = GetClipboardData(CF_TEXT);
        if(data != (HGLOBAL)0) {
            const char* text = (char*)GlobalLock(data);
            if(text != NULL) {
                str = text; // �N���b�v�{�[�h�̃e�L�X�g���擾
            }
            else {
                err = _T("TEXT is NULL\n");
            }
            GlobalUnlock(data);
        }
        else {
            err = _T("CLIPBOARD is NULL\n");
        }
    }
    else if(IsClipboardFormatAvailable(CF_HDROP)) {
        HDROP hData = (HDROP)GetClipboardData(CF_HDROP);
        UINT fileNum = DragQueryFile((HDROP)hData, (UINT)-1, NULL, 0);
        for (UINT idx=0; idx<fileNum; idx++) {
            WCHAR fn[512];
            DragQueryFile((HDROP)hData, idx, fn, sizeof(fn));
            str += "FILE: ";
            str += fn;
            str += "\r\n";
        }
        err = _T("CLIPBOARD is FILE\n");
    }
    else {
        err = _T("CLIPBOARD has not TEXT\n");
        UINT format=0;
        while(format=EnumClipboardFormats(format)) {
            TRACE("%d:format=%d\n", count, format);
        }
    }
    CloseClipboard();

    bool historyAdd, needDispUpdate;
	if(err) {
        TRACE("%d:", count);
        TRACE(err);
        // �N�������A�N�e�B�u�łȂ��ꍇ�̂ݕ\�����X�V
        if(m_bootStatus != BS_ready || m_dispStatus != DS_focus) {
            // �N���b�v�{�[�h�Ƀe�L�X�g�������|��\��
            DispAlert(str);
            DispInfo(BALLOON_COPY, err);
        }
        historyAdd = false;
        needDispUpdate = false;
    }
    else if(str.GetLength() == 0) {
        // ����0�̕�����͖���
        historyAdd = false;
        needDispUpdate = false;
    }
    else if((m_template >= 0) && (m_textArray[m_template][m_lookupPos[m_template]] == str)) {
        // �\�����e�Ɠ����Ȃ̂ŗ����̒ǉ��͍s��Ȃ�
        TRACE("%d:same as display\n", count);
        historyAdd = false;
        needDispUpdate = false;
    }
    else if(m_textArray[0][m_historyPos] == str) {
        // �ŐV�̗����Ɠ����ꍇ
        TRACE("%d:same as newest\n", count);
        historyAdd = false; // �����̒ǉ��͍s��Ȃ���
        needDispUpdate = true; // �\�����X�V����K�v������
    }
    else {
        // �\�����e�Ƃ��ŐV�̗����Ƃ��قȂ镶����̏ꍇ�̂ݗ����ɒǉ�����
        m_historyCount ++;
        m_historyPos ++;
        if(m_historyPos>=m_historyNum && m_historyNum < HISTORY_NUM)
            m_historyNum ++;
        if(m_historyPos >= m_historyNum) m_historyPos -= m_historyNum;

        // �q�X�g���ɋL��
        m_textArray[0][m_historyPos] = str;
        m_historyTime[m_historyPos] = CTime::GetCurrentTime();
        TRACE("%d:save history:%d\n", count, m_historyPos);
        historyAdd = true;
        needDispUpdate = true;
    }

    if(needDispUpdate) { // �\�����X�V���ׂ��󋵂�
        // �t�H�[�J�X���������A�t�H�[�J�X�������Ă��N�����Ȃ�Ε\�����X�V
        if(m_dispStatus != DS_focus || m_bootStatus != BS_ready) {
            m_edit.SetWindowText(str);
            m_template = 0;
            m_lookupPos[0] = m_historyPos;
            SetViewState();

            // �o���[���ɃR�s�[�ԍ���\��
            DispInfo(BALLOON_COPY);
        }
    }
    return historyAdd;
}

// �N���b�v�{�[�h�̓��e���F���ƈ�v���Ă��邩�m�F���Ĉ������Đڑ�����
bool CGhostBoardDlg::CheckCbConnect()
{
    bool update = OnCbUpdate(); // �N���b�v�{�[�h���X�V����Ă��Ȃ����m�F
    if(update) { // �X�V����Ă�����CB�C�x���g���󂯎��Ă��Ȃ�������
        // ��U�N���b�v�{�[�h�`�G�[������ؒf
        ChangeClipboardChain(m_nextClipboardViewerHandle);
        m_nextClipboardViewerHandle = 0;
        // �N������������Ȃ����� CB�`�F�C���Đڑ�
        m_bootStatus = BS_booting;
        return false;
    }
    return true;
}

void CGhostBoardDlg::OnChangeCbChain(HWND hWndRemove, HWND hWndAfter)
{
    CString msg(_T("OnChangeCbChain\n"));
    CDialog::OnChangeCbChain(hWndRemove, hWndAfter);

    if (hWndRemove == m_nextClipboardViewerHandle) {
        m_nextClipboardViewerHandle = hWndAfter;
        msg += _T("reconnect nextClip\n");
    }

    if (m_nextClipboardViewerHandle != (HWND)0) {
        /* ���̃N���b�v�{�[�h �r���[�A�֑��� */
        ::SendMessage(m_nextClipboardViewerHandle, WM_CHANGECBCHAIN, (WPARAM)hWndRemove, (LPARAM)hWndAfter);
        msg += _T("send WM_CHANGECBCHAIN");
    }
    DispInfo(BALLOON_ACTIVE, msg);
}

bool CGhostBoardDlg::SetTextToClipboard(CString &strText)
{
    TRACE("SetTextToClipboard\n");

    // �O���[�o���q�[�v��Ƀ������̈���m�ۂ��A��������R�s�[
    int iStrLen = WideCharToMultiByte(CP_ACP,0,strText,-1,NULL,0,NULL,NULL);	//�K�v�ȃo�C�g�����擾
    HGLOBAL hMem = ::GlobalAlloc(GMEM_FIXED, iStrLen); // �������擾
    char *text = (char *)GlobalLock(hMem); // ���������b�N
    WideCharToMultiByte(CP_ACP,0,strText,-1,text,iStrLen,NULL,NULL);//�������ւ̏�������
    ::GlobalUnlock(hMem); // ���������b�N����

    // �N���b�v�{�[�h�̃I�[�v��
    if( !::OpenClipboard(NULL) ) {
        MessageBox(_T("OpenClipboard FAIL"));
        return false;
    }

    ::EmptyClipboard();	// �N���b�v�{�[�h�̒��g����ɂ���
    ::SetClipboardData(CF_TEXT, hMem); // �N���b�v�{�[�h�ւ̃Z�b�g
    ::CloseClipboard(); // �N���b�v�{�[�h�̃N���[�Y

    return true;
}

//*************************************************** ��Ԃ̕ۑ��Ɠǂݏo��
bool CGhostBoardDlg::Save()
{
    FILE *fp;
    errno_t err;
    char buf[SAVE_TEXT_SIZE];

    GetWindowPlacement(&m_windowPos);

    if((err = fopen_s(&fp, "GhostBoard.dat", "w")) != 0) {
        MessageBox(_T("Can not open file <GhostBoard.dat>"));
        return false;
    }
 
    fprintf(fp, "left:%d, top:%d, right:%d, bottom:%d\n", 
         m_windowPos.rcNormalPosition.left,
         m_windowPos.rcNormalPosition.top,
         m_windowPos.rcNormalPosition.right,
         m_windowPos.rcNormalPosition.bottom);
    fprintf(fp, "iconNotif:%d\n", m_iconNotif);
    fprintf(fp, "alphaDefault:%d, alphaMouse:%d alphaActive:%d\n", m_alphaDefault, m_alphaMouse, m_alphaActive);
    fprintf(fp, "ctrl:%d, shift:%d, alt:%d, win:%d\n", m_confCtrl, m_confShift, m_confAlt, m_confWin);

    for(int j=1; j<TEMPLATE_NUM; j++) {
        for(int i=0; i<HISTORY_NUM; i++) {
            CString str = m_textArray[j][i];
            if(str != "") {
                str.Replace(_T("\\"), _T("\\\\"));
                str.Replace(_T("\n"), _T("\\n"));
                str.Replace(_T("\r"), _T("\\r"));
                fprintf(fp, "%d:%d:", j, i);
                WideCharToMultiByte(CP_ACP,0,str,-1,buf,SAVE_TEXT_SIZE,NULL,NULL);//�R�[�h�ϊ�
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

    GetWindowPlacement(&m_windowPos);

    if((err = fopen_s(&fp, "GhostBoard.dat", "r")) != 0) {
        return false;
    }
 
    fscanf_s(fp, "left:%d, top:%d, right:%d, bottom:%d\n", 
         &m_windowPos.rcNormalPosition.left,
         &m_windowPos.rcNormalPosition.top,
         &m_windowPos.rcNormalPosition.right,
         &m_windowPos.rcNormalPosition.bottom);
    SetWindowPlacement(&m_windowPos);

    fscanf_s(fp, "iconNotif:%d\n", &m_iconNotif);
    fscanf_s(fp, "alphaDefault:%d, alphaMouse:%d alphaActive:%d\n", &m_alphaDefault, &m_alphaMouse, &m_alphaActive); 
    fscanf_s(fp, "ctrl:%d, shift:%d, alt:%d, win:%d\n", &m_confCtrl, &m_confShift, &m_confAlt, &m_confWin);

    do{
        unsigned int tmp, idx;
        char buf[SAVE_TEXT_SIZE];
        ret = fscanf_s(fp, "%d:%d:", &tmp, &idx);
        if(ret > 0 && tmp < TEMPLATE_NUM && idx < HISTORY_NUM) {
            fgets(buf, SAVE_TEXT_SIZE, fp);
            m_textArray[tmp][idx] = buf;
            m_textArray[tmp][idx].Replace(_T("\r"), _T("")); // ���s�������폜
            m_textArray[tmp][idx].Replace(_T("\n"), _T("")); // ���s�������폜
            m_textArray[tmp][idx].Replace(_T("\\r"), _T("\r")); //�G�X�P�[�v���������𕜌�
            m_textArray[tmp][idx].Replace(_T("\\n"), _T("\n")); //�G�X�P�[�v���������𕜌�
            m_textArray[tmp][idx].Replace(_T("\\\\"), _T("\\")); //�G�X�P�[�v���������𕜌�
        }
    }while(ret > 0);

    fclose(fp);
    return true;
}

//*************************************************** �|�b�v�A�b�v���j���[
void CGhostBoardDlg::OnRButtonDown(UINT nFlags, CPoint point)
{
    rememberTemplate();

    PopUpMenu();

    CDialog::OnRButtonDown(nFlags, point);
}

void CGhostBoardDlg::PopUpMenu()
{
    POINT pnt;
    GetCursorPos(&pnt);
    int count;

    CMenu menu, *addPos;
    menu.LoadMenu(IDR_MENU_RBUTTON); // IDR_MENU_RBUTTON��ResourceView�Œǉ��������j���[

    count = 0;
    addPos = menu.GetSubMenu(0);
    int startCount = m_historyCount>=HISTORY_NUM?m_historyCount-HISTORY_NUM+1:0;
    for(int i = startCount; i <= m_historyCount; i++) {
        int pos = i % HISTORY_NUM;
        CString str;
        str.Format(_T("%02d [%s] "), i, m_historyTime[pos].Format("%H:%M"));
        str += m_textArray[0][pos].Left(32);
        str.Replace(_T("\n"),_T("|"));
        str.Replace(_T("\r"),_T(""));
        str.Replace(_T("\t"),_T("    "));
        addPos->InsertMenu(count++, MF_STRING | MF_BYPOSITION, ID_SEL_HISTORY+pos, str);
    }

    UINT ids[] = {ID_SEL_RED, ID_SEL_GREEN, ID_SEL_BLUE};
    for(int grp = 0; grp < 3; grp++) {
        addPos = menu.GetSubMenu(0)->GetSubMenu(count+1+grp);
        for(int i = HISTORY_NUM - 1; i >=0; i--) {
                CString str;
                str.Format(_T("%02d: "), i);
                str += m_textArray[grp+1][i].Left(32);
                str.Replace(_T("\n"),_T("|"));
                str.Replace(_T("\r"),_T(""));
                str.Replace(_T("\t"),_T("    "));
                addPos->AppendMenuW(MF_STRING, ids[grp]+i, str);
        }
    }

    menu.GetSubMenu(0)->TrackPopupMenu(TPM_LEFTALIGN | TPM_RIGHTBUTTON, pnt.x, pnt.y, this);
}

void CGhostBoardDlg::OnMenuClose()
{
    PostMessage(WM_CLOSE, 0, 0);
}

void CGhostBoardDlg::OnMenuSettings()
{
    CGhostBoardSettings dlg;
    dlg.m_alphaActive = m_alphaActive;
    dlg.m_alphaDefault = m_alphaDefault;
    dlg.m_alphaMouse = m_alphaMouse;
    dlg.m_ctrl = m_confCtrl;
    dlg.m_shift = m_confShift;
    dlg.m_alt = m_confAlt;
    dlg.m_win = m_confWin;
    dlg.m_iconNotifP = &m_iconNotif;
    INT_PTR nResponse = dlg.DoModal();
	if (nResponse == IDOK)
	{
        TRACE("Setting OK\n");
        // �����x��ݒ�
        m_alphaActive = dlg.m_alphaActive;
        m_alphaDefault = dlg.m_alphaDefault;
        m_alphaMouse = dlg.m_alphaMouse;
        // �z�b�g�L�[���Đݒ�
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

void CGhostBoardDlg::OnExecMenu(UINT uID)
{
    TRACE("OnExecMenu(%d)\n", uID - ID_SEL_HISTORY);

    if(uID >= ID_SEL_HISTORY && uID < ID_SEL_HISTORY+HISTORY_NUM) {
        m_template = 0;
        m_lookupPos[m_template] = uID - ID_SEL_HISTORY;
    }
    
    if(uID >= ID_SEL_RED && uID < ID_SEL_RED+HISTORY_NUM) {
        m_template = 1;
        m_lookupPos[m_template] = uID - ID_SEL_RED;
    }

    if(uID >= ID_SEL_GREEN && uID < ID_SEL_GREEN+HISTORY_NUM) {
        m_template = 2;
        m_lookupPos[m_template] = uID - ID_SEL_GREEN;
    }

    if(uID >= ID_SEL_BLUE && uID < ID_SEL_BLUE+HISTORY_NUM) {
        m_template = 3;
        m_lookupPos[m_template] = uID - ID_SEL_BLUE;
    }

    CString &selectedString = m_textArray[m_template][m_lookupPos[m_template]];
    // �����̓��e��ҏW�e�L�X�g�ɕ\��
    m_edit.SetWindowText(selectedString);

    SetViewState();
    DispInfo(BALLOON_ACTIVE); // �o���[���\��

    if(m_lastWindow && // ���E�B���h�E���擾�ł��Ă��āA
       !m_actKeyStatus && // �A�N�e�C�u�L�[��������Ă��炸�A����
       selectedString != "") // �I�����ꂽ�����񂪋�łȂ����
    {
        // �O�̃E�B���h�E�Ƀt�H�[�J�X��߂�
        ::SetForegroundWindow(m_lastWindow->m_hWnd);

        /* // �y�[�X�g����
        if(m_actKeyStatus) {
            TextInsertToOther(m_lastWindow->m_hWnd, selectedString);
        }
        */
    }
}

LRESULT CGhostBoardDlg::WindowProc(UINT message, WPARAM wParam, LPARAM lParam) 
{
	switch( message )
	{
	case WM_HOTKEY:	//�z�b�g�L�[�������܂����B
		TRACE( "HotKey %d, %d, %d\n", wParam, LOWORD( lParam ), HIWORD( lParam ) );
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
    
    case WM_TRYCLK: //�^�X�N�g���C
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

    int idx = m_template;
    if(idx < 0) idx = TEMPLATE_NUM; // �N���b�v�{�[�h���e�L�X�g���܂܂Ȃ���

    if(nCtlColor == CTLCOLOR_DLG) { // �_�C�A���O�g�̐F
        TRACE("OnCtlColor() t=%d\n", m_template);
        pDC->SetBkMode(OPAQUE); 
        pDC->SetBkColor(sm_color[idx]);
        return m_brush[idx];
    }
    if(idx == TEMPLATE_NUM && nCtlColor == CTLCOLOR_EDIT) { // �G�f�B�b�g�\���̐F
        pDC->SetBkMode(OPAQUE); 
        pDC->SetBkColor(sm_color[idx]);
        return m_brush[idx];
    }

    // TODO:  ����l���g�p�������Ȃ��ꍇ�͕ʂ̃u���V��Ԃ��܂��B
    return hbr;
}

void CGhostBoardDlg::HistoryBackward()
{
    if(m_template<0) {
        m_template = 0;
    }
    else {
        rememberTemplate();
        // �����Q�ƈʒu���X�V
        m_lookupPos[m_template] --;
        if(m_lookupPos[m_template] < 0)
            m_lookupPos[m_template]+=m_template?HISTORY_NUM:m_historyNum;
    }
    // �����̓��e��ҏW�e�L�X�g�ɕ\��
    m_edit.SetWindowText(m_textArray[m_template][m_lookupPos[m_template]]);
    // �ҏW��ԂłȂ���΃N���b�v�{�[�h�ɃR�s�[
	if(m_dispStatus != DS_focus) {
	    SetTextToClipboard(m_textArray[m_template][m_lookupPos[m_template]]);
    }
    
    TRACE("HistoryBackward():%d,%d\n", m_template, m_lookupPos[m_template]);

    DispInfo(BALLOON_ACTIVE); // �o���[���\��
}

void CGhostBoardDlg::HistoryForward()
{
    if(m_template<0) {
        m_template = 0;
    }
    else {
        rememberTemplate();
        // �����Q�ƈʒu���X�V
        m_lookupPos[m_template] ++;
        if(m_template) {
            if(m_lookupPos[m_template] >= HISTORY_NUM)
                m_lookupPos[m_template] -= HISTORY_NUM;
        }
        else {
            if(m_lookupPos[m_template] >= m_historyNum)
                m_lookupPos[m_template] -= m_historyNum;
        }
    }
    // �����̓��e��ҏW�e�L�X�g�ɕ\��
    m_edit.SetWindowText(m_textArray[m_template][m_lookupPos[m_template]]);
    // �ҏW��ԂłȂ���΃N���b�v�{�[�h�ɃR�s�[
	if(m_dispStatus != DS_focus) {
	    SetTextToClipboard(m_textArray[m_template][m_lookupPos[m_template]]);
    }
    
	TRACE("HistoryForward():%d,%d\n", m_template, m_lookupPos[m_template]);
    
    DispInfo(BALLOON_ACTIVE); // �o���[���\��
}

void CGhostBoardDlg::TemplateBackward()
{
    rememberTemplate();
    // �Q�ƃe���v���[�g���X�V
    if(m_template < 0) {
        m_template = 0;
    }
    else if(m_template == 0) {
        m_template = TEMPLATE_NUM - 1;
    }
    else {
        m_template --;
    }
    // �����̓��e��ҏW�e�L�X�g�ɕ\��
    m_edit.SetWindowText(m_textArray[m_template][m_lookupPos[m_template]]);
    // �ҏW��ԂłȂ���΃N���b�v�{�[�h�ɃR�s�[
	if(m_dispStatus != DS_focus) {
	    SetTextToClipboard(m_textArray[m_template][m_lookupPos[m_template]]);
    }

	TRACE("TemplateBackward():%d,%d\n", m_template, m_lookupPos[m_template]);
    
    DispInfo(BALLOON_ACTIVE); // �o���[���\��
    SetViewState();
}

void CGhostBoardDlg::TemplateForward()
{
    rememberTemplate();
    // �Q�ƃe���v���[�g���X�V
    m_template ++;
    if(m_template >= TEMPLATE_NUM) m_template -= TEMPLATE_NUM;
    // �����̓��e��ҏW�e�L�X�g�ɕ\��
    m_edit.SetWindowText(m_textArray[m_template][m_lookupPos[m_template]]);
    // �ҏW��ԂłȂ���΃N���b�v�{�[�h�ɃR�s�[
	if(m_dispStatus != DS_focus) {
	    SetTextToClipboard(m_textArray[m_template][m_lookupPos[m_template]]);
    }

	TRACE("TemplateBackward():%d,%d\n", m_template, m_lookupPos[m_template]);
    
    DispInfo(BALLOON_ACTIVE); // �o���[���\��
    SetViewState();
}

void CGhostBoardDlg::rememberTemplate()
{
    if(m_template<0) {
        // N/A��Ԃ̏ꍇ
        return;
    }

    // ���݂̕ҏW�e�L�X�g�𗚗�or�e���v���[�g�Ɋi�[
    CString str;
    m_edit.GetWindowText(str);
    m_textArray[m_template][m_lookupPos[m_template]] = str;
}

void CGhostBoardDlg::DispInfo(UINT timeout_ms, LPCWSTR msg)
{
    //�o���[���\��
    if(!m_iconNotif || m_bootStatus != BS_ready) return;

    m_icon.uFlags = NIF_INFO;
    if(msg) {
        wsprintf(m_icon.szInfo, msg);
    }
    else if(m_template == 0) {
        // �N���b�v�{�[�h����
        int hisNum = m_lookupPos[0] - m_historyPos;
        if(hisNum>0) hisNum -= m_historyNum;
        hisNum += m_historyCount;
        wsprintf(m_icon.szInfo, _T("%02d [%s]"), hisNum, m_historyTime[m_lookupPos[0]].Format("%H:%M"));
    }
    else if(m_template > 0) {
        // �e���v���[�g�\��
        wsprintf(m_icon.szInfo, _T("%c%02d"), " RGB"[m_template], m_lookupPos[m_template]);
    }
    else {
        // �e���v���[�g�\��
        wsprintf(m_icon.szInfo, _T("not TEXT"));
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

void CGhostBoardDlg::DispAlert(LPCWSTR msg)
{
    m_edit.SetWindowText(msg);
    m_template = -1;
    SetViewState();
}

void CGhostBoardDlg::StartHotKey()
{
    int actKey = (m_confCtrl?MOD_CONTROL:0)
               | (m_confShift?MOD_SHIFT:0)
               | (m_confAlt?MOD_ALT:0)
               | (m_confWin?MOD_WIN:0);
    m_hotKeyUp  =(actKey<<8) + VK_UP;   // ����O
    m_hotKeyDown=(actKey<<8) + VK_DOWN; // ������
    m_hotKeyLeft =(actKey<<8) + VK_LEFT;   // �e���v���[�g�t
    m_hotKeyRight=(actKey<<8) + VK_RIGHT;  // �e���v���[�g��
    m_hotKeyEnter=(actKey<<8) + VK_RETURN; // �t�H�[�J�X

    if(!::RegisterHotKey(m_hWnd, m_hotKeyUp,   m_hotKeyUp  >>8, m_hotKeyUp  &0xFF ))
        MessageBox(_T("FAIL: RegisterHotKey(): history prior"));

    if(!::RegisterHotKey(m_hWnd, m_hotKeyDown, m_hotKeyDown>>8, m_hotKeyDown&0xFF ))
        MessageBox(_T("FAIL: RegisterHotKey(): history next"));

    if(!::RegisterHotKey(m_hWnd, m_hotKeyLeft, m_hotKeyLeft>>8, m_hotKeyLeft&0xFF ))
        MessageBox(_T("FAIL: RegisterHotKey(): template prior"));

    if(!::RegisterHotKey(m_hWnd, m_hotKeyRight, m_hotKeyRight>>8, m_hotKeyRight&0xFF ))
        MessageBox(_T("FAIL: RegisterHotKey(): template next"));

//    if(!::RegisterHotKey(m_hWnd, m_hotKeyEnter, m_hotKeyEnter>>8, m_hotKeyEnter&0xFF ))
//        MessageBox(_T("FAIL: RegisterHotKey(): focus"));
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

//    if(!::UnregisterHotKey(m_hWnd, m_hotKeyEnter))
//        MessageBox(_T("FAIL: UnregisterHotKey(): focus"));
}
/*
// ���̃A�v���P�[�V�����ւ̕�����}��
void CGhostBoardDlg::TextInsertToOther(HWND hWnd, CString &str)
{
    // ����̃t�H�[�J�XWindow���擾
    Sleep(GET_FOCUS_WAIT);
    DWORD dw_me=GetWindowThreadProcessId(m_hWnd,NULL);
    DWORD dw_he=GetWindowThreadProcessId(hWnd,NULL);
    AttachThreadInput(dw_me,dw_he,TRUE);
    HWND w = ::GetFocus();
    AttachThreadInput(dw_me,dw_he,FALSE);

    TRACE("TextInsertToOther->%X\n", w);
    //::SendMessage(w, WM_PASTE, 0, 0); �����Ȃ��A�v��������

    int len=str.GetLength();
    for(int i=0; i < len; i++) {
        TRACE("%X ", str[i]);
        if(str[i] == 0x0d) break; // ���s������Ƃ��������Ȃ�A�v��������
        //::SendMessage(w, WM_CHAR, (WPARAM)str[i], 0);
        ::SendMessage(w, WM_IME_CHAR, (WPARAM)str[i], 0);
    }
    TRACE("\n");
}
*/
