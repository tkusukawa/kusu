#if !defined(AFX_UDPDLG_H__44BCD1E0_BF25_44A9_B5F2_65B94D0E6576__INCLUDED_)
#define AFX_UDPDLG_H__44BCD1E0_BF25_44A9_B5F2_65B94D0E6576__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// UdpDlg.h : ヘッダー ファイル
//

#include "MySocket.h"

/////////////////////////////////////////////////////////////////////////////
// CUdpDlg ダイアログ

class CUdpDlg : public CPortDlg
{
// コンストラクション
public:
	CUdpDlg(CCommRelayDlg* pParent = NULL);   // 標準のコンストラクタ

// ダイアログ データ
	//{{AFX_DATA(CUdpDlg)
	enum { IDD = IDD_DIALOG_UDP };
	CEdit	m_edit_own_addr;
	CEdit	m_edit_send_link;
	CEdit	m_edit_receive_link;
	CEdit	m_edit_own_port;
	CEdit	m_edit_dest_port;
	CEdit	m_edit_dest_host;
	CButton	m_check_bind;
	CButton	m_button_send;
	//}}AFX_DATA


// オーバーライド
	// ClassWizard は仮想関数のオーバーライドを生成します。
	//{{AFX_VIRTUAL(CUdpDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV サポート
	//}}AFX_VIRTUAL

// インプリメンテーション
protected:

	// 生成されたメッセージ マップ関数
	//{{AFX_MSG(CUdpDlg)
	afx_msg void OnClose();
	virtual BOOL OnInitDialog();
	afx_msg void OnCheckBind();
	afx_msg void OnButtonSend();
	afx_msg void OnChangeEditReceiveLink();
	afx_msg void OnChangeEditSendLink();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

protected:
	HICON m_hIcon;

    afx_msg LRESULT WmSockRcv(WPARAM, LPARAM);
    virtual void sndData(const char *a_data, int a_len);
    virtual void rcvData(const char *a_data, int a_len);

    CMySocket sock;
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ は前行の直前に追加の宣言を挿入します。

#endif // !defined(AFX_UDPDLG_H__44BCD1E0_BF25_44A9_B5F2_65B94D0E6576__INCLUDED_)
