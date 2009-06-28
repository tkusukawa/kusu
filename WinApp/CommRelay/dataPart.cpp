
#include "stdafx.h"
#include "dataPart.h"


int setDataPart(UCHAR *tgtData, int offset, int len, UCHAR *setData)
{
    int  i, bytePos, bitPos, byteLen, bitLen;
    unsigned char pByte, nByte;
    
    bitPos = offset % 8;
    bytePos = (offset - bitPos) / 8;

    bitLen = len % 8;
    byteLen = (len - bitLen) / 8;

    for(i = 0; i < byteLen; i++) {
        pByte = tgtData[bytePos + i];
        pByte &= (0xFF00 >> bitPos);
        pByte |= (setData[i] >> bitPos);
        tgtData[bytePos + i] = pByte;

        if(bitPos) {
            nByte = tgtData[bytePos + i + 1];
            nByte &= (0x00FF >> bitPos);
            nByte |= (setData[i] << (8-bitPos));
            tgtData[bytePos + i + 1] = nByte;
        }
    }

    if(bitLen) {
        pByte = tgtData[bytePos + i];
        pByte &= (0xFF00 >> bitPos) | (0xFF >> (bitPos+bitLen));
        pByte |= ((setData[i] & (0xFF00 >> bitLen)) >> bitPos);
        tgtData[bytePos + i] = pByte;

        if(bitPos + bitLen > 8) {
            nByte = tgtData[bytePos + i + 1];
            nByte &= (0x00FF >> (bitPos+bitLen-8));
            nByte |= ((setData[i] & (0xFF00 >> bitLen)) << (8-bitPos));
            tgtData[bytePos + i + 1] = nByte;
        }
        i ++;
    }

    return i;
}

int getDataPart(UCHAR *tgtData, int offset, int len, UCHAR *getData)
{
    int  i, bytePos, bitPos, byteLen, bitLen;
    unsigned char pByte, nByte;

    bitPos = offset % 8;
    bytePos = (offset - bitPos) / 8;

    bitLen = len % 8;
    byteLen = (len - bitLen) / 8;

    for(i = 0; i < byteLen; i++) {
        pByte = tgtData[bytePos + i];
        nByte = tgtData[bytePos + i + 1];

        getData[i] = (pByte << bitPos) | (nByte >> (8-bitPos));
    }
    if(bitLen) {
        pByte = tgtData[bytePos + i];
        nByte = tgtData[bytePos + i + 1];
        getData[i] = (pByte << bitPos) | (nByte >> (8-bitPos));
        getData[i] &= 0xFF << (8 - bitLen);
        i++;
    }

    return i; // 取得したデータのバイト数を返す
}

int setDataPartR(UCHAR *tgtData, int offset, int len, UCHAR *setData)
{
    UCHAR tmp[4096];

    tmp[(len+7)/8] = 0;
    getDataPart(setData, 7 - ((len-1) % 8), len, tmp);
    return setDataPart(tgtData, offset, len, tmp);
}

int getDataPartR(UCHAR *tgtData, int offset, int len, UCHAR *getData)
{
    UCHAR tmp[4096];
    int byteLen;

    byteLen = getDataPart(tgtData, offset, len, tmp);
    getData[0] = 0;
    setDataPart(getData, 7 -((len-1) % 8), len, tmp);
    return byteLen;
}

int setDataPartM(UCHAR *tgtData, int offset, int len, UCHAR *setData)
{
    UCHAR tmp[4096];

    getDataPart(setData, 7 - ((offset + 7) % 8), len, tmp);
    setDataPart(tgtData, offset, len, tmp);

    return ((offset + len - 1) / 8) - offset / 8 + 1;
}

int getDataPartM(UCHAR *tgtData, int offset, int len, UCHAR *getData)
{
    UCHAR tmp[4096];
    int byteLen;

    byteLen = ((offset + len - 1) / 8) - offset / 8 + 1;

    getDataPart(tgtData, offset, len, tmp);
    memset(getData, 0, byteLen);
    setDataPart(getData, 7 - ((offset + 7) % 8), len, tmp);
    return byteLen;
}


int csh2bin(const char *text, UCHAR *data)
{
    int i, pos;
    char c;

    pos = 0;
    data[pos] = 0;
    for(i = 0; i < 4096; i++) {
        c = text[i];
        if(c == '\0') break;

        if(c >= '0' && c <= '9') {
            data[pos] <<= 4;
            data[pos] += c - '0';
        }
        else if(c >= 'A' && c <= 'F') {
            data[pos] <<= 4;
            data[pos] += 10 + c - 'A';
        }
        else if(c >= 'a' && c <= 'f') {
            data[pos] <<= 4;
            data[pos] += 10 + c - 'a';
        }
        else if(c == ',') { 
            pos++;
            data[pos] = 0;
        }
        else {
            pos ++;
            break;
        }
    }
    pos ++;

    return pos;
}

int bin2csh(char *text, const UCHAR *data, int len)
{
    int i, pos, side;
    char c;
    
    pos = 0;
    for(i = 0; i < len; i++) {
        for(side = 1; side >=0; side --) {
            c = (data[i] >> (4*side)) & 0xF;
            if(c < 10)
                c += '0';
            else
                c += 'A' - 10;

            text[pos ++] = c;
        }
        if(i+1 != len)
            text[pos ++] = ',';
    }
    text[pos] = '\0';
    return i;
}

