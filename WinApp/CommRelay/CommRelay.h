// CommRelay.h : COMMRELAY �A�v���P�[�V�����̃��C�� �w�b�_�[ �t�@�C���ł��B
//

#if !defined(AFX_COMMRELAY_H__A7D4D51D_0ABC_4996_A68F_A1F3D66FF52F__INCLUDED_)
#define AFX_COMMRELAY_H__A7D4D51D_0ABC_4996_A68F_A1F3D66FF52F__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// ���C�� �V���{��

/////////////////////////////////////////////////////////////////////////////
// CCommRelayApp:
// ���̃N���X�̓���̒�`�Ɋւ��Ă� CommRelay.cpp �t�@�C�����Q�Ƃ��Ă��������B
//

class CCommRelayApp : public CWinApp
{
public:
	CCommRelayApp();

// �I�[�o�[���C�h
	// ClassWizard �͉��z�֐��̃I�[�o�[���C�h�𐶐����܂��B
	//{{AFX_VIRTUAL(CCommRelayApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// �C���v�������e�[�V����

	//{{AFX_MSG(CCommRelayApp)
		// ���� - ClassWizard �͂��̈ʒu�Ƀ����o�֐���ǉ��܂��͍폜���܂��B
		//        ���̈ʒu�ɐ��������R�[�h��ҏW���Ȃ��ł��������B
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ �͑O�s�̒��O�ɒǉ��̐錾��}�����܂��B

#endif // !defined(AFX_COMMRELAY_H__A7D4D51D_0ABC_4996_A68F_A1F3D66FF52F__INCLUDED_)
