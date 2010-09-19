// GhostBoardDlg.h : ヘッダー ファイル
//

#pragma once
#include "myedit.h"
#include "afxwin.h"
#include "GhostBoardList.h"

#define     APP_NAME        _T("GhostBoard-1.1.18") // リソースからのバージョン取得方法がわかりません

#define	    WM_TRYCLK		WM_APP + 3	//タスクトレイ化

#define     CB_RETRY        3
#define     TEMPLATE_NUM    4

#define     WATCH_INTERVAL  100
#define     BALLOON_ACTIVE  5000
#define     BALLOON_COPY    1500
#define     BALLOON_LOOKUP  10000
#define     CHK_SCR_INTERVAL 10000 // 10秒毎に画面サイズを確認する
#define     GET_FOCUS_WAIT  100

#define     SAVE_TEXT_SIZE  8192

#define     ID_SEL_HISTORY  0xD000U
#define     ID_SEL_RED      0xD100U
#define     ID_SEL_GREEN    0xD200U
#define     ID_SEL_BLUE     0xD300U
#define     ID_SEL_MAX      0xD400U

enum BootStatus {
    BS_none,
    BS_booting,
    BS_ready
};

enum DispStatus {
    DS_none,
    DS_activeKey,
    DS_focus
};

enum LastOperation {
    LO_none,
    LO_edit,
    LO_copy
};

// CGhostBoardDlg ダイアログ
class CGhostBoardDlg : public CDialog
{
// コンストラクション
public:
	CGhostBoardDlg(CWnd* pParent = NULL);	// 標準コンストラクタ

// ダイアログ データ
	enum { IDD = IDD_GHOSTBOARD_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV サポート


// 実装
protected:
	HICON m_hIcon;

	// 生成された、メッセージ割り当て関数
	virtual BOOL OnInitDialog();
    afx_msg void OnDestroy();
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
    afx_msg LRESULT WindowProc(UINT message, WPARAM wParam, LPARAM lParam);
    afx_msg HBRUSH OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor);
public:
    // 状態
    BootStatus m_bootStatus;
    DispStatus m_dispStatus;
    bool       m_actKeyStatus;
    LastOperation m_lastOp;
    afx_msg void OnEnChangeEdit();

    // コントロール
    CMyEdit m_edit; 

    // ESCキーの無効化
    BOOL PreTranslateMessage(MSG *pMsg);

    // 移動とリサイズ
    afx_msg void OnSize(UINT nType, int cx, int cy);
    afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
    afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
    afx_msg void OnMouseMove(UINT nFlags, CPoint point);
    bool            m_leftDown;
    POINT           m_leftDownCursorPos;
    WINDOWPLACEMENT m_leftDownWindowPos;
    WINDOWPLACEMENT m_windowPos;
    int             m_chkScrTimer; // 画面サイズ確認ダウンタイマ

    // 透明化
    int m_alphaActive;
    int m_alphaDefault;
    int m_alphaMouse;
    void SetViewState();

    // タスクトレイ化
    NOTIFYICONDATA m_icon;
    void DispInfo(UINT timeout_ms, LPCWSTR msg = NULL); // バルーン表示
    void EraseInfo(); // バルーン表示解除
    UINT m_balloonTime;

    // フォーカス監視
    afx_msg void OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized);
    void getFocus();
    void lostFocus();

    // アクティブキー＆マウス位置の定期監視
    UINT m_mouseDistance, m_mouseDistanceFar;
    int m_confCtrl, m_confShift, m_confAlt, m_confWin;

    afx_msg void OnTimer(UINT_PTR nIDEvent);

    // クリップボードの監視と書き込み
    HWND m_nextClipboardViewerHandle;
    bool m_cbEventFlg;

    afx_msg void OnDrawClipboard();
    afx_msg void OnChangeCbChain(HWND hWndRemove, HWND hWndAfter);
    bool CheckCbConnect();
    bool GetTextFromClilpboard();
    bool SetTextToClipboard(CString& str);

    // 状態の保存と読み出し
    bool Save();
    bool Load();

    // ポップアップメニュー
    int  m_iconNotif; // バルーン表示イネーブル
    void PopUpMenu(const POINT &pnt);

    afx_msg void OnRButtonDown(UINT nFlags, CPoint point);
    afx_msg void OnMenuClose();
    afx_msg void OnMenuSettings();
    afx_msg void OnExecMenu(UINT uID);
    afx_msg void OnMenuSelect(UINT nItemID, UINT nFlags, HMENU hSysMenu);
    bool m_dropFocus;

    // 履歴・テンプレート
    int m_textNum[TEMPLATE_NUM];
    static COLORREF sm_color[TEMPLATE_NUM+1];
    CBrush m_brush[TEMPLATE_NUM+1];
    int     m_template, m_historyPos, m_historyNum, m_historyCount;
    int     m_lookupPos[TEMPLATE_NUM];
    CString* m_textArray[TEMPLATE_NUM];
    CTime* m_historyTime;
    void HistoryBackward();
    void HistoryForward();
    void TemplateBackward();
    void TemplateForward();
    void rememberTemplate();
    void replaceTextNum(int*);

    // ホットキー
    int m_hotKeyUp;   // 履歴前
    int m_hotKeyDown; // 履歴後
    int m_hotKeyLeft;   // テンプレート前
    int m_hotKeyRight;  // テンプレート後
    int m_hotKeyMenu;   // メニュー表示
    int m_hotKeyFocus;  // フォーカス取得
    void StartHotKey();
    void StopHotKey();
    int hotKeyF2mod(int hotKeyF);

    // アラート表示
    void DispAlert(LPCWSTR msg);

	// Listダイアログ表示
	int m_listHeight;
    int m_alphaList;
	CGhostBoardList *m_listDlg;
    bool m_listDlgNeedRedraw;
	void ShowList();
	void HideList();

    // 他のアプリケーションへの文字列挿入
    CWnd* m_lastWindow;
    void TextInsertToOther(HWND hWnd, CString &str);
};
