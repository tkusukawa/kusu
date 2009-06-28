#if !defined(AFX_TCPCLIENTDLG_H__A95BD67C_7B76_4131_BB6C_F0BC4726DB6E__INCLUDED_)
#define AFX_TCPCLIENTDLG_H__A95BD67C_7B76_4131_BB6C_F0BC4726DB6E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// TcpClientDlg.h : ヘッダー ファイル
//

#include "MySocket.h"

/////////////////////////////////////////////////////////////////////////////
// CTcpClientDlg ダイアログ

typedef enum {
    TCPC_CLOSE,
    TCPC_CONNECT
} ClientStat;


class CTcpClientDlg : public CPortDlg
{
// コンストラクション
public:
	CTcpClientDlg(CCommRelayDlg* pParent = NULL);   // 標準のコンストラクタ

// ダイアログ データ
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


// オーバーライド
	// ClassWizard は仮想関数のオーバーライドを生成します。
	//{{AFX_VIRTUAL(CTcpClientDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV サポート
	//}}AFX_VIRTUAL

// インプリメンテーション
protected:

	// 生成されたメッセージ マップ関数
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
// Microsoft Visual C++ は前行の直前に追加の宣言を挿入します。

#endif // !defined(AFX_TCPCLIENTDLG_H__A95BD67C_7B76_4131_BB6C_F0BC4726DB6E__INCLUDED_)
