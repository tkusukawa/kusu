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
    DDX_Control(pDX, IDC_SLIDER_ALPHA_DEFAULT, m_sliderAlphaDefault);
    DDX_Control(pDX, IDC_SLIDER_ALPHA_MOUSE, m_sliderAlphaMouse);
    DDX_Control(pDX, IDC_CHECK_CTRL, m_checkCtrl);
    DDX_Control(pDX, IDC_CHECK_SHIFT, m_checkShift);
    DDX_Control(pDX, IDC_CHECK_ALT, m_checkAlt);
}


BEGIN_MESSAGE_MAP(CGhostBoardSettings, CDialog)
    ON_BN_CLICKED(IDOK, &CGhostBoardSettings::OnBnClickedOk)
    ON_BN_CLICKED(IDC_CHECK_CTRL, &CGhostBoardSettings::OnBnClickedCheckCtrl)
    ON_BN_CLICKED(IDC_CHECK_SHIFT, &CGhostBoardSettings::OnBnClickedCheckShift)
    ON_BN_CLICKED(IDC_CHECK_ALT, &CGhostBoardSettings::OnBnClickedCheckAlt)
END_MESSAGE_MAP()


// CGhostBoardSettings メッセージ ハンドラ
BOOL CGhostBoardSettings::OnInitDialog()
{
	CDialog::OnInitDialog();

    TRACE("Settings Open\n");
    // スライダの初期状態を設定
    m_sliderAlphaDefault.SetRange(0,255);
    m_sliderAlphaMouse.SetRange(0,255);
    m_sliderAlphaDefault.SetPos(m_alphaDefault);
    m_sliderAlphaMouse.SetPos(m_alphaMouse);

    // チェックボックスの初期状態を設定
    if(m_ctrl)  m_checkCtrl.SetCheck(BST_CHECKED);
    if(m_shift) m_checkShift.SetCheck(BST_CHECKED);
    if(m_alt)   m_checkAlt.SetCheck(BST_CHECKED);

	return TRUE;  // フォーカスをコントロールに設定した場合を除き、TRUE を返します。
}

void CGhostBoardSettings::OnBnClickedCheckCtrl()
{
    // 全てのチェックが外れたらどれかをチェックする
    if((m_checkCtrl.GetCheck()|m_checkShift.GetCheck()|m_checkAlt.GetCheck())==false)
        m_checkShift.SetCheck(BST_CHECKED);
}

void CGhostBoardSettings::OnBnClickedCheckShift()
{
    // 全てのチェックが外れたらどれかをチェックする
    if((m_checkCtrl.GetCheck()|m_checkShift.GetCheck()|m_checkAlt.GetCheck())==false)
        m_checkAlt.SetCheck(BST_CHECKED);
}

void CGhostBoardSettings::OnBnClickedCheckAlt()
{
    // 全てのチェックが外れたらどれかをチェックする
    if((m_checkCtrl.GetCheck()|m_checkShift.GetCheck()|m_checkAlt.GetCheck())==false)
        m_checkCtrl.SetCheck(BST_CHECKED);
}

void CGhostBoardSettings::OnBnClickedOk()
{
    // OK時に 状態を反映
    m_alphaDefault = m_sliderAlphaDefault.GetPos();
    m_alphaMouse = m_sliderAlphaMouse.GetPos();
    m_ctrl = (m_checkCtrl.GetCheck() == BST_CHECKED);
    m_shift = (m_checkShift.GetCheck() == BST_CHECKED);
    m_alt = (m_checkAlt.GetCheck() == BST_CHECKED);

    OnOK();
}
