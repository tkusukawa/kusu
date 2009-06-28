// Sudoku.h : PROJECT_NAME アプリケーションのメイン ヘッダー ファイルです。
//

#pragma once

#ifndef __AFXWIN_H__
	#error このファイルを PCH に含める前に、'stdafx.h' を含めてください。
#endif

#include "resource.h"		// メイン シンボル


// CSudokuApp:
// このクラスの実装については、Sudoku.cpp を参照してください。
//

class CSudokuApp : public CWinApp
{
public:
	CSudokuApp();

// オーバーライド
	public:
	virtual BOOL InitInstance();

// 実装

	DECLARE_MESSAGE_MAP()
};

extern CSudokuApp theApp;
