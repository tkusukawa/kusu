// GhostBoardDlg.h : ヘッダー ファイル
//

#pragma once
#include "myedit.h"

#define		WM_TRYCLK		WM_APP + 3			//タスクトレイ化
#define     HISTORY_NUM     100

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
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
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
    void SetViewState();

    // タスクトレイ化

    // アクティブキー＆マウス位置の定期監視
    afx_msg void OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized);
    bool m_initialized;
    bool m_activate;
    bool m_activeKey;
    UINT m_mouseDistance, m_mouseDistanceFar;

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
    void PopUpMenu();

    afx_msg void OnRButtonDown(UINT nFlags, CPoint point);
    afx_msg void OnMenuClose();
    afx_msg void OnMenuMinimize();

    // 履歴
    signed int m_historyPos, m_historyLookup;
    CString m_historyArray[HISTORY_NUM];
};
