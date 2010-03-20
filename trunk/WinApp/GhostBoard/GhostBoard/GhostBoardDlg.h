// GhostBoardDlg.h : �w�b�_�[ �t�@�C��
//

#pragma once
#include "myedit.h"

#define     APP_NAME        _T("GhostBoard-1.1.10") // ���\�[�X����̃o�[�W�����擾���@���킩��܂���

#define	    WM_TRYCLK		WM_APP + 3	//�^�X�N�g���C��

#define     CB_RETRY        3
#define     TEMPLATE_NUM    4
#define     HISTORY_NUM     32

#define     WATCH_INTERVAL  100
#define     BALLOON_ACTIVE  5000
#define     BALLOON_COPY    1500
#define     CHK_SCR_INTERVAL 10000 // 10�b���ɉ�ʃT�C�Y���m�F����
#define     GET_FOCUS_WAIT  100

#define     SAVE_TEXT_SIZE  8192

#define     ID_SEL_HISTORY  0xD000
#define     ID_SEL_RED      0xD100
#define     ID_SEL_GREEN    0xD200
#define     ID_SEL_BLUE     0xD300
#define     ID_SEL_MAX      0xD400

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
    // ���
    BootStatus m_bootStatus;
    DispStatus m_dispStatus;
    bool       m_actKeyStatus;

    // �R���g���[��
    CMyEdit m_edit; 

    // ESC�L�[�̖�����
    BOOL PreTranslateMessage(MSG *pMsg);

    // �ړ��ƃ��T�C�Y
    afx_msg void OnSize(UINT nType, int cx, int cy);
    afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
    afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
    afx_msg void OnMouseMove(UINT nFlags, CPoint point);
    bool            m_leftDown;
    POINT           m_leftDownCursorPos;
    WINDOWPLACEMENT m_leftDownWindowPos;
    WINDOWPLACEMENT m_windowPos;
    int             m_chkScrTimer; // ��ʃT�C�Y�m�F�_�E���^�C�}

    // ������
    int m_alphaActive;
    int m_alphaDefault;
    int m_alphaMouse;
    void SetViewState();

    // �^�X�N�g���C��
    NOTIFYICONDATA m_icon;
    void DispInfo(UINT timeout_ms, LPCWSTR msg = NULL); // �o���[���\��
    void EraseInfo(); // �o���[���\������
    UINT m_balloonTime;

    // �t�H�[�J�X�Ď�
    afx_msg void OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized);
    void getFocus();
    void lostFocus();

    // �A�N�e�B�u�L�[���}�E�X�ʒu�̒���Ď�
    UINT m_mouseDistance, m_mouseDistanceFar;
    int m_confCtrl, m_confShift, m_confAlt, m_confWin;

    afx_msg void OnTimer(UINT_PTR nIDEvent);

    // �N���b�v�{�[�h�̊Ď��Ə�������
    HWND m_nextClipboardViewerHandle;
    bool m_cbEventFlg;

    afx_msg void OnDrawClipboard();
    bool OnCbUpdate();
    afx_msg void OnChangeCbChain(HWND hWndRemove, HWND hWndAfter);
    bool CheckCbConnect();
    bool SetTextToClipboard(CString& str);

    // ��Ԃ̕ۑ��Ɠǂݏo��
    bool Save();
    bool Load();

    // �|�b�v�A�b�v���j���[
    bool m_iconNotif; // �o���[���\���C�l�[�u��
    void PopUpMenu();

    afx_msg void OnRButtonDown(UINT nFlags, CPoint point);
    afx_msg void OnMenuClose();
    afx_msg void OnMenuSettings();
    afx_msg void OnExecMenu(UINT uID);

    // �����E�e���v���[�g
    static COLORREF sm_color[TEMPLATE_NUM+1];
    CBrush m_brush[TEMPLATE_NUM+1];
    int     m_template, m_historyPos, m_historyNum, m_historyCount;
    int     m_lookupPos[TEMPLATE_NUM];
    CString m_textArray[TEMPLATE_NUM][HISTORY_NUM];
    CTime m_historyTime[HISTORY_NUM];
    void HistoryBackward();
    void HistoryForward();
    void TemplateBackward();
    void TemplateForward();
    void rememberTemplate();

    // �z�b�g�L�[
    int m_hotKeyUp;   // ����O
    int m_hotKeyDown; // ������
    int m_hotKeyLeft;   // �e���v���[�g�O
    int m_hotKeyRight;  // �e���v���[�g��
    int m_hotKeyEnter;  // �t�H�[�J�X�ݒ�
    void StartHotKey();
    void StopHotKey();

    // �A���[�g�\��
    void DispAlert(LPCWSTR msg);

    // ���̃A�v���P�[�V�����ւ̕�����}��
    CWnd* m_lastWindow;
    void TextInsertToOther(HWND hWnd, CString &str);
};
