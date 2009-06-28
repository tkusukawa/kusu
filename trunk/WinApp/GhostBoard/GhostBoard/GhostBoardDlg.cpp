// GhostBoardDlg.cpp : �����t�@�C��
//

#include "stdafx.h"
#include "GhostBoard.h"
#include "GhostBoardDlg.h"

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


// CGhostBoardDlg ���b�Z�[�W �n���h��

BOOL CGhostBoardDlg::OnInitDialog()
{
//    ModifyStyleEx(WS_EX_APPWINDOW, WS_EX_TOOLWINDOW); // �^�X�N�o�[�ɕ\�����Ȃ�
//    ModifyStyleEx(WS_EX_TOOLWINDOW, WS_EX_APPWINDOW); // �^�X�N�o�[�ɕ\������
	CDialog::OnInitDialog();

	// ���̃_�C�A���O�̃A�C�R����ݒ肵�܂��B�A�v���P�[�V�����̃��C�� �E�B���h�E���_�C�A���O�łȂ��ꍇ�A
	//  Framework �́A���̐ݒ�������I�ɍs���܂��B
	SetIcon(m_hIcon, TRUE);			// �傫���A�C�R���̐ݒ�
	SetIcon(m_hIcon, FALSE);		// �������A�C�R���̐ݒ�

    //---- �ŏ����{�^���̕\��
    ModifyStyle(0, WS_MINIMIZEBOX);

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

    SetWindowText(_T("GhostBoard"));


	return TRUE;  // �t�H�[�J�X���R���g���[���ɐݒ肵���ꍇ�������ATRUE ��Ԃ��܂��B
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
    if (::GetAsyncKeyState(VK_CONTROL) && ::GetAsyncKeyState(VK_MENU)) { // �A�N�e�B�u�L�[��������Ă���Ȃ�
        if(!m_activeKey) {
            m_activeKey = true;
            SetViewState();
        }
    }
    else{ // �A�N�e�B�u�L�[��������Ă���Ȃ�
        if(m_activeKey) {
            m_activeKey = false;
            SetViewState();
        }
    }

    CDialog::OnTimer(nIDEvent);
}


//************************************************** ������
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

//*************************************************** �E�B���h�E�t�H�[�J�X�̊Ď�
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

//*************************************************** �N���b�v�{�[�h�̊Ď��Ə�������
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
                //if(lastClip == str) { // �O��Ɠ������e���R�s�[���ꂽ��\�����X�V����
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
        /* ���̃N���b�v�{�[�h �r���[�A�֑��� */
        ::SendMessage(m_nextClipboardViewerHandle, WM_CHANGECBCHAIN, (WPARAM)hWndRemove, (LPARAM)hWndAfter);
    }
}

bool CGhostBoardDlg::SetTextToClipboard(CString &strText)
{
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
    menu.LoadMenu(IDR_MENU_RBUTTON); // IDR_MENU1��ResourceView�Œǉ��������j���[
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
