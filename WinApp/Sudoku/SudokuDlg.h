// SudokuDlg.h : ヘッダー ファイル
//

#pragma once
#include "afxwin.h"

void dbg( LPCSTR pszFormat, ...);

// CSudokuDlg ダイアログ
class CSudokuDlg : public CDialog
{
// コンストラクション
public:
	CSudokuDlg(CWnd* pParent = NULL);	// 標準コンストラクタ

// ダイアログ データ
	enum { IDD = IDD_SUDOKU_DIALOG };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV サポート


    void m_init();
    void m_changeEdit(int line, int row);
    void m_changeEdit2(int line, int row);
    void m_focusEdit(int line, int row);

    void m_backupWld();
    void m_restoreWld();

    Cel m_cel[9][9];
    Grp m_lineGrp[9], m_rowGrp[9], m_blockGrp[9];

    Cel m_celBack[9][9];
    Grp m_lineGrpBack[9], m_rowGrpBack[9], m_blockGrpBack[9];

    int focusLine, focusRow;
// 実装
protected:
	HICON m_hIcon;

    CBrush m_brushRed, m_brushBlue;
    COLORREF m_clrRed, m_clrBlue;

	// 生成された、メッセージ割り当て関数
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
    BOOL PreTranslateMessage(MSG* pMsg);

public:

    CEdit cel11;
    CEdit cel12;
    CEdit cel13;
    CEdit cel21;
    CEdit cel22;
    CEdit cel23;
    CEdit cel31;
    CEdit cel32;
    CEdit cel33;
    CEdit cel14;
    CEdit cel15;
    CEdit cel16;
    CEdit cel24;
    CEdit cel25;
    CEdit cel26;
    CEdit cel34;
    CEdit cel35;
    CEdit cel36;
    CEdit cel17;
    CEdit cel18;
    CEdit cel19;
    CEdit cel27;
    CEdit cel28;
    CEdit cel29;
    CEdit cel37;
    CEdit cel38;
    CEdit cel39;
    CEdit cel41;
    CEdit cel42;
    CEdit cel43;
    CEdit cel51;
    CEdit cel52;
    CEdit cel53;
    CEdit cel61;
    CEdit cel62;
    CEdit cel63;
    CEdit cel44;
    CEdit cel45;
    CEdit cel46;
    CEdit cel54;
    CEdit cel55;
    CEdit cel56;
    CEdit cel64;
    CEdit cel65;
    CEdit cel66;
    CEdit cel47;
    CEdit cel48;
    CEdit cel49;
    CEdit cel57;
    CEdit cel58;
    CEdit cel59;
    CEdit cel67;
    CEdit cel68;
    CEdit cel69;
    CEdit cel71;
    CEdit cel72;
    CEdit cel73;
    CEdit cel81;
    CEdit cel82;
    CEdit cel83;
    CEdit cel91;
    CEdit cel92;
    CEdit cel93;
    CEdit cel74;
    CEdit cel75;
    CEdit cel76;
    CEdit cel84;
    CEdit cel85;
    CEdit cel86;
    CEdit cel94;
    CEdit cel95;
    CEdit cel96;
    CEdit cel77;
    CEdit cel78;
    CEdit cel79;
    CEdit cel87;
    CEdit cel88;
    CEdit cel89;
    CEdit cel97;
    CEdit cel98;
    CEdit cel99;
    afx_msg void OnEnChangeEdit11();
    afx_msg void OnEnChangeEdit12();
    afx_msg void OnEnChangeEdit13();
    afx_msg void OnEnChangeEdit14();
    afx_msg void OnEnChangeEdit15();
    afx_msg void OnEnChangeEdit16();
    afx_msg void OnEnChangeEdit17();
    afx_msg void OnEnChangeEdit18();
    afx_msg void OnEnChangeEdit19();
    afx_msg void OnEnChangeEdit21();
    afx_msg void OnEnChangeEdit22();
    afx_msg void OnEnChangeEdit23();
    afx_msg void OnEnChangeEdit24();
    afx_msg void OnEnChangeEdit25();
    afx_msg void OnEnChangeEdit26();
    afx_msg void OnEnChangeEdit27();
    afx_msg void OnEnChangeEdit28();
    afx_msg void OnEnChangeEdit29();
    afx_msg void OnEnChangeEdit31();
    afx_msg void OnEnChangeEdit32();
    afx_msg void OnEnChangeEdit33();
    afx_msg void OnEnChangeEdit34();
    afx_msg void OnEnChangeEdit35();
    afx_msg void OnEnChangeEdit36();
    afx_msg void OnEnChangeEdit37();
    afx_msg void OnEnChangeEdit38();
    afx_msg void OnEnChangeEdit39();
    afx_msg void OnEnChangeEdit41();
    afx_msg void OnEnChangeEdit42();
    afx_msg void OnEnChangeEdit43();
    afx_msg void OnEnChangeEdit44();
    afx_msg void OnEnChangeEdit45();
    afx_msg void OnEnChangeEdit46();
    afx_msg void OnEnChangeEdit47();
    afx_msg void OnEnChangeEdit48();
    afx_msg void OnEnChangeEdit49();
    afx_msg void OnEnChangeEdit51();
    afx_msg void OnEnChangeEdit52();
    afx_msg void OnEnChangeEdit53();
    afx_msg void OnEnChangeEdit54();
    afx_msg void OnEnChangeEdit55();
    afx_msg void OnEnChangeEdit56();
    afx_msg void OnEnChangeEdit57();
    afx_msg void OnEnChangeEdit58();
    afx_msg void OnEnChangeEdit59();
    afx_msg void OnEnChangeEdit61();
    afx_msg void OnEnChangeEdit62();
    afx_msg void OnEnChangeEdit63();
    afx_msg void OnEnChangeEdit64();
    afx_msg void OnEnChangeEdit65();
    afx_msg void OnEnChangeEdit66();
    afx_msg void OnEnChangeEdit67();
    afx_msg void OnEnChangeEdit68();
    afx_msg void OnEnChangeEdit69();
    afx_msg void OnEnChangeEdit71();
    afx_msg void OnEnChangeEdit72();
    afx_msg void OnEnChangeEdit73();
    afx_msg void OnEnChangeEdit74();
    afx_msg void OnEnChangeEdit75();
    afx_msg void OnEnChangeEdit76();
    afx_msg void OnEnChangeEdit77();
    afx_msg void OnEnChangeEdit78();
    afx_msg void OnEnChangeEdit79();
    afx_msg void OnEnChangeEdit81();
    afx_msg void OnEnChangeEdit82();
    afx_msg void OnEnChangeEdit83();
    afx_msg void OnEnChangeEdit84();
    afx_msg void OnEnChangeEdit85();
    afx_msg void OnEnChangeEdit86();
    afx_msg void OnEnChangeEdit87();
    afx_msg void OnEnChangeEdit88();
    afx_msg void OnEnChangeEdit89();
    afx_msg void OnEnChangeEdit91();
    afx_msg void OnEnChangeEdit92();
    afx_msg void OnEnChangeEdit93();
    afx_msg void OnEnChangeEdit94();
    afx_msg void OnEnChangeEdit95();
    afx_msg void OnEnChangeEdit96();
    afx_msg void OnEnChangeEdit97();
    afx_msg void OnEnChangeEdit98();
    afx_msg void OnEnChangeEdit99();
    afx_msg HBRUSH OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor);

    afx_msg void OnEnSetfocusEdit11();
    afx_msg void OnEnSetfocusEdit12();
    afx_msg void OnEnSetfocusEdit13();
    afx_msg void OnEnSetfocusEdit14();
    afx_msg void OnEnSetfocusEdit15();
    afx_msg void OnEnSetfocusEdit16();
    afx_msg void OnEnSetfocusEdit17();
    afx_msg void OnEnSetfocusEdit18();
    afx_msg void OnEnSetfocusEdit19();

    afx_msg void OnEnSetfocusEdit21();
    afx_msg void OnEnSetfocusEdit22();
    afx_msg void OnEnSetfocusEdit23();
    afx_msg void OnEnSetfocusEdit24();
    afx_msg void OnEnSetfocusEdit25();
    afx_msg void OnEnSetfocusEdit26();
    afx_msg void OnEnSetfocusEdit27();
    afx_msg void OnEnSetfocusEdit28();
    afx_msg void OnEnSetfocusEdit29();

    afx_msg void OnEnSetfocusEdit31();
    afx_msg void OnEnSetfocusEdit32();
    afx_msg void OnEnSetfocusEdit33();
    afx_msg void OnEnSetfocusEdit34();
    afx_msg void OnEnSetfocusEdit35();
    afx_msg void OnEnSetfocusEdit36();
    afx_msg void OnEnSetfocusEdit37();
    afx_msg void OnEnSetfocusEdit38();
    afx_msg void OnEnSetfocusEdit39();

    afx_msg void OnEnSetfocusEdit41();
    afx_msg void OnEnSetfocusEdit42();
    afx_msg void OnEnSetfocusEdit43();
    afx_msg void OnEnSetfocusEdit44();
    afx_msg void OnEnSetfocusEdit45();
    afx_msg void OnEnSetfocusEdit46();
    afx_msg void OnEnSetfocusEdit47();
    afx_msg void OnEnSetfocusEdit48();
    afx_msg void OnEnSetfocusEdit49();

    afx_msg void OnEnSetfocusEdit51();
    afx_msg void OnEnSetfocusEdit52();
    afx_msg void OnEnSetfocusEdit53();
    afx_msg void OnEnSetfocusEdit54();
    afx_msg void OnEnSetfocusEdit55();
    afx_msg void OnEnSetfocusEdit56();
    afx_msg void OnEnSetfocusEdit57();
    afx_msg void OnEnSetfocusEdit58();
    afx_msg void OnEnSetfocusEdit59();

    afx_msg void OnEnSetfocusEdit61();
    afx_msg void OnEnSetfocusEdit62();
    afx_msg void OnEnSetfocusEdit63();
    afx_msg void OnEnSetfocusEdit64();
    afx_msg void OnEnSetfocusEdit65();
    afx_msg void OnEnSetfocusEdit66();
    afx_msg void OnEnSetfocusEdit67();
    afx_msg void OnEnSetfocusEdit68();
    afx_msg void OnEnSetfocusEdit69();

    afx_msg void OnEnSetfocusEdit71();
    afx_msg void OnEnSetfocusEdit72();
    afx_msg void OnEnSetfocusEdit73();
    afx_msg void OnEnSetfocusEdit74();
    afx_msg void OnEnSetfocusEdit75();
    afx_msg void OnEnSetfocusEdit76();
    afx_msg void OnEnSetfocusEdit77();
    afx_msg void OnEnSetfocusEdit78();
    afx_msg void OnEnSetfocusEdit79();

    afx_msg void OnEnSetfocusEdit81();
    afx_msg void OnEnSetfocusEdit82();
    afx_msg void OnEnSetfocusEdit83();
    afx_msg void OnEnSetfocusEdit84();
    afx_msg void OnEnSetfocusEdit85();
    afx_msg void OnEnSetfocusEdit86();
    afx_msg void OnEnSetfocusEdit87();
    afx_msg void OnEnSetfocusEdit88();
    afx_msg void OnEnSetfocusEdit89();

    afx_msg void OnEnSetfocusEdit91();
    afx_msg void OnEnSetfocusEdit92();
    afx_msg void OnEnSetfocusEdit93();
    afx_msg void OnEnSetfocusEdit94();
    afx_msg void OnEnSetfocusEdit95();
    afx_msg void OnEnSetfocusEdit96();
    afx_msg void OnEnSetfocusEdit97();
    afx_msg void OnEnSetfocusEdit98();
    afx_msg void OnEnSetfocusEdit99();
};


