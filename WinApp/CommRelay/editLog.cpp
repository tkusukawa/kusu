// m_richedit_log ÇÃèàóù

#include "stdafx.h"
#include "CommRelay.h"
#include "CommRelayDlg.h"
#include <sys/timeb.h>
#include <io.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <mmsystem.h>

void CCommRelayDlg::printLog(const char *text)
{
    char str[4096];
    long pos, len;

    pos = 0;
    len = strlen(text);

    if(m_logDispCheck == false && m_logFileCheck == false)
        return;

    while(pos < len) {
        if(pos == 0 && text[pos] == '@') {
            DWORD now;
            now = timeGetTime();
            sprintf_s(str, 4096, "%d.%03d", (now-m_startTime)/1000, (now-m_startTime)%1000);
            pos++;
        }
        else {
            int i;
            for(i = 0; i < 127; i++) {
                str[i] = text[pos++];
                if(str[i] == '\0')
                    break;
            }
            str[i] = '\0';
        }

        if(m_logDispCheck) {
            long s,e;

            m_richedit_log.SetSel(100000,100000);
            m_richedit_log.GetSel(s, e);
            if(s > 90000) {
                m_richedit_log.SetRedraw(FALSE);
                m_richedit_log.SetSel(0, s-90000);
                m_richedit_log.ReplaceSel("");
                m_richedit_log.SetSel(100000,100000);
                m_richedit_log.SetRedraw(TRUE);
            }

            m_richedit_log.ReplaceSel(str);
            m_richedit_log.SetSel(100000,100000);
        }

        if(m_logFileCheck) {
            FILE *fp;
            errno_t err = fopen_s(&fp, m_logFileName, "ab");
            if(err == 0) {
                fwrite(str, strlen(str), 1, fp);
                fclose(fp);
            }
        }
    }
}

void CCommRelayDlg::OnButtonLogClear() 
{
	m_richedit_log.SetWindowText("");
}

