#pragma once
#include "afxcmn.h"
#include "afxwin.h"


// CGhostBoardSettings ダイアログ

class CGhostBoardSettings : public CDialog
{
	DECLARE_DYNAMIC(CGhostBoardSettings)

public:
	CGhostBoardSettings(CWnd* pParent = NULL);   // 標準コンストラクタ
	virtual ~CGhostBoardSettings();

// ダイアログ データ
	enum { IDD = IDD_DIALOG_SETTINGS };

	virtual BOOL OnInitDialog();

    UINT m_alphaActive;
    UINT m_alphaDefault;
    UINT m_alphaMouse;
    int  m_ctrl;
    int  m_shift;
    int  m_alt;
    int  m_win;
    int *m_iconNotifP;

    int  m_hotKeyUpCode;
    int  m_hotKeyDownCode;
    int  m_hotKeyLeftCode;
    int  m_hotKeyRightCode;
    int  m_hotKeyMenuCode;
    int  m_hotKeyFocusCode;

    UINT m_alphaList;
	int  m_listHeight;

    int  m_textNum[4];

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV サポート

	DECLARE_MESSAGE_MAP()
public:
    CSliderCtrl m_sliderAlphaActive;
    CSliderCtrl m_sliderAlphaDefault;
    CSliderCtrl m_sliderAlphaMouse;
    afx_msg void OnBnClickedOk();
    CButton m_checkCtrl;
    CButton m_checkShift;
    CButton m_checkAlt;
    CButton m_checkWin;
    afx_msg void OnBnClickedCheckCtrl();
    afx_msg void OnBnClickedCheckShift();
    afx_msg void OnBnClickedCheckAlt();
    afx_msg void OnBnClickedCheckWin();
    CButton m_checkIconNotif;
    CHotKeyCtrl m_hotKeyUp;
    CHotKeyCtrl m_hotKeyDown;
    CHotKeyCtrl m_hotKeyLeft;
    CHotKeyCtrl m_hotKeyRight;
    CHotKeyCtrl m_hotKeyMenu;
    CHotKeyCtrl m_hotKeyFocus;
	CSliderCtrl m_sliderAlphaList;
	CEdit m_editListHeight;
    CEdit m_editWhite;
    CEdit m_editRed;
    CEdit m_editGreen;
    CEdit m_editBlue;
};
