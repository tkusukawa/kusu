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
    bool m_ctrl;
    bool m_shift;
    bool m_alt;
    bool m_win;
    bool *m_iconNotifP;

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
};
