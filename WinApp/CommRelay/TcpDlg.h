#if !defined(AFX_TCPDLG_H__95E65829_91B8_4FAB_A0D2_AEE2F93693F3__INCLUDED_)
#define AFX_TCPDLG_H__95E65829_91B8_4FAB_A0D2_AEE2F93693F3__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// TcpDlg.h : ヘッダー ファイル
//

#include "MySocket.h"

/////////////////////////////////////////////////////////////////////////////
// CTcpDlg ダイアログ

class CTcpDlg : public CPortDlg
{
// コンストラクション
public:
	CTcpDlg(CCommRelayDlg* pParent = NULL);   // 標準のコンストラクタ

// ダイアログ データ
	//{{AFX_DATA(CTcpDlg)
	enum { IDD = IDD_DIALOG_TCP };
	CButton	m_checkListen;
	//CEdit	m_edit_receive;
	CEdit	m_edit_relay_c;
	CEdit	m_edit_relay_receive;
	CEdit	m_edit_relay_send;
	//CEdit	m_edit_send;
	CEdit	m_edit_status;
	CButton	m_button_close;
	CEdit	m_edit_port;
	CButton	m_button_send;
	//}}AFX_DATA


// オーバーライド
	// ClassWizard は仮想関数のオーバーライドを生成します。
	//{{AFX_VIRTUAL(CTcpDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV サポート
	//}}AFX_VIRTUAL




// インプリメンテーション
protected:

	// 生成されたメッセージ マップ関数
	//{{AFX_MSG(CTcpDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnClose();
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnButtonListen();
	afx_msg void OnButtonClose();
	afx_msg void OnButtonSend();
	afx_msg void OnChangeEditRelayC();
	afx_msg void OnChangeEditRelayReceive();
	afx_msg void OnChangeEditRelaySend();
	afx_msg void OnCheckListen();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

protected:
	HICON m_hIcon;

    afx_msg LRESULT WmSockRcv(WPARAM, LPARAM);
    virtual void disconnect();
    virtual void sndData(const char *data, int len);
    virtual void rcvData(const char *data, int len);

    CMySocket sock;
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ は前行の直前に追加の宣言を挿入します。

#endif // !defined(AFX_TCPDLG_H__95E65829_91B8_4FAB_A0D2_AEE2F93693F3__INCLUDED_)
