// CommRelayDlg.h : �w�b�_�[ �t�@�C��
//

#if !defined(AFX_COMMRELAYDLG_H__D3F694F8_0FC6_407B_A9CB_996B2F49FF7D__INCLUDED_)
#define AFX_COMMRELAYDLG_H__D3F694F8_0FC6_407B_A9CB_996B2F49FF7D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

enum EComEvnt {
    eCnct,
    eDiscnct,
    eSnd,
    eRcv
};

struct eventContainer {
    eventContainer* m_next; 

    int             m_port;
    EComEvnt        m_evnt;
    DWORD           m_time;
    int             m_len;
    char            m_data[1];
};

#define EVENT_WRITE_LOG 3
#define LOG_LAG 5 // ms

/////////////////////////////////////////////////////////////////////////////
// CCommRelayDlg �_�C�A���O

class CCommRelayDlg : public CDialog
{
// �\�z
public:
	CCommRelayDlg(CWnd* pParent = NULL);	// �W���̃R���X�g���N�^

// �_�C�A���O �f�[�^
	//{{AFX_DATA(CCommRelayDlg)
	enum { IDD = IDD_COMMRELAY_DIALOG };
	CRichEditCtrl	m_richedit_log;
	CButton	m_check_file;
	CEdit	m_edit_file;
	CListBox	m_listPort;
	CButton	m_check_log;
	//}}AFX_DATA

	// ClassWizard �͉��z�֐��̃I�[�o�[���C�h�𐶐����܂��B
	//{{AFX_VIRTUAL(CCommRelayDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV �̃T�|�[�g
	//}}AFX_VIRTUAL

// �C���v�������e�[�V����
protected:
	HICON m_hIcon;

	// �������ꂽ���b�Z�[�W �}�b�v�֐�
	//{{AFX_MSG(CCommRelayDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnButtonLogClear();
	afx_msg void OnButtonAddTcpPort();
	afx_msg void OnDblclkListPort();
	afx_msg void OnButtonAddTcpClientPort();
	afx_msg void OnButtonAddUdpPort();
	afx_msg void OnGetMinMaxInfo(MINMAXINFO FAR* lpMMI);
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnButtonCom();
	afx_msg void OnCheckFile();
	afx_msg void OnButtonFile();
	afx_msg void OnChangeEditFile();
    afx_msg void OnBnClickedCheckLog();
    afx_msg void OnTimer(UINT_PTR nIDEvent);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

public:
    void notifRcvData(int port, const char *data, int len, int relayId);
    void notifSndData(int port, const char *data, int len);
    void notifConnect(int port, int relayId);
    void notifDisconnect(int port, int relayId);
    void notifStatus(int port, const char *text);

protected:
    bool m_initialized; 

    DWORD  m_startTime;
    int    m_portNum;
    CSize  m_szMin;    // �ŏ��T�C�Y�}���p�����o
    CRect  m_dlgRect;
    CRect  m_logRect;

    bool m_logDispCheck;
    bool m_logFileCheck;
    char m_logFileName[1024];

    void init(void);
    void printLog(const char *msg);

    eventContainer*  m_eventLogList;
    eventContainer** m_eventLogListTail;

    void timerWrite(eventContainer* node);
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ �͑O�s�̒��O�ɒǉ��̐錾��}�����܂��B

#endif // !defined(AFX_COMMRELAYDLG_H__D3F694F8_0FC6_407B_A9CB_996B2F49FF7D__INCLUDED_)
