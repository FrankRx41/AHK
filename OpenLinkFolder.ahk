;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; AHK�汾��		1.0.48.5(www.autohotkey.com)
; ���ԣ�		����/Chinese
; ����ƽ̨��	WinXp/NT
; ���ߣ�		���� <healthlolicon@gmail.com>
; �ű����ͣ�	���
; �ű����ܣ�	�򿪿�ݷ�ʽ����Ŀ¼-�Ҽ��˵�/Open Shotcut's Folder via Context Menu
; ע�����
; ��֪ȱ�ݣ�
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#NoEnv
#NoTrayIcon
#SingleInstance off
SendMode Input
SetWorkingDir %A_ScriptDir%

if 1=
goto,Gui
FileGetShortcut,%1%,,dir
run,`"%dir%`"
exitapp

Gui:
Gui, Add, Button, x16 y11 w130 h30 gInstall, ��װ(Install)
Gui, Add, Button, x16 y61 w130 h30 gUnInstall, ж��(Uninstall)
Gui, Show, x319 y138 h109 w166, O
Return

GuiClose:
ExitApp

Install:
If A_IsCompiled
	command = `"%A_ScriptFullPath%`" `"`%1`"
Else
	command = `"%A_AhkPath%`" `"%A_ScriptFullPath%`" `"`%1`"
RegWrite,REG_SZ,HKCR,lnkfile\shell\OpenFolder,, ��Ŀ¼
RegWrite,REG_SZ,HKCR,lnkfile\shell\OpenFolder\Command,,%command%
Return

UnInstall:
RegDelete,HKCR,lnkfile\shell
return