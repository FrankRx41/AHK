#NoTrayIcon
#SingleInstance,Ignore
result:=DllCall("Wininet.dll\InternetGetConnectedState", Str,0x43, Int,0 )
if result
	Goto,Speed
Gosub,UserRead
Gui, Add, Text, x16 y21 w60 h20 , ����˺ţ�
Gui, Add, Edit, x86 y21 w120 h20 vID, %ID%
Gui, Add, Text, x16 y61 w60 h20 , ������룺
Gui, Add, Edit, x86 y61 w120 h20 Password vPassword ,
Gui, Add, CheckBox, x16 y91 w140 h20 vRemeber, ��ס����
Gui, Add, Button, x46 y121 w100 h30 gDial, ����
Gui, Show,h165 w217, �������
if remeber
{
	GuiControl,,Remeber,1
	GuiControl,,Password,%password%
	}
Return

GuiClose:
ExitApp



Dial:
GuiControlGet,ID
GuiControlGet,Password
GuiControlGet,Remeber
Gosub,UserWrite
Gosub,SettingRead
Runwait,%ComSpec% /c "RASDIAL %AdslName% %ID% %Password% >%A_Temp%\New.adsl",,hide,PID
FileRead,Message,%A_Temp%\New.adsl
SplashTextOn,250,120,������...,%Message%
Sleep,1000
Process,Exist,PID
if errorlevel=0
{
	SplashTextOff
	FileDelete,%A_Temp%\New.adsl
	Gui,1:destroy
	Sleep,5000
	SendMail(email_form,email_password,email_server,email_to)
	ExitApp
	}
Return


UserRead:
RegRead,ID,HKLM,Software\AutoAdsl,ID
if errorlevel
	Return
RegRead,Password,HKLM,Software\AutoAdsl,Password
RegRead,remeber,HKLM,Software\AutoAdsl,remeber
Return

UserWrite:
RegWrite,REG_SZ,HKLM,Software\AutoAdsl,ID,%ID%
RegWrite,REG_SZ,HKLM,Software\AutoAdsl,Password,%Password%
RegWrite,REG_SZ,HKLM,Software\AutoAdsl,remeber,%remeber%
Return

SettingRead:
RegRead,AdslName,HKLM,Software\AutoAdsl,AdslName
RegRead,email_form,HKLM,Software\AutoAdsl,email_form
RegRead,email_password,HKLM,Software\AutoAdsl,email_password
RegRead,email_server,HKLM,Software\AutoAdsl,email_server
RegRead,email_to,HKLM,Software\AutoAdsl,email_to
Return

Speed:
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

Gui, 2:Add, GroupBox, x6 y11 w210 h90 , ������
Gui, 2:Add, GroupBox, x6 y111 w210 h90 , ��ǰ����
Gui, 2:Add, Text, x16 y31 w190 vSend, �ѷ���:0(�ֽ�)
Gui, 2:Add, Text, x16 y61 w190  vReceive, �ѽ���:0(�ֽ�)
Gui, 2:Add, Text, x16 y141 w190 vUpload, �ϴ�:0(KB/S)
Gui, 2:Add, Text, x16 y171 w184  vDownload, ����:0(KB/S)
Gui, 2:Show,h227 w226, ����״̬
Gosub,reflesh
SetTimer,reflesh,1000
Return

2Guiclose:
ExitApp
Return

reflesh:
Gosub,watchNetSpeed
SetFormat, float, 0.2
DownSpeedK:=DownSpeed/1024
UpSpeedK:=UpSpeed/1024
Guicontrol,2:,Send,�ѷ���:%dwOutOctets%(�ֽ�)
Guicontrol,2:,receive,�ѽ���:%dwinOctets%(�ֽ�)
Guicontrol,2:,Upload,�ϴ�:%UpSpeedK%(KB/S)
Guicontrol,2:,Download,����:%DownSpeedK%(KB/S)
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

SendMail(from,pass,server,to)
{
	StringSplit,Server_,server,:
	RunWait,%comspec% /c "ipconfig >%A_Temp%\ipconfig.adsl",,Hide
	FileRead,IpAll,%A_Temp%\ipconfig.adsl
	FileDelete,%A_Temp%\ipconfig.adsl
	Pos:=RegExMatch(IPALL,"IP Address",ip)
	Pos++
	Pos:=RegExMatch(IPALL,"IP Address",ip,pos)
	Pos++
	ip=
	RegExMatch(IPALL,"(\d{1,3}\.){3}\d{1,3}",ip,pos)
	IPfile:=chrandom(8)
	FileAppend,%IP%,%A_temp%\%IPfile%.txt
	runwait,%comspec% /c "blat -install %Server_1% %form% AutoSend %Server_2%", ,Hide
	runwait,%comspec% /c "blat %A_temp%\%IPfile%.txt -to %to%  -s "IP" -u %from% -pw %pass%", ,Hide
	FileDelete,%A_temp%\%IPfile%.txt
;~ 	String = -t %to% -s IP��ַ -body %IP% -base64 -f %from% -server %server% -u %from% -p %pass%
;~ 	message:=DllCall("blat.dll\Send", "Str", String)
;~ 	return message
	}