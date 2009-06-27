
// MyEdit.cpp : 実装ファイル
//

#include "stdafx.h"
#include "GhostBoard.h"
#include "MyEdit.h"


// CMyEdit

IMPLEMENT_DYNAMIC(CMyEdit, CEdit)

CMyEdit::CMyEdit()
{

}

CMyEdit::~CMyEdit()
{
}


BEGIN_MESSAGE_MAP(CMyEdit, CEdit)
    ON_MESSAGE(WM_RBUTTONDOWN, OnRButtonDown)
END_MESSAGE_MAP()



// CMyEdit メッセージ ハンドラ

LRESULT	CMyEdit::OnRButtonDown(WPARAM wParam, LPARAM lParam)
{
    return ::PostMessage(*GetParent(),WM_RBUTTONDOWN, wParam, lParam);
}
