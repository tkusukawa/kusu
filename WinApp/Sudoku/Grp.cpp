// Grp.cpp

#include "stdafx.h"
#include "Cel.h"
#include "Sudoku.h"
#include "SudokuDlg.h"
#include ".\sudokudlg.h"

Grp *Grp::sm_checkFlgNumList;

// グループのコンストラクタ
Grp::Grp()
{
    clr();
}

void Grp::init(char *name,
               Cel *cel1,
               Cel *cel2,
               Cel *cel3,
               Cel *cel4,
               Cel *cel5,
               Cel *cel6,
               Cel *cel7,
               Cel *cel8,
               Cel *cel9)
{
    strncpy(m_name, name, 8);
    m_cel[0] = cel1;
    m_cel[1] = cel2;
    m_cel[2] = cel3;
    m_cel[3] = cel4;
    m_cel[4] = cel5;
    m_cel[5] = cel6;
    m_cel[6] = cel7;
    m_cel[7] = cel8;
    m_cel[8] = cel9;

    for(int i=0; i<9; i++) {
        m_cel[i]->setGrp(this);
    }
}

void Grp::clr()
{
    for(int i=0; i<9; i++) {
        m_remCnt[i] = 9;
    }
    m_checkFlgNumNext = this;
    sm_checkFlgNumList = NULL;
}

int Grp::numFix(Cel *cel, int num)
{
    int i;

//    dbg("Grp%s::numFix(%d)\n", m_name, num+1);

    for(i=0; i<9; i++) {
        if(m_cel[i] == cel) 
            continue; // 要求した本人はチェック不要

        if(m_cel[i]->m_stat != eNone) {
            // すでに値が決定していたセルの場合
            if(m_cel[i]->m_num == num) {
                dbg("cel[%d,%d] has same num\n", m_cel[i]->m_line, m_cel[i]->m_row);
                return -1; // 値が同じ場合は矛盾
            }
        }
        if(m_cel[i]->clrFlg(num))
            return -1;
    }

    return 0;
}

int Grp::checkFlgAll()
{
    Grp *grp;

//dbg("checkFlgAll\n");
    while(sm_checkFlgNumList != NULL) {
        grp = sm_checkFlgNumList;
        sm_checkFlgNumList = grp->m_checkFlgNumNext;
        grp->m_checkFlgNumNext = grp;
        if(sm_checkFlgNumList == grp) {
            dbg("Grp::checkFlgAll list error Grp%s\n", grp->m_name);
            exit(1);
        }

        if(grp->checkFlgNum())
            return -1;
    }
    return 0;
}

int Grp::checkFlgNum()
{
    int i,j;

//dbg("Grp%s::checkFlgNum()\n", m_name);

    // カウンタクリア
    for(j=0; j<9; j++) {
        m_remCnt[j] = 0; // 0クリア
        m_remCntLast[j] = NULL;
    }

    // カウンタ再計算
    for(i=0; i<9; i++) {
        for(j=0; j<9; j++) {
            if(m_cel[i]->m_flg[j]) {
                m_remCnt[j] ++;
                m_remCntLast[j] = m_cel[i];
            }
        }
    }

    // このグループ内での各値の存在可能数を確認
    for(j=0; j<9; j++) {
        if(m_remCnt[j] == 0) { // 1つも無いのはおかしい（各値は必ず１つある）
            dbg("ERR:grp cnt[%d] == 0\n", j);
            return -1; // 矛盾
        }
        if(m_remCnt[j] == 1) {
            // フラグが残りひとつになったら決定
            if(m_remCntLast[j]->m_stat == eNone) {
                // まだ決定していないセルの場合はFix処理を行う
                dbg("Grp%s::LastOne[%d]->cel[%d,%d]\n", m_name, j+1, m_remCntLast[j]->m_line, m_remCntLast[j]->m_row);
                if(m_remCntLast[j]->numFix(j))
                    return -1; // 矛盾があった場合はリターン
            }
        }
    }

    return 0; // 矛盾なし
} 


