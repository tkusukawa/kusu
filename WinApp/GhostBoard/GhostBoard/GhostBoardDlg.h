// GhostBoardDlg.h : �w�b�_�[ �t�@�C��
//

#pragma once
#include "myedit.h"

#define		WM_TRYCLK		WM_APP + 3			//�^�X�N�g���C��
#define     HISTORY_NUM     100

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
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
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
    void SetViewState();

    // �^�X�N�g���C��

    // �A�N�e�B�u�L�[���}�E�X�ʒu�̒���Ď�
    afx_msg void OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized);
    bool m_initialized;
    bool m_activate;
    bool m_activeKey;
    UINT m_mouseDistance, m_mouseDistanceFar;

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
    void PopUpMenu();

    afx_msg void OnRButtonDown(UINT nFlags, CPoint point);
    afx_msg void OnMenuClose();
    afx_msg void OnMenuMinimize();

    // ����
    signed int m_historyPos, m_historyLookup;
    CString m_historyArray[HISTORY_NUM];
};
