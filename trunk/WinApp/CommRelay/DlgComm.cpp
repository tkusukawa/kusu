// DlgComm.cpp : �C���v�������e�[�V���� �t�@�C��
//

#include "stdafx.h"
#include "CommRelay.h"
#include "CommRelayDlg.h"
#include "PortDlg.h"
#include "DlgComm.h"
#include "dataPart.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDlgComm �_�C�A���O


CDlgComm::CDlgComm(CCommRelayDlg* pParent /*=NULL*/)
	: CPortDlg(CDlgComm::IDD, pParent)
{
	//{{AFX_DATA_INIT(CDlgComm)
		// ���� - ClassWizard �͂��̈ʒu�Ƀ}�b�s���O�p�̃}�N����ǉ��܂��͍폜���܂��B
	//}}AFX_DATA_INIT
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);


}

CDlgComm::~CDlgComm()
{

}

void CDlgComm::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDlgComm)
	DDX_Control(pDX, IDC_EDIT_SEND_LINK, m_edit_send_link);
	DDX_Control(pDX, IDC_EDIT_RECEIVE_LINK, m_edit_receive_link);
	DDX_Control(pDX, IDC_EDIT_SEND, m_edit_send);
	DDX_Control(pDX, IDC_EDIT_RECEIVE, m_edit_receive);
	DDX_Control(pDX, IDC_BUTTON_SEND, m_button_send);
	DDX_Control(pDX, IDC_EDIT_CONFIG, m_edit_config);
	DDX_Control(pDX, IDC_EDIT_PORT, m_edit_port);
	DDX_Control(pDX, IDC_CHECK_CONNECT, m_check_connect);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CDlgComm, CDialog)
	//{{AFX_MSG_MAP(CDlgComm)
	ON_WM_CLOSE()
	ON_BN_CLICKED(IDC_CHECK_CONNECT, OnCheckConnect)
	ON_BN_CLICKED(IDC_BUTTON_SEND, OnButtonSend)
	ON_MESSAGE(WM_COMM_RCV, WmCommRcv)
	ON_EN_CHANGE(IDC_EDIT_SEND_LINK, OnChangeEditSendLink)
	ON_EN_CHANGE(IDC_EDIT_RECEIVE_LINK, OnChangeEditReceiveLink)
	//}}AFX_MSG_MAP
    ON_WM_TIMER()
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDlgComm ���b�Z�[�W �n���h��
BOOL CDlgComm::OnInitDialog() 
{
    CString name;

	CDialog::OnInitDialog();

    SetIcon(m_hIcon, TRUE);			// �傫���A�C�R����ݒ�
	SetIcon(m_hIcon, FALSE);		// �������A�C�R����ݒ�
	
	// TODO: ���̈ʒu�ɏ������̕⑫������ǉ����Ă�������
    name.Format("Port %d : COM", portIdx);
    SetWindowText(name);
    m_edit_port.SetWindowText("1");
    m_edit_config.SetWindowText("115200,N,8,1");
    m_edit_send_link.SetWindowText("0");
    m_edit_receive_link.SetWindowText("0");
	
	return TRUE;  // �R���g���[���Ƀt�H�[�J�X��ݒ肵�Ȃ��Ƃ��A�߂�l�� TRUE �ƂȂ�܂�
	              // ��O: OCX �v���p�e�B �y�[�W�̖߂�l�� FALSE �ƂȂ�܂�
}

void CDlgComm::OnClose() 
{
    ShowWindow(SW_HIDE);
//	CDialog::OnClose();
}


void CDlgComm::OnCheckConnect() 
{
    CString port, config;

    if(m_check_connect.GetCheck()) {
        m_edit_port.GetWindowText(port);
        port = "\\\\.\\COM"+port;
        m_edit_config.GetWindowText(config);
        if(comOpen(port, config)) {
            // �I�[�v�����s
            m_check_connect.SetCheck(0);
            m_edit_port.EnableWindow(TRUE);
            m_edit_config.EnableWindow(TRUE);
            m_button_send.EnableWindow(FALSE);
            return;
        }
        m_edit_port.EnableWindow(FALSE);
        m_edit_config.EnableWindow(FALSE);
        m_button_send.EnableWindow(TRUE);
        
    }
    else {
        comClose();
        m_edit_port.EnableWindow(TRUE);
        m_edit_config.EnableWindow(TRUE);
        m_button_send.EnableWindow(FALSE);
    }
    
}

void CDlgComm::OnButtonSend() 
{
    CString str;
    int len;
    unsigned char data[4096];

    m_edit_send.GetWindowText(str);
    len = csh2bin(str, data);
    sndData((char *)data, len);
}

LRESULT CDlgComm::WmCommRcv(WPARAM w, LPARAM l)
{
    CommPostData *msg = (CommPostData *)w;
    rcvData((char *)msg->data, msg->len);

    return 0;
}


void CDlgComm::OnChangeEditSendLink() 
{
    char str[16];

    m_edit_send_link.GetWindowText(str, 16);
    rlyIdSnd = atoi(str);
}

void CDlgComm::OnChangeEditReceiveLink() 
{
    char str[16];

    m_edit_receive_link.GetWindowText(str, 16);
    rlyIdRcv = atoi(str);
}

void CDlgComm::sndData(const char *a_data, int a_len)
{
    comWrite((const unsigned char *)a_data, a_len);

    parent->notifSndData(portIdx, a_data, a_len);

    dispSndData(a_data, a_len);
}

void CDlgComm::rcvData(const char* a_data, int a_len)
{
    parent->notifRcvData(portIdx, a_data, a_len, rlyIdRcv);

    dispRcvData(a_data, a_len);
}

