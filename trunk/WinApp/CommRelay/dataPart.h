#ifndef DATA_PART_H
#define DATA_PART_H

int setDataPart(UCHAR *tgtData, int offset, int len, UCHAR *setData);
int getDataPart(UCHAR *tgtData, int offset, int len, UCHAR *getData);

int setDataPartR(UCHAR *tgtData, int offset, int len, UCHAR *setData);
int getDataPartR(UCHAR *tgtData, int offset, int len, UCHAR *getData);

int setDataPartM(UCHAR *tgtData, int offset, int len, UCHAR *setData);
int getDataPartM(UCHAR *tgtData, int offset, int len, UCHAR *getData);

int csh2bin(const char *text, UCHAR *data);
int bin2csh(char *text, const UCHAR *data, int byteLen);

#endif // DATA_PART_H