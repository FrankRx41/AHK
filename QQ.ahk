;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; AHK�汾��		1.0.48.5
; ���ԣ�		����
; ����ƽ̨��	WinXp/NT
; ���ߣ�		���� <healthlolicon@gmail.com>
; �ű����ͣ�
; �ű����ܣ�	��ֹ����QQ��ʹ��QQ
;
; ��֪ȱ�ݣ�
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#NoEnv
#Persistent
#SingleInstance off
#NoTrayIcon
;~ #Include, I:\AutoHotKey\Lib\
SendMode Input
SetWorkingDir %A_ScriptDir%
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DefaultQQ=407498134	;;;;;;�˴�������Ĭ��QQ��
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
run "C:\Program Files\Tencent\QQ2010\Bin\QQ.exe", , , NewPID	;������2010��QQ·��
SetTimer,checkQQnum,500
SetTimer,ExitApp,60000
Return

checkQQnum:
WinWait, ahk_class TXGuiFoundation ahk_pid %NewPID%
WinGet, NewHWND, ID, ahk_class TXGuiFoundation ahk_pid %NewPID%
WinGet, control_list, ControlList, ahk_class TXGuiFoundation ahk_pid %NewPID%
Loop, parse, control_list, `n
{
        If (A_LoopField <> "Edit1")
			QQnum = %A_LoopField%
}
ControlGetText,qq,%QQnum%,ahk_id %NewHWND%
IfNotInString,DefaultQQ,%qq%
{
Process,close,%NewPID%
SetTimer,exit,2500
MsgBox,16,Oops!,��ʹ��[��ѶQQ08]
run "C:\Program Files\Tencent\QQ\QQ.exe"						;08��QQ·�������ޣ���մ���
ExitApp
}
Return

exit:
run "C:\Program Files\Tencent\QQ\QQ.exe"						;08��QQ·�������ޣ���մ���
exitapp:
ExitApp
Return