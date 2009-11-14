// GhostBoardDlg.h : �w�b�_�[ �t�@�C��
//

#pragma once
#include "myedit.h"

#define		WM_TRYCLK		WM_APP + 3			//�^�X�N�g���C��
#define     TEMPLATE_NUM    4
#define     HISTORY_NUM     100
#define     WATCH_INTERVAL  100
#define     BALLOON_ACTIVE  10000
#define     BALLOON_COPY    1500
#define     SAVE_TEXT_SIZE  8192

// CGhostBoardDlg �_�C�A���O
class CGhostBoardDlg : public CDialog
{
// �R���X�g���N�V����
public:
	CGhostBoardDlg(CWnd* pParent = NULL);	// �W���R���X�g���N�^

// �_�C�A���O �f�[�^
	enum { IDD = IDD_GHOSTBOARD_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV �T�|�[�g


// ����
protected:
	HICON m_hIcon;

	// �������ꂽ�A���b�Z�[�W���蓖�Ċ֐�
	virtual BOOL OnInitDialog();
    afx_msg void OnDestroy();
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
    afx_msg LRESULT WindowProc(UINT message, WPARAM wParam, LPARAM lParam);
    afx_msg HBRUSH OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor);
public:
    // �R���g���[��
    CMyEdit m_edit; 

    // ESC�L�[�̖�����
    BOOL PreTranslateMessage(MSG *pMsg);

    // �ړ��ƃ��T�C�Y
    afx_msg void OnSize(UINT nType, int cx, int cy);
    afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
    afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
    bool            m_leftDown;
    POINT           m_leftDownCursorPos;
    WINDOWPLACEMENT m_leftDownWindowPos;

    // ������
    int m_alphaDefault;
    int m_alphaMouse;
    void SetViewState();

    // �^�X�N�g���C��
    NOTIFYICONDATA m_icon;
    void DispInfo(UINT timeout_ms); // �o���[���\��
    void EraseInfo(); // �o���[���\������
    UINT m_balloonTime;

    // �A�N�e�B�u�L�[���}�E�X�ʒu�̒���Ď�
    afx_msg void OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized);
    bool m_initialized;
    bool m_activate;
    bool m_activeKey;
    UINT m_mouseDistance, m_mouseDistanceFar;
    bool m_confCtrl, m_confShift, m_confAlt, m_confWin;

    afx_msg void OnMouseMove(UINT nFlags, CPoint point);
    afx_msg void OnTimer(UINT_PTR nIDEvent);

    // �N���b�v�{�[�h�̊Ď��Ə�������
    HWND m_nextClipboardViewerHandle;

    afx_msg void OnDrawClipboard();
    afx_msg void OnChangeCbChain(HWND hWndRemove, HWND hWndAfter);
    bool SetTextToClipboard(CString& str);

    // ��Ԃ̕ۑ��Ɠǂݏo��
    bool Save();
    bool Load();

    // �|�b�v�A�b�v���j���[
    bool m_hide; // ��\�����
    void PopUpMenu();

    afx_msg void OnRButtonDown(UINT nFlags, CPoint point);
    afx_msg void OnMenuClose();
    afx_msg void OnMenuHide();
    afx_msg void OnMenuSettings();

    // �����E�e���v���[�g
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

    // �z�b�g�L�[
    int m_hotKeyUp;   // ����O
    int m_hotKeyDown; // ������
    int m_hotKeyLeft;   // �e���v���[�g�O
    int m_hotKeyRight;  // �e���v���[�g��
    void StartHotKey();
    void StopHotKey();
};
