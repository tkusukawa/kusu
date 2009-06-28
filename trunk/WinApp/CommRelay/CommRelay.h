// CommRelay.h : COMMRELAY アプリケーションのメイン ヘッダー ファイルです。
//

#if !defined(AFX_COMMRELAY_H__A7D4D51D_0ABC_4996_A68F_A1F3D66FF52F__INCLUDED_)
#define AFX_COMMRELAY_H__A7D4D51D_0ABC_4996_A68F_A1F3D66FF52F__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// メイン シンボル

/////////////////////////////////////////////////////////////////////////////
// CCommRelayApp:
// このクラスの動作の定義に関しては CommRelay.cpp ファイルを参照してください。
//

class CCommRelayApp : public CWinApp
{
public:
	CCommRelayApp();

// オーバーライド
	// ClassWizard は仮想関数のオーバーライドを生成します。
	//{{AFX_VIRTUAL(CCommRelayApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// インプリメンテーション

	//{{AFX_MSG(CCommRelayApp)
		// メモ - ClassWizard はこの位置にメンバ関数を追加または削除します。
		//        この位置に生成されるコードを編集しないでください。
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ は前行の直前に追加の宣言を挿入します。

#endif // !defined(AFX_COMMRELAY_H__A7D4D51D_0ABC_4996_A68F_A1F3D66FF52F__INCLUDED_)
