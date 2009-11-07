// GhostBoardDlg.cpp : �����t�@�C��
//

#include "stdafx.h"
#include "GhostBoard.h"
#include "GhostBoardDlg.h"
#include "GHostBoardSettings.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

// CGhostBoardDlg �_�C�A���O

CGhostBoardDlg::CGhostBoardDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CGhostBoardDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);

    // �����o�ϐ�������
    m_leftDown = false;
    m_initialized = false;
    m_activate = false;
    m_activeKey = false;
    m_mouseDistance = 0;
    m_mouseDistanceFar = 100;
    m_hide = false;
    // �f�t�H���g�̓����x��200�B�}�E�X�ڋߎ��̓����x��50�B
    m_alphaDefault = 200;
    m_alphaMouse = 50;
    // �f�t�H���g�̃A�N�e�B�u�L�[��Ctrl+Alt
    m_confCtrl = true;
    m_confShift = false;
    m_confAlt = true;
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
END_MESSAGE_MAP()


// CGhostBoardDlg ���b�Z�[�W �n���h��

BOOL CGhostBoardDlg::OnInitDialog()
{
    ModifyStyleEx(WS_EX_APPWINDOW, WS_EX_TOOLWINDOW); // �^�X�N�o�[�ɕ\�����Ȃ�
//    ModifyStyleEx(WS_EX_TOOLWINDOW, WS_EX_APPWINDOW); // �^�X�N�o�[�ɕ\������
	CDialog::OnInitDialog();

	// ���̃_�C�A���O�̃A�C�R����ݒ肵�܂��B�A�v���P�[�V�����̃��C�� �E�B���h�E���_�C�A���O�łȂ��ꍇ�A
	//  Framework �́A���̐ݒ�������I�ɍs���܂��B
	SetIcon(m_hIcon, TRUE);			// �傫���A�C�R���̐ݒ�
	SetIcon(m_hIcon, FALSE);		// �������A�C�R���̐ݒ�

    //---- �E�B���h�E�^�C�g��
    SetWindowText(_T("GhostBoard"));

    //---- ����������
    m_historyPos = -1;
    m_historyLookup = 0;
    m_historyNum = 0;

    //---- �ŏ����{�^���̕\��
    //ModifyStyle(0, WS_MINIMIZEBOX);
    m_hide = false;

    //---- �^�X�N�g���C�\��
    m_icon.cbSize = sizeof(NOTIFYICONDATA);
    m_icon.uID = 0;
    m_icon.hWnd = m_hWnd;
    m_icon.uFlags = NIF_ICON | NIF_MESSAGE | NIF_TIP;
    m_icon.hIcon = AfxGetApp()->LoadIcon( IDR_MAINFRAME );
    m_icon.uCallbackMessage = WM_TRYCLK;
    lstrcpy( m_icon.szTip, _T("GhostBoard"));
    // �o���[���ݒ�
    m_icon.uTimeout = 10000;
    m_icon.dwInfoFlags = NIIF_NONE|NIIF_NOSOUND;
    lstrcpy(m_icon.szInfoTitle, _T(""));
    lstrcpy(m_icon.szInfo, _T(""));
    ::Shell_NotifyIcon( NIM_ADD, &m_icon );

    //---- �N���b�v�{�[�h�̊Ď�
    m_nextClipboardViewerHandle = SetClipboardViewer();

    //---- ������
    SetViewState();

    //---- �A�N�e�B�u�L�[���}�E�X�ʒu�̒���Ď��^�C�}�[�X�^�[�g
    SetTimer(0, 100, NULL);

    //---- �����������t���O
    m_initialized = true;

    //---- �O��Ԃ̓ǂݏo��
    Load();

    //---- �z�b�g�L�[�̐ݒ�
    StartHotKey();

	return TRUE;  // �t�H�[�J�X���R���g���[���ɐݒ肵���ꍇ�������ATRUE ��Ԃ��܂��B
}

void CGhostBoardDlg::OnDestroy()
{
    CDialog::OnDestroy();

    // TODO: �����Ƀ��b�Z�[�W �n���h�� �R�[�h��ǉ����܂��B

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

//************************************************** �A�N�e�B�u�L�[�ƃ}�E�X�ʒu�̊Ď�
void CGhostBoardDlg::OnTimer(UINT_PTR nIDEvent)
{
    POINT mousePnt;
    WINDOWPLACEMENT windowPos;
    UINT dist, distX, distY;

    // �A�N�e�B�u��Ԃ̊m�F
    if(::GetActiveWindow() == m_hWnd)
        m_activate = true;
    else
        m_activate = false;

    // �}�E�X�ʒu�̊Ď�
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

    // �A�N�e�B�u�L�[�̊Ď�
    if( (!m_confCtrl  || ::GetAsyncKeyState(VK_CONTROL)) &&
        (!m_confShift || ::GetAsyncKeyState(VK_SHIFT)) &&
        (!m_confAlt   || ::GetAsyncKeyState(VK_MENU)) ) { // �A�N�e�B�u�L�[��������Ă���Ȃ�
        if(!m_activeKey) {
            m_activeKey = true;
            SetViewState();
        }
    }
    else{ // �A�N�e�B�u�L�[��������Ă���Ȃ�
        if(m_activeKey) {
            m_activeKey = false;
            SetViewState();
            // �A�N�e�B�u�L�[�������ꂽ�^�C�~���O�ŃN���b�v�{�[�h�ɃR�s�[
            CString str;
            m_edit.GetWindowText(str);
            SetTextToClipboard(str);
        }
    }

    CDialog::OnTimer(nIDEvent);
}


//************************************************** ������
void CGhostBoardDlg::SetViewState()
{
    static bool s_active = false;

    if(m_activate || m_activeKey) {
        if(s_active == false) {
            TRACE("SetViewState():active\n");
            // �A�N�e�B�u�ɂȂ�����
            s_active = true;
            ModifyStyleEx(WS_EX_TRANSPARENT, 0); // ���߉���
            SetLayeredWindowAttributes(0, 255, LWA_ALPHA); // �\���Z�W100��

            //�o���[���\��
            DispInfo();
        }
    }
    else {
        if(s_active == true) {
            TRACE("SetViewState():alpha\n");
            s_active = false;
            // ��A�N�e�B�u�ɂȂ�����
            ModifyStyleEx(0, WS_EX_LAYERED | WS_EX_TRANSPARENT); // ���ߐݒ�

            //�o���[���\������
            m_icon.uFlags = NIF_INFO;
            lstrcpy(m_icon.szInfoTitle, _T(""));
            wsprintf(m_icon.szInfo, _T(""));
            ::Shell_NotifyIcon( NIM_MODIFY, &m_icon );
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
}

//*************************************************** �E�B���h�E�t�H�[�J�X�̊Ď�
void CGhostBoardDlg::OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized)
{
    CDialog::OnActivate(nState, pWndOther, bMinimized);

    TRACE("OnActivate:%d\n", nState);
    if(nState == WA_ACTIVE || nState == WA_CLICKACTIVE) {
        TRACE("GetFocus\n");
            m_activate = true;
            SetViewState();
    }
    else {
        TRACE("LostFocus\n");
            CString str;
            m_edit.GetWindowText(str);
            SetTextToClipboard(str);
            m_activate = false;
            SetViewState();

            Save();
    }
}

//*************************************************** �N���b�v�{�[�h�̊Ď��Ə�������
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
                if(m_historyArray[m_historyLookup] != str) { // ���ݎQ�ƒ��ƈقȂ镶����̏ꍇ�̂ݍX�V����
                    m_historyPos ++;
                    if(m_historyPos>=m_historyNum && m_historyNum < HISTORY_NUM)
                        m_historyNum ++;
                    if(m_historyPos >= m_historyNum) m_historyPos -= m_historyNum;

                    // �q�X�g���ɋL��
                    m_historyArray[m_historyPos] = str;
                    m_historyTime[m_historyPos] = CTime::GetCurrentTime();
                    TRACE("save history:%d\n", m_historyPos);

                    // �A�N�e�B�u�łȂ����A�\�����̃o�b�t�@���X�V���ꂽ�ꍇ�͕\��
                    if(!m_activate || m_historyLookup == m_historyPos) {
                        m_edit.SetWindowText(str);
                        m_historyLookup = m_historyPos;
                    }
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
        /* ���̃N���b�v�{�[�h �r���[�A�֑��� */
        ::SendMessage(m_nextClipboardViewerHandle, WM_CHANGECBCHAIN, (WPARAM)hWndRemove, (LPARAM)hWndAfter);
    }
}

bool CGhostBoardDlg::SetTextToClipboard(CString &strText)
{
    TRACE("SetTextToClipboard\n");

    // �����񂪋�̏ꍇ�̓R�s�[���Ȃ�
    if( strText.IsEmpty() )
        return false;

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
    fprintf(fp, "ctrl:%d, shift:%d, alt:%d\n", m_confCtrl, m_confShift, m_confAlt);
 
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
 
    fscanf_s(fp, "left:%d, top:%d, right:%d, bottom:%d\n", 
         &wPos.rcNormalPosition.left, &wPos.rcNormalPosition.top, &wPos.rcNormalPosition.right, &wPos.rcNormalPosition.bottom);
    SetWindowPlacement(&wPos);

    fscanf_s(fp, "hide:%d\n", &m_hide);
    fscanf_s(fp, "alphaDefault:%d, alphaMouse:%d\n", &m_alphaDefault, &m_alphaMouse); 
    fscanf_s(fp, "ctrl:%d, shift:%d, alt:%d\n", &m_confCtrl, &m_confShift, &m_confAlt);

    fclose(fp);
    return true;
}

//*************************************************** �|�b�v�A�b�v���j���[
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
    menu.LoadMenu(IDR_MENU_RBUTTON); // IDR_MENU1��ResourceView�Œǉ��������j���[
    menu.CheckMenuItem(ID_MENU_HIDE, m_hide?MF_CHECKED:MF_UNCHECKED); // ��\����Ԃ��`�F�b�N�ŕ\��
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
    INT_PTR nResponse = dlg.DoModal();
	if (nResponse == IDOK)
	{
        TRACE("Setting OK\n");
        // �����x��ݒ�
        m_alphaDefault = dlg.m_alphaDefault;
        m_alphaMouse = dlg.m_alphaMouse;
        // �z�b�g�L�[���Đݒ�
        StopHotKey();
        m_confCtrl = dlg.m_ctrl;
        m_confShift = dlg.m_shift;
        m_confAlt = dlg.m_alt;
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
	case WM_HOTKEY:	//�z�b�g�L�[�������܂����B
		TRACE( "%d, %d, %d\n", wParam, LOWORD( lParam ), HIWORD( lParam ) );
        if(wParam == m_hotKeyUp) {
            HistoryBackward();
        }
        if(wParam == m_hotKeyDown) {
            HistoryForward();
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

void CGhostBoardDlg::HistoryBackward()
{
    // ���݂̕ҏW�e�L�X�g�𗚗��Ɋi�[
    CString str;
    m_edit.GetWindowText(str);
    m_historyArray[m_historyLookup] = str;
    // �����Q�ƈʒu���X�V
    m_historyLookup --;
    if(m_historyLookup < 0) m_historyLookup += m_historyNum;
    // �����̓��e��ҏW�e�L�X�g�ɕ\��
    m_edit.SetWindowText(m_historyArray[m_historyLookup]);
    
    TRACE("HistoryBackward():%d\n", m_historyLookup);

    DispInfo(); // �o���[���\��
}

void CGhostBoardDlg::HistoryForward()
{
    // ���݂̕ҏW�e�L�X�g�𗚗��Ɋi�[
    CString str;
    m_edit.GetWindowText(str);
    m_historyArray[m_historyLookup] = str;
    // �����Q�ƈʒu���X�V
    m_historyLookup ++;
    if(m_historyLookup >= m_historyNum) m_historyLookup -= m_historyNum;
    // �����̓��e��ҏW�e�L�X�g�ɕ\��
    m_edit.SetWindowText(m_historyArray[m_historyLookup]);
    TRACE("HistoryForward():%d\n", m_historyLookup);
    
    DispInfo(); // �o���[���\��
}

void CGhostBoardDlg::DispInfo()
{
    //�o���[���\��
    m_icon.uFlags = NIF_INFO;
    int hisNum = m_historyPos - m_historyLookup;
    if(hisNum<0) hisNum += m_historyNum;
    wsprintf(m_icon.szInfo, _T("%d (%s)"), hisNum, m_historyTime[m_historyLookup].Format("%H:%M:%S"));
    ::Shell_NotifyIcon( NIM_MODIFY, &m_icon );
}

void CGhostBoardDlg::StartHotKey()
{
    int actKey = (m_confCtrl?MOD_CONTROL:0)
               | (m_confShift?MOD_SHIFT:0)
               | (m_confAlt?MOD_ALT:0);
    m_hotKeyUp  =(actKey<<8) + VK_UP;   // ����O
    m_hotKeyDown=(actKey<<8) + VK_DOWN; // ������

    if(!::RegisterHotKey(m_hWnd, m_hotKeyUp,   m_hotKeyUp  >>8, m_hotKeyUp  &0xFF ))
        MessageBox(_T("FAIL: RegisterHotKey(): history prior"));

    if(!::RegisterHotKey(m_hWnd, m_hotKeyDown, m_hotKeyDown>>8, m_hotKeyDown&0xFF ))
        MessageBox(_T("FAIL: RegisterHotKey(): history next"));
}

void CGhostBoardDlg::StopHotKey()
{
    if(!::UnregisterHotKey(m_hWnd, m_hotKeyUp))
        MessageBox(_T("FAIL: UnregisterHotKey(): history prior"));

    if(!::UnregisterHotKey(m_hWnd, m_hotKeyDown))
        MessageBox(_T("FAIL: UnregisterHotKey(): history next"));
}