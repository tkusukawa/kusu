#pragma once
#include "afxwin.h"


// CGhostBoardList ダイアログ

class CGhostBoardList : public CDialog
{
	DECLARE_DYNAMIC(CGhostBoardList)

public:
	CGhostBoardList(CWnd* pParent = NULL);   // 標準コンストラクタ
	virtual ~CGhostBoardList();

// ダイアログ データ
	enum { IDD = IDD_GHOSTBOARD_LIST };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV サポート

	virtual BOOL OnInitDialog();
	DECLARE_MESSAGE_MAP()
public:
	CListBox m_listBox;
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg HBRUSH OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor);
	CBrush *m_brush;
};
