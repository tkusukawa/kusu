
// MyEdit.cpp : �����t�@�C��
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



// CMyEdit ���b�Z�[�W �n���h��

LRESULT	CMyEdit::OnRButtonDown(WPARAM wParam, LPARAM lParam)
{
    return ::PostMessage(*GetParent(),WM_RBUTTONDOWN, wParam, lParam);
}
