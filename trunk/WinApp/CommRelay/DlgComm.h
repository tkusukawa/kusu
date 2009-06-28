#if !defined(AFX_DLGCOMM_H__65388389_9E52_46FD_9EEC_8D54610D4D5C__INCLUDED_)
#define AFX_DLGCOMM_H__65388389_9E52_46FD_9EEC_8D54610D4D5C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// DlgComm.h : �w�b�_�[ �t�@�C��
//

#define WM_COMM_RCV WM_USER+2

struct CommPostData
{
    unsigned short len;
    unsigned char data[1];
};



/////////////////////////////////////////////////////////////////////////////
// CDlgComm �_�C�A���O

class CDlgComm : public CPortDlg
{
// �R���X�g���N�V����
public:
	CDlgComm(CCommRelayDlg* pParent = NULL);   // �W���̃R���X�g���N�^
    ~CDlgComm();

// �_�C�A���O �f�[�^
	//{{AFX_DATA(CDlgComm)
	enum { IDD = IDD_DIALOG_COMM };
	CEdit	m_edit_send_link;
	CEdit	m_edit_receive_link;
	CButton	m_button_send;
	CEdit	m_edit_config;
	CEdit	m_edit_port;
	CButton	m_check_connect;
	//}}AFX_DATA


// �I�[�o�[���C�h
	// ClassWizard �͉��z�֐��̃I�[�o�[���C�h�𐶐����܂��B
	//{{AFX_VIRTUAL(CDlgComm)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV �T�|�[�g
	//}}AFX_VIRTUAL

// �C���v�������e�[�V����
protected:

	// �������ꂽ���b�Z�[�W �}�b�v�֐�
	//{{AFX_MSG(CDlgComm)
	afx_msg void OnClose();
	afx_msg void OnCheckConnect();
	virtual BOOL OnInitDialog();
	afx_msg void OnButtonSend();
	afx_msg void OnChangeEditSendLink();
	afx_msg void OnChangeEditReceiveLink();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

protected:
	HICON m_hIcon;

    HANDLE comHdl;
    OVERLAPPED comReadOverlapped, comWriteOverlapped;
    OVERLAPPED comReadOverlappedLast;
    HANDLE comReadEvent, comWriteEvent;

    int comOpen(const char *devName, const char *config);
    int comClose();
    int comWrite(const unsigned char *data, int len);
    void MessageError(const char *text);

    HANDLE thread;
    volatile int threadRun;
    DWORD threadId;
    static DWORD WINAPI ThreadProc(LPVOID param);
    DWORD WINAPI threadProc();

    afx_msg LRESULT WmCommRcv(WPARAM, LPARAM);
    virtual void sndData(const char *a_data, int a_len);
    virtual void rcvData(const char *a_data, int a_len);
};



//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ �͑O�s�̒��O�ɒǉ��̐錾��}�����܂��B

#endif // !defined(AFX_DLGCOMM_H__65388389_9E52_46FD_9EEC_8D54610D4D5C__INCLUDED_)
