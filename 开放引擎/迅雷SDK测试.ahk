;
; AHK�汾: 		B:1.0.48.5 L:1.0.92.0
; ����:			����/English
; ƽ̨:			Win7
; ����:			���� <healthlolicon@gmail.com>
;
;
;
;

#NoEnv
#NoTrayIcon
SendMode Input
SetWorkingDir %A_ScriptDir%  ;
#Include CodeXchange.ahk
#include Link.ahk


;#Default
XL_ERROR_FAIL=0x10000000
XL_ERROR_FILE_DONT_EXIST:=XL_ERROR_FAIL+17		;�ļ�������
XL_ERROR_UNSPORTED_PROTOCOL:=XL_ERROR_FAIL+2	;��֧�ֵ�Э��


Status=����δ��ʼ
Percent=0
Gui, Add, Text, x12 y20 w310 h30 , ���ز��ԣ�Ѹ�׿ͻ��ˣ�17.4M��
Gui, Add, Text, x12 y20 w310 h30 vStatusText, ״̬��%Status%
Gui, Add, Progress, x12 y90 w300 h30 vMyProgress, 0
Gui, Add, Text, x313 y98 w25 h30 vPercentText, %Percent%`%
Gui, Add, Button, x342 y20 w60 h30 gDownLoad, ����
Gui, Add, Button, x412 y90 w60 h30 gStop, ȡ��
Gui, Add, Button, x412 y20 w60 h30 gPause, ��ͣ
Gui, Add, Button, x342 y90 w60 h30 gContinue, �ָ�
Gui, Add, Button, x342 y140 w130 h30 gDownload_form_tdfile, ����δ��ɵ�����
Gui, Add, Text, x12 y140 w170 h20 vSpeed, �����ٶ�:0 kb/s
Gui,show,,Ѹ��SDK����
trayicon("AutoHotKey.exe",0)
Return

OnExit:
GuiClose:
trayicon("AutoHotKey.exe",1)
if hMoule!=0
	Gosub,Stop
ExitApp

DownLoad:
;����dll
hModule := DllCall("LoadLibrary", "str", "XLDownload.dll")
DllCall("XLDownload\XLInitDownloadEngine")
;;����Ѹ������ͼ��
Sleep,1000
trayicon("AutoHotKey.exe",0)
;����
sUrl:=thunder_url_encode("http://down.sandai.net/thunder7/Thunder7.1.6.2194.exe")
;;ר������ת��
IfInString,sUrl,thunder://
	sUrl:=thunder_url_decode(surl)
Else IfInString,sUrl,flashget://
	sUrl:=flashget_url_decode(surl)
Else IfInString,surl,qqdl://
	surl:=qqdl_url_decode(surl)

sfile=C:\Users\Robin\Desktop\XL.exe
Ansi2Unicode(sUrl, url, 0)
Ansi2Unicode(sFile, File, 0)

DllCall("XLDownload\XLURLDownloadToFile","str",file,"str",URL,"Str",0,"intP",TaskID)
Time_1:=A_TickCount
Download_New=0
SetTimer,Query,1000
Return

;;;��td�ļ�����δ��ɵ�����
Download_form_tdfile:
FileSelectFile,sTdfile,1,%A_ScriptDir%,,Ѹ����ʱ�����ļ�(*.td)
;����dll
hModule := DllCall("LoadLibrary", "str", "XLDownload.dll")
DllCall("XLDownload\XLInitDownloadEngine")
;;����Ѹ������ͼ��
Sleep,1000
trayicon("AutoHotKey.exe",0)

Ansi2Unicode(sTdfile,Tdfile, 0)
rtn:=DllCall("XLDownload\XLContinueTaskFromTdFile","str",tdfile,"intP",TaskID)
if (rtn=XL_ERROR_FILE_DONT_EXIST)
{
	Gosub,stop
	MsgBox,��Ӧ��cfg�ļ�ȱʧ
	Return
}
Else if (rtn=XL_ERROR_UNSPORTED_PROTOCOL)
{
	Gosub,stop
	MsgBox,SDK�汾̫�ͻ�δ��װѸ��
	Return
}
Else if rtn<>0
	Return
Time_1:=A_TickCount
Download_New=0
SetTimer,Query,2000
;����
Return


;��ѯ����
Query:
retn:=DllCall("XLDownload\XLQueryTaskInfo","int",TaskID,"intP",TaskStatus,"Uint64P",FileSize,"Uint64P",RecvSize)
if retn=0
{
	if TaskStatus=0
		Status=�Ѿ���������
	Else if TaskStatus=2
		Status=��ʼ����
	Else if TaskStatus=10
		Status=��ͣ
	Else if TaskStatus=11
	{
		SetTimer,Query,off
		Status=�ɹ�����
		GuiControl,,StatusText,״̬��%Status%
		Goto,Stop
		}
	Else if TaskStatus=12
		Status=����ʧ��
	Else
		Status=δ֪
	}
GuiControl,,StatusText,״̬��%Status%
Download_Old:=Download_New
Download_New:=RecvSize
Time_2:=A_TickCount
Speed:=(Download_New-Download_Old)/(Time_2-Time_1)/1024*1000
Time_1:=Time_2
Percent:=RecvSize*100//FileSize
GuiControl,,Speed,%Speed% KB/s
GuiControl,,PercentText,%Percent%`%
GuiControl,,MyProgress,%Percent%
Return

;��ͣ
Pause:
DllCall("XLDownload\XLPauseTask","int",TaskID,"IntP",NewTaskID)
TaskID:=NewTaskID
Return

;�ָ�
Continue:
SetTimer,Query,1000
DllCall("XLDownload\XLContinueTask","int",TaskID)
Return

;ȡ��
Stop:
SetTimer,Query,off
GuiControl,,StatusText,״̬��ȡ������
GuiControl,,PercentText,0`%
GuiControl,,MyProgress,0
DllCall("XLDownload\XLStopTask","int",TaskID)
DllCall("XLDownload\XLUninitDownloadEngine")
DllCall("FreeLibrary", "UInt", hModule)
Return
