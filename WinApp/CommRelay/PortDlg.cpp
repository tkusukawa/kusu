// PortDlg.cpp

#include "stdafx.h"
#include "CommRelay.h"
#include "CommRelayDlg.h"
#include "PortDlg.h"

CPortDlg::CPortDlg(UINT nIDTemplate, CCommRelayDlg* pParentWnd /*=NULL*/)
	: CDialog(nIDTemplate, pParentWnd)
{
    parent = pParentWnd;

    rlyIdConnect = 0;
    rlyIdSnd = 0;
    rlyIdRcv = 0;
}

void CPortDlg::setPortIdx(int idx)
{
    portIdx = idx;
}

void CPortDlg::rlyConnect(int id) 
{
    if(rlyIdConnect != 0 && (id == -1 || rlyIdConnect == -1 || rlyIdConnect == id))
        connect();
}

void CPortDlg::rlyDisconnect(int id)
{
    if(rlyIdConnect != 0 && (id == -1 || rlyIdConnect == -1  || rlyIdConnect == id))
        disconnect();
}

void CPortDlg::rlySndData(int id, const char *data, int len)
{
    if(rlyIdSnd != 0 && (id == -1 || rlyIdSnd == -1 || rlyIdSnd == id)) 
        sndData(data, len);
}

void CPortDlg::dispSndData(const char *a_data, int a_len)
{
    if(a_len > LAST_DATA_LEN_MAX) {
        memcpy(m_lastSndData, a_data + (a_len - LAST_DATA_LEN_MAX), LAST_DATA_LEN_MAX);
        m_lastSndDataLen = LAST_DATA_LEN_MAX;
    }
    else {
        memcpy(m_lastSndData, a_data, a_len);
        m_lastSndDataLen = a_len;
    }
    KillTimer(EVENT_SND_DATA_DISP);
    this->SetTimer(EVENT_SND_DATA_DISP, DISP_LAG, NULL);
}

void CPortDlg::dispRcvData(const char *a_data, int a_len)
{
    if(a_len > LAST_DATA_LEN_MAX) {
        memcpy(m_lastRcvData, a_data + (a_len - LAST_DATA_LEN_MAX), LAST_DATA_LEN_MAX);
        m_lastRcvDataLen = LAST_DATA_LEN_MAX;
    }
    else {
        memcpy(m_lastRcvData, a_data, a_len);
        m_lastRcvDataLen = a_len;
    }
    KillTimer(EVENT_RCV_DATA_DISP);
    this->SetTimer(EVENT_RCV_DATA_DISP, DISP_LAG, NULL);

}

void CPortDlg::OnTimer(UINT_PTR nIDEvent)
{
    CString str, tmp;
    switch(nIDEvent) {
        case EVENT_SND_DATA_DISP:
            KillTimer(EVENT_SND_DATA_DISP);
            for(int i = 0; i < m_lastSndDataLen; i++) {
                if(i == m_lastSndDataLen-1) 
                    tmp.Format("%02X", ((const unsigned char *)m_lastSndData)[i]);
                else
                    tmp.Format("%02X,", ((const unsigned char *)m_lastSndData)[i]);
                str = str + tmp;
            }
            m_edit_send.SetWindowText(str);
            break;
        case EVENT_RCV_DATA_DISP:
            KillTimer(EVENT_RCV_DATA_DISP);
            for(int i = 0; i < m_lastRcvDataLen; i++) {
                if(i == m_lastRcvDataLen-1) 
                    tmp.Format("%02X", ((const unsigned char *)m_lastRcvData)[i]);
                else
                    tmp.Format("%02X,", ((const unsigned char *)m_lastRcvData)[i]);
                str = str + tmp;
            }
            m_edit_receive.SetWindowText(str);
            break;
        default:
        CDialog::OnTimer(nIDEvent);
    }
}
