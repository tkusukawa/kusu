// GhostBoardList.cpp : 実装ファイル
//

#include "stdafx.h"
#include "GhostBoard.h"
#include "GhostBoardList.h"


// CGhostBoardList ダイアログ

IMPLEMENT_DYNAMIC(CGhostBoardList, CDialog)

CGhostBoardList::CGhostBoardList(CWnd* pParent /*=NULL*/)
	: CDialog(CGhostBoardList::IDD, pParent)
{

}

CGhostBoardList::~CGhostBoardList()
{
}

void CGhostBoardList::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_LIST, m_listBox);
}


BEGIN_MESSAGE_MAP(CGhostBoardList, CDialog)
	ON_WM_SIZE()
END_MESSAGE_MAP()


// CGhostBoardList メッセージ ハンドラ
BOOL CGhostBoardList::OnInitDialog()
{
	BOOL ret = CDialog::OnInitDialog();

	m_listBox.InsertString(-1,_T("hoge"));
	m_listBox.InsertString(-1,_T("foo"));

	return ret;
}
void CGhostBoardList::OnSize(UINT nType, int cx, int cy)
{
	CDialog::OnSize(nType, cx, cy);

    //m_listBox.MoveWindow(4,3,cx-7,cy-6);
}
