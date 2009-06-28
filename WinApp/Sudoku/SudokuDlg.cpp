// SudokuDlg.cpp : 実装ファイル
//

#include "stdafx.h"
#include "Cel.h"
#include "Sudoku.h"
#include "SudokuDlg.h"
#include ".\sudokudlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

void dbg( LPCSTR pszFormat, ...)
{
    va_list	argp;
    char pszBuf[ 256];
    va_start(argp, pszFormat);
    vsprintf( pszBuf, pszFormat, argp);
    va_end(argp);
    OutputDebugString( pszBuf);
}

// アプリケーションのバージョン情報に使われる CAboutDlg ダイアログ

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// ダイアログ データ
	enum { IDD = IDD_ABOUTBOX };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV サポート

// 実装
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
END_MESSAGE_MAP()


// CSudokuDlg ダイアログ



CSudokuDlg::CSudokuDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CSudokuDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);

    m_clrRed = RGB(255,100,100);
    m_clrBlue = RGB(100,100,255);
    m_brushRed.CreateSolidBrush(m_clrRed);
    m_brushBlue.CreateSolidBrush(m_clrBlue);


}

void CSudokuDlg::DoDataExchange(CDataExchange* pDX)
{
    CDialog::DoDataExchange(pDX);
    DDX_Control(pDX, IDC_EDIT1_1, cel11);
    DDX_Control(pDX, IDC_EDIT1_2, cel12);
    DDX_Control(pDX, IDC_EDIT1_3, cel13);
    DDX_Control(pDX, IDC_EDIT1_4, cel14);
    DDX_Control(pDX, IDC_EDIT2_1, cel21);
    DDX_Control(pDX, IDC_EDIT2_2, cel22);
    DDX_Control(pDX, IDC_EDIT2_3, cel23);
    DDX_Control(pDX, IDC_EDIT3_1, cel31);
    DDX_Control(pDX, IDC_EDIT3_2, cel32);
    DDX_Control(pDX, IDC_EDIT3_3, cel33);
    DDX_Control(pDX, IDC_EDIT1_5, cel15);
    DDX_Control(pDX, IDC_EDIT1_6, cel16);
    DDX_Control(pDX, IDC_EDIT2_4, cel24);
    DDX_Control(pDX, IDC_EDIT2_5, cel25);
    DDX_Control(pDX, IDC_EDIT2_6, cel26);
    DDX_Control(pDX, IDC_EDIT3_4, cel34);
    DDX_Control(pDX, IDC_EDIT3_5, cel35);
    DDX_Control(pDX, IDC_EDIT3_6, cel36);
    DDX_Control(pDX, IDC_EDIT1_7, cel17);
    DDX_Control(pDX, IDC_EDIT1_8, cel18);
    DDX_Control(pDX, IDC_EDIT1_9, cel19);
    DDX_Control(pDX, IDC_EDIT2_7, cel27);
    DDX_Control(pDX, IDC_EDIT2_8, cel28);
    DDX_Control(pDX, IDC_EDIT2_9, cel29);
    DDX_Control(pDX, IDC_EDIT3_7, cel37);
    DDX_Control(pDX, IDC_EDIT3_8, cel38);
    DDX_Control(pDX, IDC_EDIT3_9, cel39);
    DDX_Control(pDX, IDC_EDIT4_1, cel41);
    DDX_Control(pDX, IDC_EDIT4_2, cel42);
    DDX_Control(pDX, IDC_EDIT4_3, cel43);
    DDX_Control(pDX, IDC_EDIT5_1, cel51);
    DDX_Control(pDX, IDC_EDIT5_2, cel52);
    DDX_Control(pDX, IDC_EDIT5_3, cel53);
    DDX_Control(pDX, IDC_EDIT6_1, cel61);
    DDX_Control(pDX, IDC_EDIT6_2, cel62);
    DDX_Control(pDX, IDC_EDIT6_3, cel63);
    DDX_Control(pDX, IDC_EDIT4_4, cel44);
    DDX_Control(pDX, IDC_EDIT4_5, cel45);
    DDX_Control(pDX, IDC_EDIT4_6, cel46);
    DDX_Control(pDX, IDC_EDIT5_4, cel54);
    DDX_Control(pDX, IDC_EDIT5_5, cel55);
    DDX_Control(pDX, IDC_EDIT5_6, cel56);
    DDX_Control(pDX, IDC_EDIT6_4, cel64);
    DDX_Control(pDX, IDC_EDIT6_5, cel65);
    DDX_Control(pDX, IDC_EDIT6_6, cel66);
    DDX_Control(pDX, IDC_EDIT4_7, cel47);
    DDX_Control(pDX, IDC_EDIT4_8, cel48);
    DDX_Control(pDX, IDC_EDIT4_9, cel49);
    DDX_Control(pDX, IDC_EDIT5_7, cel57);
    DDX_Control(pDX, IDC_EDIT5_8, cel58);
    DDX_Control(pDX, IDC_EDIT5_9, cel59);
    DDX_Control(pDX, IDC_EDIT6_7, cel67);
    DDX_Control(pDX, IDC_EDIT6_8, cel68);
    DDX_Control(pDX, IDC_EDIT6_9, cel69);
    DDX_Control(pDX, IDC_EDIT7_1, cel71);
    DDX_Control(pDX, IDC_EDIT7_2, cel72);
    DDX_Control(pDX, IDC_EDIT7_3, cel73);
    DDX_Control(pDX, IDC_EDIT8_1, cel81);
    DDX_Control(pDX, IDC_EDIT8_2, cel82);
    DDX_Control(pDX, IDC_EDIT8_3, cel83);
    DDX_Control(pDX, IDC_EDIT9_1, cel91);
    DDX_Control(pDX, IDC_EDIT9_2, cel92);
    DDX_Control(pDX, IDC_EDIT9_3, cel93);
    DDX_Control(pDX, IDC_EDIT7_4, cel74);
    DDX_Control(pDX, IDC_EDIT7_5, cel75);
    DDX_Control(pDX, IDC_EDIT7_6, cel76);
    DDX_Control(pDX, IDC_EDIT8_4, cel84);
    DDX_Control(pDX, IDC_EDIT8_5, cel85);
    DDX_Control(pDX, IDC_EDIT8_6, cel86);
    DDX_Control(pDX, IDC_EDIT9_4, cel94);
    DDX_Control(pDX, IDC_EDIT9_5, cel95);
    DDX_Control(pDX, IDC_EDIT9_6, cel96);
    DDX_Control(pDX, IDC_EDIT7_7, cel77);
    DDX_Control(pDX, IDC_EDIT7_8, cel78);
    DDX_Control(pDX, IDC_EDIT7_9, cel79);
    DDX_Control(pDX, IDC_EDIT8_7, cel87);
    DDX_Control(pDX, IDC_EDIT8_8, cel88);
    DDX_Control(pDX, IDC_EDIT8_9, cel89);
    DDX_Control(pDX, IDC_EDIT9_7, cel97);
    DDX_Control(pDX, IDC_EDIT9_8, cel98);
    DDX_Control(pDX, IDC_EDIT9_9, cel99);
}

BEGIN_MESSAGE_MAP(CSudokuDlg, CDialog)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	//}}AFX_MSG_MAP
    ON_EN_CHANGE(IDC_EDIT1_1, OnEnChangeEdit11)
    ON_EN_CHANGE(IDC_EDIT1_2, OnEnChangeEdit12)
    ON_EN_CHANGE(IDC_EDIT1_3, OnEnChangeEdit13)
    ON_EN_CHANGE(IDC_EDIT1_4, OnEnChangeEdit14)
    ON_EN_CHANGE(IDC_EDIT1_5, OnEnChangeEdit15)
    ON_EN_CHANGE(IDC_EDIT1_6, OnEnChangeEdit16)
    ON_EN_CHANGE(IDC_EDIT1_7, OnEnChangeEdit17)
    ON_EN_CHANGE(IDC_EDIT1_8, OnEnChangeEdit18)
    ON_EN_CHANGE(IDC_EDIT1_9, OnEnChangeEdit19)
    ON_EN_CHANGE(IDC_EDIT2_1, OnEnChangeEdit21)
    ON_EN_CHANGE(IDC_EDIT2_2, OnEnChangeEdit22)
    ON_EN_CHANGE(IDC_EDIT2_3, OnEnChangeEdit23)
    ON_EN_CHANGE(IDC_EDIT2_4, OnEnChangeEdit24)
    ON_EN_CHANGE(IDC_EDIT2_5, OnEnChangeEdit25)
    ON_EN_CHANGE(IDC_EDIT2_6, OnEnChangeEdit26)
    ON_EN_CHANGE(IDC_EDIT2_7, OnEnChangeEdit27)
    ON_EN_CHANGE(IDC_EDIT2_8, OnEnChangeEdit28)
    ON_EN_CHANGE(IDC_EDIT2_9, OnEnChangeEdit29)
    ON_EN_CHANGE(IDC_EDIT3_1, OnEnChangeEdit31)
    ON_EN_CHANGE(IDC_EDIT3_2, OnEnChangeEdit32)
    ON_EN_CHANGE(IDC_EDIT3_3, OnEnChangeEdit33)
    ON_EN_CHANGE(IDC_EDIT3_4, OnEnChangeEdit34)
    ON_EN_CHANGE(IDC_EDIT3_5, OnEnChangeEdit35)
    ON_EN_CHANGE(IDC_EDIT3_6, OnEnChangeEdit36)
    ON_EN_CHANGE(IDC_EDIT3_7, OnEnChangeEdit37)
    ON_EN_CHANGE(IDC_EDIT3_8, OnEnChangeEdit38)
    ON_EN_CHANGE(IDC_EDIT3_9, OnEnChangeEdit39)
    ON_EN_CHANGE(IDC_EDIT4_1, OnEnChangeEdit41)
    ON_EN_CHANGE(IDC_EDIT4_2, OnEnChangeEdit42)
    ON_EN_CHANGE(IDC_EDIT4_3, OnEnChangeEdit43)
    ON_EN_CHANGE(IDC_EDIT4_4, OnEnChangeEdit44)
    ON_EN_CHANGE(IDC_EDIT4_5, OnEnChangeEdit45)
    ON_EN_CHANGE(IDC_EDIT4_6, OnEnChangeEdit46)
    ON_EN_CHANGE(IDC_EDIT4_7, OnEnChangeEdit47)
    ON_EN_CHANGE(IDC_EDIT4_8, OnEnChangeEdit48)
    ON_EN_CHANGE(IDC_EDIT4_9, OnEnChangeEdit49)
    ON_EN_CHANGE(IDC_EDIT5_1, OnEnChangeEdit51)
    ON_EN_CHANGE(IDC_EDIT5_2, OnEnChangeEdit52)
    ON_EN_CHANGE(IDC_EDIT5_3, OnEnChangeEdit53)
    ON_EN_CHANGE(IDC_EDIT5_4, OnEnChangeEdit54)
    ON_EN_CHANGE(IDC_EDIT5_5, OnEnChangeEdit55)
    ON_EN_CHANGE(IDC_EDIT5_6, OnEnChangeEdit56)
    ON_EN_CHANGE(IDC_EDIT5_7, OnEnChangeEdit57)
    ON_EN_CHANGE(IDC_EDIT5_8, OnEnChangeEdit58)
    ON_EN_CHANGE(IDC_EDIT5_9, OnEnChangeEdit59)
    ON_EN_CHANGE(IDC_EDIT6_1, OnEnChangeEdit61)
    ON_EN_CHANGE(IDC_EDIT6_2, OnEnChangeEdit62)
    ON_EN_CHANGE(IDC_EDIT6_3, OnEnChangeEdit63)
    ON_EN_CHANGE(IDC_EDIT6_4, OnEnChangeEdit64)
    ON_EN_CHANGE(IDC_EDIT6_5, OnEnChangeEdit65)
    ON_EN_CHANGE(IDC_EDIT6_6, OnEnChangeEdit66)
    ON_EN_CHANGE(IDC_EDIT6_7, OnEnChangeEdit67)
    ON_EN_CHANGE(IDC_EDIT6_8, OnEnChangeEdit68)
    ON_EN_CHANGE(IDC_EDIT6_9, OnEnChangeEdit69)
    ON_EN_CHANGE(IDC_EDIT7_1, OnEnChangeEdit71)
    ON_EN_CHANGE(IDC_EDIT7_2, OnEnChangeEdit72)
    ON_EN_CHANGE(IDC_EDIT7_3, OnEnChangeEdit73)
    ON_EN_CHANGE(IDC_EDIT7_4, OnEnChangeEdit74)
    ON_EN_CHANGE(IDC_EDIT7_5, OnEnChangeEdit75)
    ON_EN_CHANGE(IDC_EDIT7_6, OnEnChangeEdit76)
    ON_EN_CHANGE(IDC_EDIT7_7, OnEnChangeEdit77)
    ON_EN_CHANGE(IDC_EDIT7_8, OnEnChangeEdit78)
    ON_EN_CHANGE(IDC_EDIT7_9, OnEnChangeEdit79)
    ON_EN_CHANGE(IDC_EDIT8_1, OnEnChangeEdit81)
    ON_EN_CHANGE(IDC_EDIT8_2, OnEnChangeEdit82)
    ON_EN_CHANGE(IDC_EDIT8_3, OnEnChangeEdit83)
    ON_EN_CHANGE(IDC_EDIT8_4, OnEnChangeEdit84)
    ON_EN_CHANGE(IDC_EDIT8_5, OnEnChangeEdit85)
    ON_EN_CHANGE(IDC_EDIT8_6, OnEnChangeEdit86)
    ON_EN_CHANGE(IDC_EDIT8_7, OnEnChangeEdit87)
    ON_EN_CHANGE(IDC_EDIT8_8, OnEnChangeEdit88)
    ON_EN_CHANGE(IDC_EDIT8_9, OnEnChangeEdit89)
    ON_EN_CHANGE(IDC_EDIT9_1, OnEnChangeEdit91)
    ON_EN_CHANGE(IDC_EDIT9_2, OnEnChangeEdit92)
    ON_EN_CHANGE(IDC_EDIT9_3, OnEnChangeEdit93)
    ON_EN_CHANGE(IDC_EDIT9_4, OnEnChangeEdit94)
    ON_EN_CHANGE(IDC_EDIT9_5, OnEnChangeEdit95)
    ON_EN_CHANGE(IDC_EDIT9_6, OnEnChangeEdit96)
    ON_EN_CHANGE(IDC_EDIT9_7, OnEnChangeEdit97)
    ON_EN_CHANGE(IDC_EDIT9_8, OnEnChangeEdit98)
    ON_EN_CHANGE(IDC_EDIT9_9, OnEnChangeEdit99)
    ON_WM_CTLCOLOR()

    ON_EN_SETFOCUS(IDC_EDIT1_1, OnEnSetfocusEdit11)
    ON_EN_SETFOCUS(IDC_EDIT1_2, OnEnSetfocusEdit12)
    ON_EN_SETFOCUS(IDC_EDIT1_3, OnEnSetfocusEdit13)
    ON_EN_SETFOCUS(IDC_EDIT1_4, OnEnSetfocusEdit14)
    ON_EN_SETFOCUS(IDC_EDIT1_5, OnEnSetfocusEdit15)
    ON_EN_SETFOCUS(IDC_EDIT1_6, OnEnSetfocusEdit16)
    ON_EN_SETFOCUS(IDC_EDIT1_7, OnEnSetfocusEdit17)
    ON_EN_SETFOCUS(IDC_EDIT1_8, OnEnSetfocusEdit18)
    ON_EN_SETFOCUS(IDC_EDIT1_9, OnEnSetfocusEdit19)

    ON_EN_SETFOCUS(IDC_EDIT2_1, OnEnSetfocusEdit21)
    ON_EN_SETFOCUS(IDC_EDIT2_2, OnEnSetfocusEdit22)
    ON_EN_SETFOCUS(IDC_EDIT2_3, OnEnSetfocusEdit23)
    ON_EN_SETFOCUS(IDC_EDIT2_4, OnEnSetfocusEdit24)
    ON_EN_SETFOCUS(IDC_EDIT2_5, OnEnSetfocusEdit25)
    ON_EN_SETFOCUS(IDC_EDIT2_6, OnEnSetfocusEdit26)
    ON_EN_SETFOCUS(IDC_EDIT2_7, OnEnSetfocusEdit27)
    ON_EN_SETFOCUS(IDC_EDIT2_8, OnEnSetfocusEdit28)
    ON_EN_SETFOCUS(IDC_EDIT2_9, OnEnSetfocusEdit29)

    ON_EN_SETFOCUS(IDC_EDIT3_1, OnEnSetfocusEdit31)
    ON_EN_SETFOCUS(IDC_EDIT3_2, OnEnSetfocusEdit32)
    ON_EN_SETFOCUS(IDC_EDIT3_3, OnEnSetfocusEdit33)
    ON_EN_SETFOCUS(IDC_EDIT3_4, OnEnSetfocusEdit34)
    ON_EN_SETFOCUS(IDC_EDIT3_5, OnEnSetfocusEdit35)
    ON_EN_SETFOCUS(IDC_EDIT3_6, OnEnSetfocusEdit36)
    ON_EN_SETFOCUS(IDC_EDIT3_7, OnEnSetfocusEdit37)
    ON_EN_SETFOCUS(IDC_EDIT3_8, OnEnSetfocusEdit38)
    ON_EN_SETFOCUS(IDC_EDIT3_9, OnEnSetfocusEdit39)

    ON_EN_SETFOCUS(IDC_EDIT4_1, OnEnSetfocusEdit41)
    ON_EN_SETFOCUS(IDC_EDIT4_2, OnEnSetfocusEdit42)
    ON_EN_SETFOCUS(IDC_EDIT4_3, OnEnSetfocusEdit43)
    ON_EN_SETFOCUS(IDC_EDIT4_4, OnEnSetfocusEdit44)
    ON_EN_SETFOCUS(IDC_EDIT4_5, OnEnSetfocusEdit45)
    ON_EN_SETFOCUS(IDC_EDIT4_6, OnEnSetfocusEdit46)
    ON_EN_SETFOCUS(IDC_EDIT4_7, OnEnSetfocusEdit47)
    ON_EN_SETFOCUS(IDC_EDIT4_8, OnEnSetfocusEdit48)
    ON_EN_SETFOCUS(IDC_EDIT4_9, OnEnSetfocusEdit49)

    ON_EN_SETFOCUS(IDC_EDIT5_1, OnEnSetfocusEdit51)
    ON_EN_SETFOCUS(IDC_EDIT5_2, OnEnSetfocusEdit52)
    ON_EN_SETFOCUS(IDC_EDIT5_3, OnEnSetfocusEdit53)
    ON_EN_SETFOCUS(IDC_EDIT5_4, OnEnSetfocusEdit54)
    ON_EN_SETFOCUS(IDC_EDIT5_5, OnEnSetfocusEdit55)
    ON_EN_SETFOCUS(IDC_EDIT5_6, OnEnSetfocusEdit56)
    ON_EN_SETFOCUS(IDC_EDIT5_7, OnEnSetfocusEdit57)
    ON_EN_SETFOCUS(IDC_EDIT5_8, OnEnSetfocusEdit58)
    ON_EN_SETFOCUS(IDC_EDIT5_9, OnEnSetfocusEdit59)

    ON_EN_SETFOCUS(IDC_EDIT6_1, OnEnSetfocusEdit61)
    ON_EN_SETFOCUS(IDC_EDIT6_2, OnEnSetfocusEdit62)
    ON_EN_SETFOCUS(IDC_EDIT6_3, OnEnSetfocusEdit63)
    ON_EN_SETFOCUS(IDC_EDIT6_4, OnEnSetfocusEdit64)
    ON_EN_SETFOCUS(IDC_EDIT6_5, OnEnSetfocusEdit65)
    ON_EN_SETFOCUS(IDC_EDIT6_6, OnEnSetfocusEdit66)
    ON_EN_SETFOCUS(IDC_EDIT6_7, OnEnSetfocusEdit67)
    ON_EN_SETFOCUS(IDC_EDIT6_8, OnEnSetfocusEdit68)
    ON_EN_SETFOCUS(IDC_EDIT6_9, OnEnSetfocusEdit69)

    ON_EN_SETFOCUS(IDC_EDIT7_1, OnEnSetfocusEdit71)
    ON_EN_SETFOCUS(IDC_EDIT7_2, OnEnSetfocusEdit72)
    ON_EN_SETFOCUS(IDC_EDIT7_3, OnEnSetfocusEdit73)
    ON_EN_SETFOCUS(IDC_EDIT7_4, OnEnSetfocusEdit74)
    ON_EN_SETFOCUS(IDC_EDIT7_5, OnEnSetfocusEdit75)
    ON_EN_SETFOCUS(IDC_EDIT7_6, OnEnSetfocusEdit76)
    ON_EN_SETFOCUS(IDC_EDIT7_7, OnEnSetfocusEdit77)
    ON_EN_SETFOCUS(IDC_EDIT7_8, OnEnSetfocusEdit78)
    ON_EN_SETFOCUS(IDC_EDIT7_9, OnEnSetfocusEdit79)

    ON_EN_SETFOCUS(IDC_EDIT8_1, OnEnSetfocusEdit81)
    ON_EN_SETFOCUS(IDC_EDIT8_2, OnEnSetfocusEdit82)
    ON_EN_SETFOCUS(IDC_EDIT8_3, OnEnSetfocusEdit83)
    ON_EN_SETFOCUS(IDC_EDIT8_4, OnEnSetfocusEdit84)
    ON_EN_SETFOCUS(IDC_EDIT8_5, OnEnSetfocusEdit85)
    ON_EN_SETFOCUS(IDC_EDIT8_6, OnEnSetfocusEdit86)
    ON_EN_SETFOCUS(IDC_EDIT8_7, OnEnSetfocusEdit87)
    ON_EN_SETFOCUS(IDC_EDIT8_8, OnEnSetfocusEdit88)
    ON_EN_SETFOCUS(IDC_EDIT8_9, OnEnSetfocusEdit89)

    ON_EN_SETFOCUS(IDC_EDIT9_1, OnEnSetfocusEdit91)
    ON_EN_SETFOCUS(IDC_EDIT9_2, OnEnSetfocusEdit92)
    ON_EN_SETFOCUS(IDC_EDIT9_3, OnEnSetfocusEdit93)
    ON_EN_SETFOCUS(IDC_EDIT9_4, OnEnSetfocusEdit94)
    ON_EN_SETFOCUS(IDC_EDIT9_5, OnEnSetfocusEdit95)
    ON_EN_SETFOCUS(IDC_EDIT9_6, OnEnSetfocusEdit96)
    ON_EN_SETFOCUS(IDC_EDIT9_7, OnEnSetfocusEdit97)
    ON_EN_SETFOCUS(IDC_EDIT9_8, OnEnSetfocusEdit98)
    ON_EN_SETFOCUS(IDC_EDIT9_9, OnEnSetfocusEdit99)

END_MESSAGE_MAP()


// CSudokuDlg メッセージ ハンドラ

BOOL CSudokuDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// "バージョン情報..." メニューをシステム メニューに追加します。

	// IDM_ABOUTBOX は、システム コマンドの範囲内になければなりません。
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// このダイアログのアイコンを設定します。アプリケーションのメイン ウィンドウがダイアログでない場合、
	//  Framework は、この設定を自動的に行います。
	SetIcon(m_hIcon, TRUE);			// 大きいアイコンの設定
	SetIcon(m_hIcon, FALSE);		// 小さいアイコンの設定

	// TODO: 初期化をここに追加します。
    m_init();
	
	return TRUE;  // フォーカスをコントロールに設定した場合を除き、TRUE を返します。
}

void CSudokuDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// ダイアログに最小化ボタンを追加する場合、アイコンを描画するための
//  下のコードが必要です。ドキュメント/ビュー モデルを使う MFC アプリケーションの場合、
//  これは、Framework によって自動的に設定されます。

void CSudokuDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // 描画のデバイス コンテキスト

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// クライアントの四角形領域内の中央
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// アイコンの描画
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

//ユーザーが最小化したウィンドウをドラッグしているときに表示するカーソルを取得するために、
//  システムがこの関数を呼び出します。
HCURSOR CSudokuDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}

BOOL CSudokuDlg::PreTranslateMessage(MSG* pMsg)
{
    if(pMsg->message == WM_KEYDOWN) {        // キーが押された？
        switch(pMsg->wParam) {
        case VK_RETURN: // リターンキー？
            return FALSE;

        case VK_ESCAPE: // エスケープキー？
            return FALSE;

        case VK_LEFT:
            if(focusRow > 0)
                focusRow --;
            break;

        case VK_UP:
            if(focusLine > 0)
                focusLine --;
            break;

        case VK_RIGHT:
            if(focusRow < 8)
                focusRow ++;
            break;

        case VK_DOWN:
            if(focusLine < 8)
                focusLine ++;
            break;

        default:
            return CDialog::PreTranslateMessage(pMsg);
        }

        m_cel[focusLine][focusRow].m_ctrl->SetFocus();
        m_cel[focusLine][focusRow].m_ctrl->SetSel(0,10);
        return FALSE;
    }

    return CDialog::PreTranslateMessage(pMsg);
}

HBRUSH CSudokuDlg::OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor)
{ 
    Cel *cel;
  HBRUSH hbr = CDialog::OnCtlColor(pDC, pWnd, nCtlColor);
  //---------------------------------------------■ここから
  //■エディットボックスの背景色の変更
  //■通常の場合
  for(int i = 0; i < 9; i++) {
      for(int j = 0; j < 9; j++) {
          cel = &m_cel[i][j];
          if(pWnd == cel->m_ctrl) {
              switch(cel->m_stat) {
              case eFix:
                  pDC->SetBkMode(OPAQUE);  
                  pDC->SetBkColor(m_clrBlue);
                  return m_brushBlue;  
              case eErr:
                  pDC->SetBkMode(OPAQUE);  
                  pDC->SetBkColor(m_clrRed);
                  return m_brushRed;  
              }
              return hbr;
          }
      }
  }
  //---------------------------------------------■ここまで
  return hbr; 
}    


void CSudokuDlg::m_init()
{
    char name[16];

    m_cel[0][0].init(1, 1, &cel11);
    m_cel[0][1].init(1, 2, &cel12);
    m_cel[0][2].init(1, 3, &cel13);
    m_cel[0][3].init(1, 4, &cel14);
    m_cel[0][4].init(1, 5, &cel15);
    m_cel[0][5].init(1, 6, &cel16);
    m_cel[0][6].init(1, 7, &cel17);
    m_cel[0][7].init(1, 8, &cel18);
    m_cel[0][8].init(1, 9, &cel19);

    m_cel[1][0].init(2, 1, &cel21);
    m_cel[1][1].init(2, 2, &cel22);
    m_cel[1][2].init(2, 3, &cel23);
    m_cel[1][3].init(2, 4, &cel24);
    m_cel[1][4].init(2, 5, &cel25);
    m_cel[1][5].init(2, 6, &cel26);
    m_cel[1][6].init(2, 7, &cel27);
    m_cel[1][7].init(2, 8, &cel28);
    m_cel[1][8].init(2, 9, &cel29);

    m_cel[2][0].init(3, 1, &cel31);
    m_cel[2][1].init(3, 2, &cel32);
    m_cel[2][2].init(3, 3, &cel33);
    m_cel[2][3].init(3, 4, &cel34);
    m_cel[2][4].init(3, 5, &cel35);
    m_cel[2][5].init(3, 6, &cel36);
    m_cel[2][6].init(3, 7, &cel37);
    m_cel[2][7].init(3, 8, &cel38);
    m_cel[2][8].init(3, 9, &cel39);

    m_cel[3][0].init(4, 1, &cel41);
    m_cel[3][1].init(4, 2, &cel42);
    m_cel[3][2].init(4, 3, &cel43);
    m_cel[3][3].init(4, 4, &cel44);
    m_cel[3][4].init(4, 5, &cel45);
    m_cel[3][5].init(4, 6, &cel46);
    m_cel[3][6].init(4, 7, &cel47);
    m_cel[3][7].init(4, 8, &cel48);
    m_cel[3][8].init(4, 9, &cel49);

    m_cel[4][0].init(5, 1, &cel51);
    m_cel[4][1].init(5, 2, &cel52);
    m_cel[4][2].init(5, 3, &cel53);
    m_cel[4][3].init(5, 4, &cel54);
    m_cel[4][4].init(5, 5, &cel55);
    m_cel[4][5].init(5, 6, &cel56);
    m_cel[4][6].init(5, 7, &cel57);
    m_cel[4][7].init(5, 8, &cel58);
    m_cel[4][8].init(5, 9, &cel59);

    m_cel[5][0].init(6, 1, &cel61);
    m_cel[5][1].init(6, 2, &cel62);
    m_cel[5][2].init(6, 3, &cel63);
    m_cel[5][3].init(6, 4, &cel64);
    m_cel[5][4].init(6, 5, &cel65);
    m_cel[5][5].init(6, 6, &cel66);
    m_cel[5][6].init(6, 7, &cel67);
    m_cel[5][7].init(6, 8, &cel68);
    m_cel[5][8].init(6, 9, &cel69);

    m_cel[6][0].init(7, 1, &cel71);
    m_cel[6][1].init(7, 2, &cel72);
    m_cel[6][2].init(7, 3, &cel73);
    m_cel[6][3].init(7, 4, &cel74);
    m_cel[6][4].init(7, 5, &cel75);
    m_cel[6][5].init(7, 6, &cel76);
    m_cel[6][6].init(7, 7, &cel77);
    m_cel[6][7].init(7, 8, &cel78);
    m_cel[6][8].init(7, 9, &cel79);

    m_cel[7][0].init(8, 1, &cel81);
    m_cel[7][1].init(8, 2, &cel82);
    m_cel[7][2].init(8, 3, &cel83);
    m_cel[7][3].init(8, 4, &cel84);
    m_cel[7][4].init(8, 5, &cel85);
    m_cel[7][5].init(8, 6, &cel86);
    m_cel[7][6].init(8, 7, &cel87);
    m_cel[7][7].init(8, 8, &cel88);
    m_cel[7][8].init(8, 9, &cel89);

    m_cel[8][0].init(9, 1, &cel91);
    m_cel[8][1].init(9, 2, &cel92);
    m_cel[8][2].init(9, 3, &cel93);
    m_cel[8][3].init(9, 4, &cel94);
    m_cel[8][4].init(9, 5, &cel95);
    m_cel[8][5].init(9, 6, &cel96);
    m_cel[8][6].init(9, 7, &cel97);
    m_cel[8][7].init(9, 8, &cel98);
    m_cel[8][8].init(9, 9, &cel99);

    for(int i=0; i<9; i++) {
        name[0] = 'L';
        name[1] = '1'+i;
        name[2] = '\0';
        m_lineGrp[i].init(
            name,
            &m_cel[i][0],
            &m_cel[i][1],
            &m_cel[i][2],
            &m_cel[i][3],
            &m_cel[i][4],
            &m_cel[i][5],
            &m_cel[i][6],
            &m_cel[i][7],
            &m_cel[i][8]);
    }

    for(int i=0; i<9; i++) {
        name[0] = 'R';
        name[1] = '1'+i;
        name[2] = '\0';
        m_rowGrp[i].init(  
            name,
            &m_cel[0][i],
            &m_cel[1][i],
            &m_cel[2][i],
            &m_cel[3][i],
            &m_cel[4][i],
            &m_cel[5][i],
            &m_cel[6][i],
            &m_cel[7][i],
            &m_cel[8][i]);
    }

    for(int i=0; i<9; i++) {
        int l,r;
        l = i/3;
        r = i%3;
        name[0] = 'B';
        name[1] = '1'+i;
        name[2] = '\0';
        m_blockGrp[i].init(
            name,
            &m_cel[l*3+0][r*3+0],
            &m_cel[l*3+0][r*3+1],
            &m_cel[l*3+0][r*3+2],
            &m_cel[l*3+1][r*3+0],
            &m_cel[l*3+1][r*3+1],
            &m_cel[l*3+1][r*3+2],
            &m_cel[l*3+2][r*3+0],
            &m_cel[l*3+2][r*3+1],
            &m_cel[l*3+2][r*3+2]);
    }




}


void CSudokuDlg::OnEnChangeEdit11() {m_changeEdit(0,0);}
void CSudokuDlg::OnEnChangeEdit12() {m_changeEdit(0,1);}
void CSudokuDlg::OnEnChangeEdit13() {m_changeEdit(0,2);}
void CSudokuDlg::OnEnChangeEdit14() {m_changeEdit(0,3);}
void CSudokuDlg::OnEnChangeEdit15() {m_changeEdit(0,4);}
void CSudokuDlg::OnEnChangeEdit16() {m_changeEdit(0,5);}
void CSudokuDlg::OnEnChangeEdit17() {m_changeEdit(0,6);}
void CSudokuDlg::OnEnChangeEdit18() {m_changeEdit(0,7);}
void CSudokuDlg::OnEnChangeEdit19() {m_changeEdit(0,8);}

void CSudokuDlg::OnEnChangeEdit21() {m_changeEdit(1,0);}
void CSudokuDlg::OnEnChangeEdit22() {m_changeEdit(1,1);}
void CSudokuDlg::OnEnChangeEdit23() {m_changeEdit(1,2);}
void CSudokuDlg::OnEnChangeEdit24() {m_changeEdit(1,3);}
void CSudokuDlg::OnEnChangeEdit25() {m_changeEdit(1,4);}
void CSudokuDlg::OnEnChangeEdit26() {m_changeEdit(1,5);}
void CSudokuDlg::OnEnChangeEdit27() {m_changeEdit(1,6);}
void CSudokuDlg::OnEnChangeEdit28() {m_changeEdit(1,7);}
void CSudokuDlg::OnEnChangeEdit29() {m_changeEdit(1,8);}

void CSudokuDlg::OnEnChangeEdit31() {m_changeEdit(2,0);}
void CSudokuDlg::OnEnChangeEdit32() {m_changeEdit(2,1);}
void CSudokuDlg::OnEnChangeEdit33() {m_changeEdit(2,2);}
void CSudokuDlg::OnEnChangeEdit34() {m_changeEdit(2,3);}
void CSudokuDlg::OnEnChangeEdit35() {m_changeEdit(2,4);}
void CSudokuDlg::OnEnChangeEdit36() {m_changeEdit(2,5);}
void CSudokuDlg::OnEnChangeEdit37() {m_changeEdit(2,6);}
void CSudokuDlg::OnEnChangeEdit38() {m_changeEdit(2,7);}
void CSudokuDlg::OnEnChangeEdit39() {m_changeEdit(2,8);}

void CSudokuDlg::OnEnChangeEdit41() {m_changeEdit(3,0);}
void CSudokuDlg::OnEnChangeEdit42() {m_changeEdit(3,1);}
void CSudokuDlg::OnEnChangeEdit43() {m_changeEdit(3,2);}
void CSudokuDlg::OnEnChangeEdit44() {m_changeEdit(3,3);}
void CSudokuDlg::OnEnChangeEdit45() {m_changeEdit(3,4);}
void CSudokuDlg::OnEnChangeEdit46() {m_changeEdit(3,5);}
void CSudokuDlg::OnEnChangeEdit47() {m_changeEdit(3,6);}
void CSudokuDlg::OnEnChangeEdit48() {m_changeEdit(3,7);}
void CSudokuDlg::OnEnChangeEdit49() {m_changeEdit(3,8);}

void CSudokuDlg::OnEnChangeEdit51() {m_changeEdit(4,0);}
void CSudokuDlg::OnEnChangeEdit52() {m_changeEdit(4,1);}
void CSudokuDlg::OnEnChangeEdit53() {m_changeEdit(4,2);}
void CSudokuDlg::OnEnChangeEdit54() {m_changeEdit(4,3);}
void CSudokuDlg::OnEnChangeEdit55() {m_changeEdit(4,4);}
void CSudokuDlg::OnEnChangeEdit56() {m_changeEdit(4,5);}
void CSudokuDlg::OnEnChangeEdit57() {m_changeEdit(4,6);}
void CSudokuDlg::OnEnChangeEdit58() {m_changeEdit(4,7);}
void CSudokuDlg::OnEnChangeEdit59() {m_changeEdit(4,8);}

void CSudokuDlg::OnEnChangeEdit61() {m_changeEdit(5,0);}
void CSudokuDlg::OnEnChangeEdit62() {m_changeEdit(5,1);}
void CSudokuDlg::OnEnChangeEdit63() {m_changeEdit(5,2);}
void CSudokuDlg::OnEnChangeEdit64() {m_changeEdit(5,3);}
void CSudokuDlg::OnEnChangeEdit65() {m_changeEdit(5,4);}
void CSudokuDlg::OnEnChangeEdit66() {m_changeEdit(5,5);}
void CSudokuDlg::OnEnChangeEdit67() {m_changeEdit(5,6);}
void CSudokuDlg::OnEnChangeEdit68() {m_changeEdit(5,7);}
void CSudokuDlg::OnEnChangeEdit69() {m_changeEdit(5,8);}

void CSudokuDlg::OnEnChangeEdit71() {m_changeEdit(6,0);}
void CSudokuDlg::OnEnChangeEdit72() {m_changeEdit(6,1);}
void CSudokuDlg::OnEnChangeEdit73() {m_changeEdit(6,2);}
void CSudokuDlg::OnEnChangeEdit74() {m_changeEdit(6,3);}
void CSudokuDlg::OnEnChangeEdit75() {m_changeEdit(6,4);}
void CSudokuDlg::OnEnChangeEdit76() {m_changeEdit(6,5);}
void CSudokuDlg::OnEnChangeEdit77() {m_changeEdit(6,6);}
void CSudokuDlg::OnEnChangeEdit78() {m_changeEdit(6,7);}
void CSudokuDlg::OnEnChangeEdit79() {m_changeEdit(6,8);}

void CSudokuDlg::OnEnChangeEdit81() {m_changeEdit(7,0);}
void CSudokuDlg::OnEnChangeEdit82() {m_changeEdit(7,1);}
void CSudokuDlg::OnEnChangeEdit83() {m_changeEdit(7,2);}
void CSudokuDlg::OnEnChangeEdit84() {m_changeEdit(7,3);}
void CSudokuDlg::OnEnChangeEdit85() {m_changeEdit(7,4);}
void CSudokuDlg::OnEnChangeEdit86() {m_changeEdit(7,5);}
void CSudokuDlg::OnEnChangeEdit87() {m_changeEdit(7,6);}
void CSudokuDlg::OnEnChangeEdit88() {m_changeEdit(7,7);}
void CSudokuDlg::OnEnChangeEdit89() {m_changeEdit(7,8);}

void CSudokuDlg::OnEnChangeEdit91() {m_changeEdit(8,0);}
void CSudokuDlg::OnEnChangeEdit92() {m_changeEdit(8,1);}
void CSudokuDlg::OnEnChangeEdit93() {m_changeEdit(8,2);}
void CSudokuDlg::OnEnChangeEdit94() {m_changeEdit(8,3);}
void CSudokuDlg::OnEnChangeEdit95() {m_changeEdit(8,4);}
void CSudokuDlg::OnEnChangeEdit96() {m_changeEdit(8,5);}
void CSudokuDlg::OnEnChangeEdit97() {m_changeEdit(8,6);}
void CSudokuDlg::OnEnChangeEdit98() {m_changeEdit(8,7);}
void CSudokuDlg::OnEnChangeEdit99() {m_changeEdit(8,8);}

void CSudokuDlg::m_changeEdit(int line, int row)
{
    AfxGetApp()->DoWaitCursor(1); 
    m_changeEdit2(line, row);
    AfxGetApp()->DoWaitCursor(-1);
}

void CSudokuDlg::m_changeEdit2(int line, int row)
{
    int i, j, k, ij, ijStart, noneNum;
    int res;
    Cel *cel;
    static int underProc = 0;

    if(underProc)
        return;

    underProc = 1;
    res = m_cel[line][row].changeEdit();

    if(res < 0) {
//        SetWindowText("Sudoku Error");
        underProc = 0;
        return; // 矛盾あり
    }
    else {
//        SetWindowText("Sudoku");
    }

    if(res > 0) { // 要再計算
        for(i = 0; i < 9; i++) {
            for(j = 0; j < 9; j++) {
                m_cel[i][j].clr();
            }
        }
        for(i = 0; i < 9; i++) {
            m_lineGrp[i].clr();
        }
        for(i = 0; i < 9; i++) {
            m_rowGrp[i].clr();
        }
        for(i = 0; i < 9; i++) {
            m_blockGrp[i].clr();
        }

        for(i = 0; i < 9; i++) {
            for(j = 0; j < 9; j++) {
                cel = &m_cel[i][j];
                if(cel->m_stat == eSet) {
                    if(cel->numFix(cel->m_num)) {
                        dbg("err cel[%d,%d].numFix(%d)\n", i+1, j+1, cel->m_num+1);
                        cel->m_ctrl->SetSel(0,10);
                        MessageBeep(MB_OK);
                        cel->m_stat = eErr;
                        underProc = 0;
                        return;
                    }
                }
            }
        }
    }

    if(Grp::checkFlgAll()) {
        dbg("err Grp::checkFlgAll()\n");
        MessageBeep(MB_OK);
        m_cel[line][row].m_ctrl->SetSel(0,10);
        m_cel[line][row].m_stat = eErr;
        underProc = 0;
        return;
    }

    noneNum = 0;
    ij = 0;
    ijStart = ij;
    do {
        i = ij/9; j = ij%9;

        cel = &m_cel[i][j];
        if(cel->m_stat == eNone || cel->m_stat == eErr) {
            noneNum ++;
            k=0;
            while(k<9) {
                if(cel->m_flg[k]) {
                    m_backupWld();
                    // 試しに選んでみる
                    Cel::sm_try = 1;
                    res = cel->numFix(k);
                    if(res == 0) {
                        res = Grp::checkFlgAll();
                    }
                    Cel::sm_try = 0;
                    m_restoreWld();
                    if(res) {
                        // 選んでダメなら選択肢から抜く
                        res = cel->clrFlg(k);
                        if(res == 0)
                            res = Grp::checkFlgAll();
                        if(res) {
                            // 選んでダメ、選ばなくてもダメなら全然ダメ
                            CString str;
                            str.Format("Sudoku TryNG[%d,%d]=%d\n", i+1, j+1, k+1);
                            SetWindowText(str);
                            dbg(str);
                            MessageBeep(MB_OK);
                            m_cel[line][row].m_ctrl->SetSel(0,10);
                            m_cel[line][row].m_stat = eErr;
                            underProc = 0;
                            return;
                        }
                        // 選択肢を抜いて状況が変わったのでもう一周お試しを行う
                        ijStart = ij; 
                        k = 0;
                        noneNum = 0;
                        continue;
                    }

                }
                k ++;
            }
        }

        ij ++;
        if(ij >= 9*9) 
            ij = 0;
    } while(ij != ijStart);


    if(noneNum == 0) { // 完了
        SetWindowText("Sudoku Finish");
        MessageBeep(MB_ICONASTERISK);
    }
    else {
        m_focusEdit(line, row);
    }
    underProc = 0;
}

void CSudokuDlg::m_focusEdit(int line, int row)
{
    int i;
    CString str;
    Cel *cel;

    focusLine = line;
    focusRow = row;
    cel = &m_cel[line][row];

    str.Format("Sudoku [%d,%d]=", line+1, row+1);

    if(cel->m_stat == eSet) {
        str.AppendFormat("<%d>", cel->m_num+1);
    }
    else {
        for(i=0; i<9; i++) {
            if(m_cel[line][row].m_flg[i]) {
                str.AppendFormat("%d", i+1);
            }
        }
    }
    SetWindowText(str);
}

void CSudokuDlg::OnEnSetfocusEdit11() {m_focusEdit(0,0);}
void CSudokuDlg::OnEnSetfocusEdit12() {m_focusEdit(0,1);}
void CSudokuDlg::OnEnSetfocusEdit13() {m_focusEdit(0,2);}
void CSudokuDlg::OnEnSetfocusEdit14() {m_focusEdit(0,3);}
void CSudokuDlg::OnEnSetfocusEdit15() {m_focusEdit(0,4);}
void CSudokuDlg::OnEnSetfocusEdit16() {m_focusEdit(0,5);}
void CSudokuDlg::OnEnSetfocusEdit17() {m_focusEdit(0,6);}
void CSudokuDlg::OnEnSetfocusEdit18() {m_focusEdit(0,7);}
void CSudokuDlg::OnEnSetfocusEdit19() {m_focusEdit(0,8);}

void CSudokuDlg::OnEnSetfocusEdit21() {m_focusEdit(1,0);}
void CSudokuDlg::OnEnSetfocusEdit22() {m_focusEdit(1,1);}
void CSudokuDlg::OnEnSetfocusEdit23() {m_focusEdit(1,2);}
void CSudokuDlg::OnEnSetfocusEdit24() {m_focusEdit(1,3);}
void CSudokuDlg::OnEnSetfocusEdit25() {m_focusEdit(1,4);}
void CSudokuDlg::OnEnSetfocusEdit26() {m_focusEdit(1,5);}
void CSudokuDlg::OnEnSetfocusEdit27() {m_focusEdit(1,6);}
void CSudokuDlg::OnEnSetfocusEdit28() {m_focusEdit(1,7);}
void CSudokuDlg::OnEnSetfocusEdit29() {m_focusEdit(1,8);}

void CSudokuDlg::OnEnSetfocusEdit31() {m_focusEdit(2,0);}
void CSudokuDlg::OnEnSetfocusEdit32() {m_focusEdit(2,1);}
void CSudokuDlg::OnEnSetfocusEdit33() {m_focusEdit(2,2);}
void CSudokuDlg::OnEnSetfocusEdit34() {m_focusEdit(2,3);}
void CSudokuDlg::OnEnSetfocusEdit35() {m_focusEdit(2,4);}
void CSudokuDlg::OnEnSetfocusEdit36() {m_focusEdit(2,5);}
void CSudokuDlg::OnEnSetfocusEdit37() {m_focusEdit(2,6);}
void CSudokuDlg::OnEnSetfocusEdit38() {m_focusEdit(2,7);}
void CSudokuDlg::OnEnSetfocusEdit39() {m_focusEdit(2,8);}

void CSudokuDlg::OnEnSetfocusEdit41() {m_focusEdit(3,0);}
void CSudokuDlg::OnEnSetfocusEdit42() {m_focusEdit(3,1);}
void CSudokuDlg::OnEnSetfocusEdit43() {m_focusEdit(3,2);}
void CSudokuDlg::OnEnSetfocusEdit44() {m_focusEdit(3,3);}
void CSudokuDlg::OnEnSetfocusEdit45() {m_focusEdit(3,4);}
void CSudokuDlg::OnEnSetfocusEdit46() {m_focusEdit(3,5);}
void CSudokuDlg::OnEnSetfocusEdit47() {m_focusEdit(3,6);}
void CSudokuDlg::OnEnSetfocusEdit48() {m_focusEdit(3,7);}
void CSudokuDlg::OnEnSetfocusEdit49() {m_focusEdit(3,8);}

void CSudokuDlg::OnEnSetfocusEdit51() {m_focusEdit(4,0);}
void CSudokuDlg::OnEnSetfocusEdit52() {m_focusEdit(4,1);}
void CSudokuDlg::OnEnSetfocusEdit53() {m_focusEdit(4,2);}
void CSudokuDlg::OnEnSetfocusEdit54() {m_focusEdit(4,3);}
void CSudokuDlg::OnEnSetfocusEdit55() {m_focusEdit(4,4);}
void CSudokuDlg::OnEnSetfocusEdit56() {m_focusEdit(4,5);}
void CSudokuDlg::OnEnSetfocusEdit57() {m_focusEdit(4,6);}
void CSudokuDlg::OnEnSetfocusEdit58() {m_focusEdit(4,7);}
void CSudokuDlg::OnEnSetfocusEdit59() {m_focusEdit(4,8);}

void CSudokuDlg::OnEnSetfocusEdit61() {m_focusEdit(5,0);}
void CSudokuDlg::OnEnSetfocusEdit62() {m_focusEdit(5,1);}
void CSudokuDlg::OnEnSetfocusEdit63() {m_focusEdit(5,2);}
void CSudokuDlg::OnEnSetfocusEdit64() {m_focusEdit(5,3);}
void CSudokuDlg::OnEnSetfocusEdit65() {m_focusEdit(5,4);}
void CSudokuDlg::OnEnSetfocusEdit66() {m_focusEdit(5,5);}
void CSudokuDlg::OnEnSetfocusEdit67() {m_focusEdit(5,6);}
void CSudokuDlg::OnEnSetfocusEdit68() {m_focusEdit(5,7);}
void CSudokuDlg::OnEnSetfocusEdit69() {m_focusEdit(5,8);}

void CSudokuDlg::OnEnSetfocusEdit71() {m_focusEdit(6,0);}
void CSudokuDlg::OnEnSetfocusEdit72() {m_focusEdit(6,1);}
void CSudokuDlg::OnEnSetfocusEdit73() {m_focusEdit(6,2);}
void CSudokuDlg::OnEnSetfocusEdit74() {m_focusEdit(6,3);}
void CSudokuDlg::OnEnSetfocusEdit75() {m_focusEdit(6,4);}
void CSudokuDlg::OnEnSetfocusEdit76() {m_focusEdit(6,5);}
void CSudokuDlg::OnEnSetfocusEdit77() {m_focusEdit(6,6);}
void CSudokuDlg::OnEnSetfocusEdit78() {m_focusEdit(6,7);}
void CSudokuDlg::OnEnSetfocusEdit79() {m_focusEdit(6,8);}

void CSudokuDlg::OnEnSetfocusEdit81() {m_focusEdit(7,0);}
void CSudokuDlg::OnEnSetfocusEdit82() {m_focusEdit(7,1);}
void CSudokuDlg::OnEnSetfocusEdit83() {m_focusEdit(7,2);}
void CSudokuDlg::OnEnSetfocusEdit84() {m_focusEdit(7,3);}
void CSudokuDlg::OnEnSetfocusEdit85() {m_focusEdit(7,4);}
void CSudokuDlg::OnEnSetfocusEdit86() {m_focusEdit(7,5);}
void CSudokuDlg::OnEnSetfocusEdit87() {m_focusEdit(7,6);}
void CSudokuDlg::OnEnSetfocusEdit88() {m_focusEdit(7,7);}
void CSudokuDlg::OnEnSetfocusEdit89() {m_focusEdit(7,8);}

void CSudokuDlg::OnEnSetfocusEdit91() {m_focusEdit(8,0);}
void CSudokuDlg::OnEnSetfocusEdit92() {m_focusEdit(8,1);}
void CSudokuDlg::OnEnSetfocusEdit93() {m_focusEdit(8,2);}
void CSudokuDlg::OnEnSetfocusEdit94() {m_focusEdit(8,3);}
void CSudokuDlg::OnEnSetfocusEdit95() {m_focusEdit(8,4);}
void CSudokuDlg::OnEnSetfocusEdit96() {m_focusEdit(8,5);}
void CSudokuDlg::OnEnSetfocusEdit97() {m_focusEdit(8,6);}
void CSudokuDlg::OnEnSetfocusEdit98() {m_focusEdit(8,7);}
void CSudokuDlg::OnEnSetfocusEdit99() {m_focusEdit(8,8);}

void CSudokuDlg::m_backupWld()
{
    memcpy(m_celBack, m_cel, sizeof(Cel)*9*9);
    memcpy(m_lineGrpBack, m_lineGrp, sizeof(Grp)*9);
    memcpy(m_rowGrpBack, m_rowGrp, sizeof(Grp)*9);
    memcpy(m_blockGrpBack, m_blockGrp, sizeof(Grp)*9);
}

void CSudokuDlg::m_restoreWld()
{
    memcpy(m_cel, m_celBack, sizeof(Cel)*9*9);
    memcpy(m_lineGrp, m_lineGrpBack, sizeof(Grp)*9);
    memcpy(m_rowGrp, m_rowGrpBack, sizeof(Grp)*9);
    memcpy(m_blockGrp, m_blockGrpBack, sizeof(Grp)*9);
    Grp::sm_checkFlgNumList = NULL;
}
