// GhostBoardDlg.h : ヘッダー ファイル
//

#pragma once
#include "myedit.h"

#define		WM_TRYCLK		WM_APP + 3			//タスクトレイ化
#define     TEMPLATE_NUM    4
#define     HISTORY_NUM     100
#define     WATCH_INTERVAL  100
#define     BALLOON_ACTIVE  10000
#define     BALLOON_COPY    1500
#define     SAVE_TEXT_SIZE  8192

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
    // コントロール
    CMyEdit m_edit; 

    // ESCキーの無効化
    BOOL PreTranslateMessage(MSG *pMsg);

    // 移動とリサイズ
    afx_msg void OnSize(UINT nType, int cx, int cy);
    afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
    afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
    bool            m_leftDown;
    POINT           m_leftDownCursorPos;
    WINDOWPLACEMENT m_leftDownWindowPos;

    // 透明化
    int m_alphaDefault;
    int m_alphaMouse;
    void SetViewState();

    // タスクトレイ化
    NOTIFYICONDATA m_icon;
    void DispInfo(UINT timeout_ms); // バルーン表示
    void EraseInfo(); // バルーン表示解除
    UINT m_balloonTime;

    // アクティブキー＆マウス位置の定期監視
    afx_msg void OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized);
    bool m_initialized;
    bool m_activate;
    bool m_activeKey;
    UINT m_mouseDistance, m_mouseDistanceFar;
    bool m_confCtrl, m_confShift, m_confAlt, m_confWin;

    afx_msg void OnMouseMove(UINT nFlags, CPoint point);
    afx_msg void OnTimer(UINT_PTR nIDEvent);

    // クリップボードの監視と書き込み
    HWND m_nextClipboardViewerHandle;

    afx_msg void OnDrawClipboard();
    afx_msg void OnChangeCbChain(HWND hWndRemove, HWND hWndAfter);
    bool SetTextToClipboard(CString& str);

    // 状態の保存と読み出し
    bool Save();
    bool Load();

    // ポップアップメニュー
    bool m_hide; // 非表示状態
    void PopUpMenu();

    afx_msg void OnRButtonDown(UINT nFlags, CPoint point);
    afx_msg void OnMenuClose();
    afx_msg void OnMenuHide();
    afx_msg void OnMenuSettings();

    // 履歴・テンプレート
    static COLORREF sm_color[TEMPLATE_NUM];
    CBrush m_brush[TEMPLATE_NUM];
    int     m_template, m_historyPos, m_historyNum, m_historyCount;
    int     m_lookupPos[TEMPLATE_NUM];
    CString m_textArray[TEMPLATE_NUM][HISTORY_NUM];
    CTime m_historyTime[HISTORY_NUM];
    void HistoryBackward();
    void HistoryForward();
    void TemplateBackward();
    void TemplateForward();

    // ホットキー
    int m_hotKeyUp;   // 履歴前
    int m_hotKeyDown; // 履歴後
    int m_hotKeyLeft;   // テンプレート前
    int m_hotKeyRight;  // テンプレート後
    void StartHotKey();
    void StopHotKey();
};
