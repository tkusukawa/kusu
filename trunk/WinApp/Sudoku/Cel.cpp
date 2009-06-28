#include "stdafx.h"
#include "Cel.h"
#include "Sudoku.h"
#include "SudokuDlg.h"
#include ".\sudokudlg.h"

int Cel::sm_try = 0;

// セルのコンストラクタ
Cel::Cel()
{
    m_grpNum = 0;
    m_stat = eNone;
    m_ctrl = NULL;
    for(int i=0; i<3; i++) {
        m_grp[i] = NULL;
    }
    clr();
}

void Cel::init(int line, int row, CEdit *ctrl)
{
    m_line = line;
    m_row = row;
    m_ctrl = ctrl;
}

void Cel::setGrp(Grp *g)
{
    if(m_grpNum >= 3) {
        dbg("Cel::setGrp over (%d,%d)\n", m_line, m_row);
        MessageBox(NULL, "Cel::setGrp over", "error", MB_OK);
        exit(1);
    }
    m_grp[m_grpNum++] = g;
}

// ret=1:要再計算, 0:OK, -1:矛盾あり
int Cel::changeEdit()
{
    char str[3];
    ECelStat lastStat;

    lastStat = m_stat;

    m_ctrl->Invalidate();
    m_ctrl->GetWindowText(str, 3);

    if(str[0] == '\0') {
        dbg("null[%d,%d]\n", m_line, m_row);
        if(m_stat != eNone) {
            m_stat = eNone; 
            return 1;
        }
        return 0;
    }
    else if(str[1] != '\0') {
        // 入力が2文字以上の場合
        dbg("str[%d,%d]=<%s>\n", m_line, m_row, str);
        m_ctrl->SetSel(0,10);
        MessageBeep(MB_OK);
        m_stat = eErr;
        return 0;
    }
    else if(str[0] < '1' || str[0] > '9') {
        dbg("notNum[%d,%d]=<%s>\n", m_line, m_row, str);
        m_ctrl->SetSel(0,10);
        MessageBeep(MB_OK);
        m_stat = eErr;
        return 0;
    }

    dbg("num[%d,%d]=<%s>\n", m_line, m_row, str);

    m_stat = eSet;
    m_num = str[0] - '1';
    m_flg[m_num] = 1;

    if(lastStat != eNone) {
        return 1;
    }

    if(numFix(m_num)) {
        dbg("err cel[%d,%d].numFix(%d)\n", m_line, m_row, m_num+1);
        m_ctrl->SetSel(0,10);
        MessageBeep(MB_OK);
        m_stat = eErr;
        return -1;
    }

    return 0;
}

int Cel::numFix(int a_num)
{
    char str[2];
//dbg("Cel[%d,%d]::numFix(%d) stat=%d\n", m_line, m_row, a_num+1, m_stat);

    if(m_stat != eSet) {
        m_stat = eFix;
        if(sm_try == 0) {
            str[0] = '1' + a_num;
            str[1] = '\0';
            m_ctrl->SetWindowText(str);
            m_ctrl->Invalidate();
        }
    }

    if(m_flg[a_num] == 0) {
        // フラグが立っていない数値が入力された場合
        dbg("ERR:no flg\n");
        return -1; // 矛盾あり
    }

    m_num = a_num;
    // 入力された値以外のフラグを落とす
    for(int i=0; i<9; i++) {
        if(i != a_num) {
            m_flg[i] = 0;
        }
    }
    
    // グループに対して値のFIXを通知する
    for(int i=0; i<3; i++) {
        if(m_grp[i] != NULL) {
            if(m_grp[i]->numFix(this, m_num)) {
                return -1;
            }
        }
    }

    return 0;
}

int Cel::clrFlg(int a_num)
{
    int i, last, cnt;

    if(m_flg[a_num] == 0)
        return 0;

//dbg("Cel[%d,%d]::clrFlg(%d)\n", m_line, m_row, a_num+1);
    if(m_stat != eNone) {
        // すでに値が決まっていたら矛盾チェックのみ
        if(a_num == m_num)
            return -1;
        else
            return 0;
    }

    m_flg[a_num] = 0;

    cnt=0;
    for(i=0; i<9; i++) {
        if(m_flg[i]) {
            cnt ++;
            last = i;
        }
    }

    if(cnt == 0)
        return -1;
    if(cnt == 1)
        return numFix(last);

    // グループのフラグチェックを行う
    for(int i=0; i<m_grpNum; i++) {
        if(m_grp[i]->m_checkFlgNumNext == m_grp[i]) {
            // チェックリストに加わっていなければ
            // チェックリストに追加
            m_grp[i]->m_checkFlgNumNext = Grp::sm_checkFlgNumList;
            Grp::sm_checkFlgNumList = m_grp[i];
        }
    }
    return 0;
}

void Cel::clr()
{
    int i;
    if(m_stat != eSet) {
        m_stat = eNone;  
        for(i=0; i<9; i++) {
            m_flg[i] = 1;
        }
        if(m_ctrl != NULL) {
            m_ctrl->SetWindowText("");
        }
    }
}

