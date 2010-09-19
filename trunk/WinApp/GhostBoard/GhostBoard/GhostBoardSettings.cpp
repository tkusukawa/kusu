// GhostBoardSettings.cpp : 実装ファイル
//

#include "stdafx.h"
#include "GhostBoard.h"
#include "GhostBoardSettings.h"


// CGhostBoardSettings ダイアログ

IMPLEMENT_DYNAMIC(CGhostBoardSettings, CDialog)

CGhostBoardSettings::CGhostBoardSettings(CWnd* pParent /*=NULL*/)
	: CDialog(CGhostBoardSettings::IDD, pParent)
{

}

CGhostBoardSettings::~CGhostBoardSettings()
{
}

void CGhostBoardSettings::DoDataExchange(CDataExchange* pDX)
{
    CDialog::DoDataExchange(pDX);
    DDX_Control(pDX, IDC_SLIDER_APLHA_ACTIVE, m_sliderAlphaActive);
    DDX_Control(pDX, IDC_SLIDER_ALPHA_DEFAULT, m_sliderAlphaDefault);
    DDX_Control(pDX, IDC_SLIDER_ALPHA_MOUSE, m_sliderAlphaMouse);
    DDX_Control(pDX, IDC_CHECK_CTRL, m_checkCtrl);
    DDX_Control(pDX, IDC_CHECK_SHIFT, m_checkShift);
    DDX_Control(pDX, IDC_CHECK_ALT, m_checkAlt);
    DDX_Control(pDX, IDC_CHECK_WIN, m_checkWin);
    DDX_Control(pDX, IDC_CHECK_ICON_NOTIF, m_checkIconNotif);
    DDX_Control(pDX, IDC_HOTKEY_UP, m_hotKeyUp);
    DDX_Control(pDX, IDC_HOTKEY_DOWN, m_hotKeyDown);
    DDX_Control(pDX, IDC_HOTKEY_LEFT, m_hotKeyLeft);
    DDX_Control(pDX, IDC_HOTKEY_RIGHT, m_hotKeyRight);
    DDX_Control(pDX, IDC_SLIDER_ALPHA_LIST, m_sliderAlphaList);
    DDX_Control(pDX, IDC_EDIT_LIST_HEIGHT, m_editListHeight);
    DDX_Control(pDX, IDC_HOTKEY_MENU, m_hotKeyMenu);
    DDX_Control(pDX, IDC_HOTKEY_FOCUS, m_hotKeyFocus);
}


BEGIN_MESSAGE_MAP(CGhostBoardSettings, CDialog)
    ON_BN_CLICKED(IDOK, &CGhostBoardSettings::OnBnClickedOk)
    ON_BN_CLICKED(IDC_CHECK_CTRL, &CGhostBoardSettings::OnBnClickedCheckCtrl)
    ON_BN_CLICKED(IDC_CHECK_SHIFT, &CGhostBoardSettings::OnBnClickedCheckShift)
    ON_BN_CLICKED(IDC_CHECK_ALT, &CGhostBoardSettings::OnBnClickedCheckAlt)
    ON_BN_CLICKED(IDC_CHECK_WIN, &CGhostBoardSettings::OnBnClickedCheckWin)
END_MESSAGE_MAP()


// CGhostBoardSettings メッセージ ハンドラ
BOOL CGhostBoardSettings::OnInitDialog()
{
	CDialog::OnInitDialog();

    TRACE("Settings Open\n");
    // スライダの初期状態を設定
    m_sliderAlphaActive.SetRange(0,255);
    m_sliderAlphaDefault.SetRange(0,255);
    m_sliderAlphaMouse.SetRange(0,255);
    m_sliderAlphaList.SetRange(0,255);

    m_sliderAlphaActive.SetPos(m_alphaActive);
    m_sliderAlphaDefault.SetPos(m_alphaDefault);
    m_sliderAlphaMouse.SetPos(m_alphaMouse);
    m_sliderAlphaList.SetPos(m_alphaList);

    // チェックボックスの初期状態を設定
    if(m_ctrl)  m_checkCtrl.SetCheck(BST_CHECKED);
    if(m_shift) m_checkShift.SetCheck(BST_CHECKED);
    if(m_alt)   m_checkAlt.SetCheck(BST_CHECKED);
    if(m_win)   m_checkWin.SetCheck(BST_CHECKED);
    if(*m_iconNotifP) m_checkIconNotif.SetCheck(BST_CHECKED);

    // ホットキーの初期状態を設定
    m_hotKeyUp   .SetHotKey(m_hotKeyUpCode    & 0xFF, m_hotKeyUpCode >> 8);
    m_hotKeyDown .SetHotKey(m_hotKeyDownCode  & 0xFF, m_hotKeyDownCode >> 8);
    m_hotKeyLeft .SetHotKey(m_hotKeyLeftCode  & 0xFF, m_hotKeyLeftCode >> 8);
    m_hotKeyRight.SetHotKey(m_hotKeyRightCode & 0xFF, m_hotKeyRightCode >> 8);
    m_hotKeyMenu .SetHotKey(m_hotKeyMenuCode  & 0xFF, m_hotKeyMenuCode  >> 8);
    m_hotKeyFocus.SetHotKey(m_hotKeyFocusCode & 0xFF, m_hotKeyFocusCode >> 8);

	// エディットボックスの初期状態を設定
	CString str;
	str.Format(_T("%d"), m_listHeight);
	m_editListHeight.SetWindowText(str);

	return TRUE;  // フォーカスをコントロールに設定した場合を除き、TRUE を返します。
}

void CGhostBoardSettings::OnBnClickedCheckCtrl()
{
    // 全てのチェックが外れたらどれかをチェックする
    if((m_checkCtrl.GetCheck()|
        m_checkShift.GetCheck()|
        m_checkAlt.GetCheck()|
        m_checkWin.GetCheck())==false) {
        m_checkShift.SetCheck(BST_CHECKED);
    }
}

void CGhostBoardSettings::OnBnClickedCheckShift()
{
    // 全てのチェックが外れたらどれかをチェックする
    if((m_checkCtrl.GetCheck()|
        m_checkShift.GetCheck()|
        m_checkAlt.GetCheck()|
        m_checkWin.GetCheck())==false) {
        m_checkAlt.SetCheck(BST_CHECKED);
    }
}

void CGhostBoardSettings::OnBnClickedCheckAlt()
{
    // 全てのチェックが外れたらどれかをチェックする
    if((m_checkCtrl.GetCheck()|
        m_checkShift.GetCheck()|
        m_checkAlt.GetCheck()|
        m_checkWin.GetCheck())==false) {
        m_checkWin.SetCheck(BST_CHECKED);
    }
}

void CGhostBoardSettings::OnBnClickedCheckWin()
{
    // 全てのチェックが外れたらどれかをチェックする
    if((m_checkCtrl.GetCheck()|
        m_checkShift.GetCheck()|
        m_checkAlt.GetCheck()|
        m_checkWin.GetCheck())==false) {
        m_checkCtrl.SetCheck(BST_CHECKED);
    }
}

void CGhostBoardSettings::OnBnClickedOk()
{
    // OK時に 状態を反映
    m_alphaActive = m_sliderAlphaActive.GetPos();
    m_alphaDefault = m_sliderAlphaDefault.GetPos();
    m_alphaMouse = m_sliderAlphaMouse.GetPos();
    m_alphaList = m_sliderAlphaList.GetPos();

    m_ctrl = (m_checkCtrl.GetCheck() == BST_CHECKED);
    m_shift = (m_checkShift.GetCheck() == BST_CHECKED);
    m_alt = (m_checkAlt.GetCheck() == BST_CHECKED);
    m_win = (m_checkWin.GetCheck() == BST_CHECKED);

    *m_iconNotifP = (m_checkIconNotif.GetCheck() == BST_CHECKED);

    // ホットキーの設定を変数に反映
    m_hotKeyUpCode    = m_hotKeyUp   .GetHotKey();
    m_hotKeyDownCode  = m_hotKeyDown .GetHotKey();
    m_hotKeyLeftCode  = m_hotKeyLeft .GetHotKey();
    m_hotKeyRightCode = m_hotKeyRight.GetHotKey();
    m_hotKeyMenuCode  = m_hotKeyMenu .GetHotKey();
    m_hotKeyFocusCode = m_hotKeyFocus.GetHotKey();

	// エディットボックスの内容を変数に反映
	CString str;
	m_editListHeight.GetWindowText(str);
	m_listHeight = _ttoi(str);

    OnOK();
}
