// 起動時の初期化

#include "stdafx.h"
#include "CommRelay.h"
#include "CommRelayDlg.h"
#include <sys/timeb.h>
#include <mmsystem.h>

#pragma comment(lib, "winmm.lib")

void CCommRelayDlg::init()
{
    CRect rc;

    // WINDOWの最小サイズを記録しておく
    GetWindowRect(&rc);
    m_szMin = rc.Size();

    //_ftime(&now);
    //_ftime_s(&now);
    m_startTime = timeGetTime();
    m_portNum = 0;
    //m_check_log.SetCheck(1);

    m_initialized = true;

    GetClientRect(&m_dlgRect);
    m_richedit_log.GetWindowRect(&m_logRect);
    ScreenToClient(&m_logRect);
    m_check_file.EnableWindow(FALSE);
}