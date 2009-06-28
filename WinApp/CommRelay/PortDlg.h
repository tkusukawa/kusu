// PortDlg.h

#define LAST_DATA_LEN_MAX 256
#define EVENT_SND_DATA_DISP 1
#define EVENT_RCV_DATA_DISP 2
#define DISP_LAG 200  // ミリ秒

class CPortDlg : public CDialog
{
public:
	CPortDlg(CCommRelayDlg* pParent = NULL);   // 標準のコンストラクタ
	CPortDlg(UINT nIDTemplate, CCommRelayDlg* pParentWnd = NULL);

    afx_msg void OnTimer(UINT_PTR nIDEvent);

    void setPortIdx(int idx);

    void rlyConnect(int id);
    void rlyDisconnect(int id);
    void rlySndData(int a_id, const char *a_data, int a_len);
protected:
    CCommRelayDlg *parent;

    virtual void connect() {};
    virtual void disconnect() {};
    virtual void sndData(const char *a_data, int a_len) = 0;
    virtual void rcvData(const char *a_data, int a_len) = 0;

    void dispSndData(const char *a_data, int a_len);
    void dispRcvData(const char *a_data, int a_len);

    CEdit m_edit_send;
    char* m_lastSndData[LAST_DATA_LEN_MAX]; 
    int   m_lastSndDataLen;

    CEdit m_edit_receive;
    char* m_lastRcvData[LAST_DATA_LEN_MAX];
    int   m_lastRcvDataLen;

    int portIdx;
    int rlyIdConnect;
    int rlyIdSnd;
    int rlyIdRcv;
};