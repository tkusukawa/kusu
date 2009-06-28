
enum ECelStat {
    eNone = 0,
    eSet = 1,
    eFix = 2,
    eErr = -1
};


class Cel
{
public:
    Cel();

    void init(int line, int row, CEdit *ctrl);
    void setGrp(class Grp *g);
    int changeEdit();
    void clr();

    int clrFlg(int num);
    int numFix(int num);

    int m_line, m_row;

    CEdit *m_ctrl;
    ECelStat m_stat;

    int m_num;
    char   m_flg[9];

    int m_grpNum;
    class Grp *m_grp[3];

    static int sm_try;
};

class Grp
{
public:
    Grp();

    void init(char *name,
        Cel *cel1,
        Cel *cel2,
        Cel *cel3,
        Cel *cel4,
        Cel *cel5,
        Cel *cel6,
        Cel *cel7,
        Cel *cel8,
        Cel *cel9);

    void clr();
    int  numFix(Cel *cel, int num); // 値がFIXしたことをグループに通知する
    static int  checkFlgAll();

    Grp *m_checkFlgNumNext;
    static Grp *sm_checkFlgNumList;

protected:
    int  checkFlgNum();

    char m_name[16];
    Cel *m_cel[9];
    int m_remCnt[9];
    Cel *m_remCntLast[9];

};

struct GrpCntList {
    Grp *grp;
    int count;
    int total;
    GrpCntList *next;
};
