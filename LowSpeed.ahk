;�������Զ��ػ�
;
;
;�ο���Ϣ��
;�򵥵�ʵʱ����������ʾ����by wz520
;http://ahk.5d6d.com/viewthread.php?tid=2780
;

#Persistent
#NoEnv

; �򵥵�ʵʱ����������ʾ


;����
dwIndex:=2
Times:=0
Speed=10
Time=10
;���ý���

sizeofIFROW=860
VarSetCapacity(ifrow, sizeofIFROW, 0)
VarSetCapacity(bdescr, 256, 0) ;�������ӵ�˵����Ϣ
NumPut(dwIndex, ifrow, 512)

pGetIfEntry:=DllCall("GetProcAddress", uint
		, hModule := DllCall("LoadLibrary", str, "Iphlpapi")
		, str, "GetIfEntry") ;��ȡ������ַ�������
if(!pGetIfEntry)
{
	MsgBox, ��ȡ Iphlpapi.dll\GetIfEntry ������ַʧ��
	ExitApp, 1
}

OnExit, FreeDll

OlddwInOctets=0
OlddwOutOctets=0
DownSpeed=0
UpSpeed=0

switch=0
menu,tray,NoStandard
menu,tray,add,����,setting
menu,tray,default,����
menu,tray,add,��ʼ,switch
menu,tray,add,�˳�,exit
menu,tray,tip,�������Զ��ػ�
SetWorkingDir %A_ScriptDir%
Gui:
Gui=1
Gui, Add, Text, x6 y10 w50 h20 , ���ٵ���
Gui, Add, Edit,x66 y10 w50 h20 gS,
gui, add, UpDown,Range0-65535 vSpeed,%Speed%
Gui, Add, Text, x126 y10 w40 h20 , (KB/s)
Gui, Add, Text, x6 y40 w50 h20 , ������
Gui, Add, Edit, x66 y40 w50 h20 gT,
gui, add, UpDown,Range0-240 vTime,%Time%
Gui, Add, Text, x126 y40 w40 h20 , (Min)
Gui, Add, CheckBox, x6 y70 w170 h20 gRun vRun, ��������
Gui,+ToolWindow
Gui, Show, w195, �������Զ��ػ�
Return

GuiClose:
Gui,destroy
Gui=0
Return
exit:
ExitApp

Run:
GuiControlGet,Run
if Run
	RegWrite,REG_SZ,HKCU,Software\Microsoft\Windows\CurrentVersion\Run,�������Զ��ػ�,%A_ScriptFullPath%
Else
	RegDelete,HKCU,Software\Microsoft\Windows\CurrentVersion\Run,�������Զ��ػ�
Return

setting:
if Gui=0
	Gosub,gui
Return

S:
GuiControlGet,Speed
Return
T:
GuiControlGet,Time
Return

switch:
menu,tray,ToggleCheck,��ʼ
if switch=0
	SetTimer, SpeedCheck, 1000
Else
	SetTimer, SpeedCheck, off
switch:=!switch
return

SpeedCheck:
Gosub,watchNetSpeed
SetFormat, float, 0.2
SpeedNow:=DownSpeed/1024
menu,tray,tip,�������Զ��ػ�`n��ǰ�ٶȣ�%SpeedNow% KB/s
if (Time=0 && Speed=0)
	Return
if SpeedNow<Speed
{
	Times++
	If Times=1
		FirstTime:=A_Now
	Else
	{
			last:=A_Now
			EnvSub, last, %FirstTime%,Minutes
			if last>=%Time%
				Shutdown, 8
;~ 				MsgBox,�ػ�
	}
}
Else
	Times=0
Return

watchNetSpeed:
	errcode:=DllCall(pGetIfEntry, uint, &ifrow, uint)
	if(errcode!=0)
	{
		SetTimer, watchNetSpeed, Off
		MsgBox, % GetErrorMessage(errcode)
		ExitApp, errcode
	}
	dwInOctets:=NumGet(ifrow,552) ;�ѽ����ֽ�
	dwOutOctets:=NumGet(ifrow,576) ;�ѷ����ֽ�
	if(OlddwInOctets=0 && OlddwOutOctets=0) ;Ϊ�˼���Ƿ��һ�����д�Timer
	{
		;��ȡ����ӿڵ�˵����Ϣ��
		;ò��AHK����ֱ�� ��ַ+ƫ���� ����ַ������������˸�C������
		DllCall( "MSVCRT\strcpy", str, bDescr, uint, (&ifrow)+604 )
	}
	else
	{
		DownSpeed:=dwInOctets-OlddwInOctets
		UpSpeed:=dwOutOctets-OlddwOutOctets
;~ 		ToolTip,
;~ 		(LTrim
;~ 			�������ӣ�%bDescr%
;~ 			�ѽ������ݣ�%dwInOctets% �ֽ�
;~ 			�ѷ������ݣ�%dwOutOctets% �ֽ�
;~ 			�����ٶȣ�%DownSpeed% �ֽ�/��
;~ 			�ϴ��ٶȣ�%UpSpeed% �ֽ�/��
;~ 		)
	}
	OlddwInOctets:=dwInOctets
	OlddwOutOctets:=dwOutOctets
	return

FreeDll:
	DllCall("FreeLibrary", uint, hModule)
	ExitApp

;���ݴ����뷵�ش�����Ϣ��
GetErrorMessage(ErrorCode)
{
  VarSetCapacity(ErrorMsg, 256, 0)

  ;#define FORMAT_MESSAGE_FROM_SYSTEM     0x00001000
  DLLCall("FormatMessage","UInt",0x1000
    ,"UInt",0,"UInt",ErrorCode,"UInt",0,"Str"
    ,ErrorMsg,"Uint", 256, "UInt", 0)

  StringReplace, ErrorMsg, ErrorMsg, `r`n, , All ;ɾ������

  return ErrorMsg
}
