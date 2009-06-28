; CLW ファイルは MFC ClassWizard の情報を含んでいます。

[General Info]
Version=1
LastClass=CCommRelayDlg
LastTemplate=CDialog
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "CommRelay.h"

ClassCount=7
Class1=CCommRelayApp
Class2=CCommRelayDlg
Class3=CAboutDlg

ResourceCount=7
Resource1=IDD_DIALOG_UDP
Resource2=IDR_MAINFRAME
Resource3=IDD_COMMRELAY_DIALOG
Class4=CTcpDlg
Resource4=IDD_ABOUTBOX
Class5=CTcpClientDlg
Resource5=IDD_DIALOG_TCP_CLIENT
Class6=CUdpDlg
Resource6=IDD_DIALOG_TCP
Class7=CDlgComm
Resource7=IDD_DIALOG_COMM

[CLS:CCommRelayApp]
Type=0
HeaderFile=CommRelay.h
ImplementationFile=CommRelay.cpp
Filter=N

[CLS:CCommRelayDlg]
Type=0
HeaderFile=CommRelayDlg.h
ImplementationFile=CommRelayDlg.cpp
Filter=W
LastObject=IDC_RICHEDIT_LOG
BaseClass=CDialog
VirtualFilter=dWC

[CLS:CAboutDlg]
Type=0
HeaderFile=CommRelayDlg.h
ImplementationFile=CommRelayDlg.cpp
Filter=D

[DLG:IDD_ABOUTBOX]
Type=1
Class=CAboutDlg
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889

[DLG:IDD_COMMRELAY_DIALOG]
Type=1
Class=CCommRelayDlg
ControlCount=14
Control1=IDC_LIST_PORT,listbox,1352728835
Control2=IDC_BUTTON_ADD_TCP_CLIENT_PORT,button,1342242816
Control3=IDC_BUTTON_ADD_TCP_PORT,button,1342242816
Control4=IDC_BUTTON_ADD_UDP_PORT,button,1342242816
Control5=IDC_BUTTON_COM,button,1342242817
Control6=IDC_EDIT_FILE,edit,1350631552
Control7=IDC_BUTTON_FILE,button,1342242816
Control8=IDC_CHECK_FILE,button,1342242819
Control9=IDC_CHECK_LOG,button,1342242819
Control10=IDC_BUTTON_LOG_CLEAR,button,1342242816
Control11=IDC_STATIC,static,1342308352
Control12=IDC_STATIC,static,1342308352
Control13=IDC_STATIC,static,1342308352
Control14=IDC_RICHEDIT_LOG,RICHEDIT,1353783748

[DLG:IDD_DIALOG_TCP]
Type=1
Class=CTcpDlg
ControlCount=18
Control1=IDC_STATIC,static,1342308352
Control2=IDC_STATIC,static,1342308352
Control3=IDC_STATIC,static,1342308352
Control4=IDC_STATIC,static,1342308352
Control5=IDC_EDIT_PORT,edit,1350631552
Control6=IDC_BUTTON_CLOSE,button,1476460544
Control7=IDC_EDIT_STATUS,edit,1350633600
Control8=IDC_EDIT_RECEIVE,edit,1350633600
Control9=IDC_EDIT_SEND,edit,1350631552
Control10=IDC_BUTTON_SEND,button,1476461057
Control11=IDC_STATIC,static,1342308352
Control12=IDC_STATIC,static,1342308352
Control13=IDC_STATIC,static,1342308352
Control14=IDC_EDIT_RELAY_C,edit,1350631552
Control15=IDC_EDIT_RELAY_SEND,edit,1350631552
Control16=IDC_EDIT_RELAY_RECEIVE,edit,1350631552
Control17=IDC_CHECK_LISTEN,button,1342242819
Control18=IDC_STATIC,button,1342177287

[CLS:CTcpDlg]
Type=0
HeaderFile=TcpDlg.h
ImplementationFile=TcpDlg.cpp
BaseClass=CDialog
Filter=D
VirtualFilter=dWC
LastObject=IDC_CHECK_LISTEN

[DLG:IDD_DIALOG_TCP_CLIENT]
Type=1
Class=CTcpClientDlg
ControlCount=19
Control1=IDC_EDIT_PORT,edit,1350631552
Control2=IDC_STATIC,static,1342308352
Control3=IDC_STATIC,static,1342308352
Control4=IDC_STATIC,static,1342308352
Control5=IDC_CHECK_CONNECT,button,1342242819
Control6=IDC_EDIT_HOST,edit,1350631552
Control7=IDC_EDIT_STATUS,edit,1350633600
Control8=IDC_STATIC,static,1342308352
Control9=IDC_STATIC,static,1342308352
Control10=IDC_STATIC,static,1342308352
Control11=IDC_EDIT_CONNECT_LINK,edit,1350631552
Control12=IDC_EDIT_SEND_LINK,edit,1350631552
Control13=IDC_EDIT_RECEIVE_LINK,edit,1350631552
Control14=IDC_STATIC,button,1342177287
Control15=IDC_STATIC,static,1342308352
Control16=IDC_EDIT_SEND,edit,1350631552
Control17=IDC_BUTTON_SEND,button,1476460545
Control18=IDC_STATIC,static,1342308352
Control19=IDC_EDIT_RECEIVE,edit,1350633600

[CLS:CTcpClientDlg]
Type=0
HeaderFile=TcpClientDlg.h
ImplementationFile=TcpClientDlg.cpp
BaseClass=CDialog
Filter=D
VirtualFilter=dWC
LastObject=CTcpClientDlg

[DLG:IDD_DIALOG_UDP]
Type=1
Class=CUdpDlg
ControlCount=19
Control1=IDC_STATIC,static,1342308352
Control2=IDC_STATIC,static,1342308352
Control3=IDC_STATIC,static,1342308352
Control4=IDC_EDIT_DEST_HOST,edit,1350631552
Control5=IDC_EDIT_DEST_PORT,edit,1350631552
Control6=IDC_EDIT_OWN_PORT,edit,1350631552
Control7=IDC_CHECK_BIND,button,1342242819
Control8=IDC_STATIC,button,1342177287
Control9=IDC_STATIC,static,1342308352
Control10=IDC_STATIC,static,1342308352
Control11=IDC_EDIT_SEND_LINK,edit,1350631552
Control12=IDC_EDIT_RECEIVE_LINK,edit,1350631552
Control13=IDC_STATIC,static,1342308352
Control14=IDC_EDIT_SEND,edit,1350631552
Control15=IDC_BUTTON_SEND,button,1342242817
Control16=IDC_STATIC,static,1342308352
Control17=IDC_EDIT_RECEIVE,edit,1350633600
Control18=IDC_STATIC,static,1342308352
Control19=IDC_EDIT_OWN_ADDR,edit,1350631552

[CLS:CUdpDlg]
Type=0
HeaderFile=UdpDlg.h
ImplementationFile=UdpDlg.cpp
BaseClass=CDialog
Filter=D
VirtualFilter=dWC
LastObject=CUdpDlg

[DLG:IDD_DIALOG_COMM]
Type=1
Class=CDlgComm
ControlCount=15
Control1=IDC_CHECK_CONNECT,button,1342242819
Control2=IDC_EDIT_PORT,edit,1350631552
Control3=IDC_STATIC,static,1342308352
Control4=IDC_STATIC,static,1342308352
Control5=IDC_EDIT_CONFIG,edit,1350631552
Control6=IDC_STATIC,static,1342308352
Control7=IDC_STATIC,static,1342308352
Control8=IDC_EDIT_SEND,edit,1350631552
Control9=IDC_EDIT_RECEIVE,edit,1350633600
Control10=IDC_BUTTON_SEND,button,1476460545
Control11=IDC_STATIC,button,1342177287
Control12=IDC_STATIC,static,1342308352
Control13=IDC_STATIC,static,1342308352
Control14=IDC_EDIT_SEND_LINK,edit,1350631552
Control15=IDC_EDIT_RECEIVE_LINK,edit,1350631552

[CLS:CDlgComm]
Type=0
HeaderFile=DlgComm.h
ImplementationFile=DlgComm.cpp
BaseClass=CDialog
Filter=D
VirtualFilter=dWC
LastObject=IDC_EDIT_SEND_LINK

