#if !defined(AFX_TCPCLIENTDLG_H__A95BD67C_7B76_4131_BB6C_F0BC4726DB6E__INCLUDED_)
#define AFX_TCPCLIENTDLG_H__A95BD67C_7B76_4131_BB6C_F0BC4726DB6E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// TcpClientDlg.h : �w�b�_�[ �t�@�C��
//

#include "MySocket.h"

/////////////////////////////////////////////////////////////////////////////
// CTcpClientDlg �_�C�A���O

typedef enum {
    TCPC_CLOSE,
    TCPC_CONNECT
} ClientStat;


class CTcpClientDlg : public CPortDlg
{
// �R���X�g���N�V����
public:
	CTcpClientDlg(CCommRelayDlg* pParent = NULL);   // �W���̃R���X�g���N�^

// �_�C�A���O �f�[�^
	//{{AFX_DATA(CTcpClientDlg)
	enum { IDD = IDD_DIALOG_TCP_CLIENT };
	CEdit	m_edit_status;
	CEdit	m_edit_send_link;
	//CEdit	m_edit_send;
	CEdit	m_edit_receive_link;
	//CEdit	m_edit_receive;
	CEdit	m_edit_host;
	CEdit	m_edit_connect_link;
	CButton	m_check_connect;
	CButton	m_button_send;
	CEdit	m_edit_port;
	//}}AFX_DATA


// �I�[�o�[���C�h
	// ClassWizard �͉��z�֐��̃I�[�o�[���C�h�𐶐����܂��B
	//{{AFX_VIRTUAL(CTcpClientDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV �T�|�[�g
	//}}AFX_VIRTUAL

// �C���v�������e�[�V����
protected:

	// �������ꂽ���b�Z�[�W �}�b�v�֐�
	//{{AFX_MSG(CTcpClientDlg)
	afx_msg void OnClose();
	virtual BOOL OnInitDialog();
	afx_msg void OnCheckConnect();
	afx_msg void OnButtonSend();
	afx_msg void OnChangeEditConnectLink();
	afx_msg void OnChangeEditReceiveLink();
	afx_msg void OnChangeEditSendLink();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

protected:
	HICON m_hIcon;

    afx_msg LRESULT WmSockRcv(WPARAM, LPARAM);
    virtual void connect();
    virtual void disconnect();
    virtual void sndData(const char *a_data, int a_len);
    virtual void rcvData(const char *a_data, int a_len);

    ClientStat stat;
    CMySocket sock;
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ �͑O�s�̒��O�ɒǉ��̐錾��}�����܂��B

#endif // !defined(AFX_TCPCLIENTDLG_H__A95BD67C_7B76_4131_BB6C_F0BC4726DB6E__INCLUDED_)
