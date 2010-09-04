#pragma once
#include "afxwin.h"


// CGhostBoardList �_�C�A���O

class CGhostBoardList : public CDialog
{
	DECLARE_DYNAMIC(CGhostBoardList)

public:
	CGhostBoardList(CWnd* pParent = NULL);   // �W���R���X�g���N�^
	virtual ~CGhostBoardList();

// �_�C�A���O �f�[�^
	enum { IDD = IDD_GHOSTBOARD_LIST };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV �T�|�[�g

	virtual BOOL OnInitDialog();
	DECLARE_MESSAGE_MAP()
public:
	CListBox m_listBox;
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg HBRUSH OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor);
	CBrush *m_brush;
};
