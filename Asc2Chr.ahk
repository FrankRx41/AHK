;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; AHK�汾��		1.0.48.5
; ���ԣ�		����
; ����ƽ̨��	WinXp/NT
; ���ߣ�		���� <healthlolicon@gmail.com>
; �ű����ͣ�
; �ű����ܣ�
;
; ��֪ȱ�ݣ�
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;~ #Include D:\Backup\�ҵ��ĵ�\AutoHotkey\Lib\
Gui, Add, Edit, x6 y11 w240 h180 gTypeIn vInput,
Gui, Add, Edit, x6 y211 w240 h180 gTypeOut vOutput,
; Generated using SmartGUI Creator 4.0
Gui, Show,, Asc & Chr
GuiControlGet,hwnd,hwnd,input
Return

GuiClose:
ExitApp

TypeIn:
GuiControlGet,Input
StringReplace,Input,input,%a_space%,,all
string1=
Loop
{
	if strlen(input)=0
		break
	StringLeft,ascword,input,2
	StringTrimLeft,input,input,2
	chrword:=chr("0x" . ascword)
	string1:=string1 . chrword
}
GuiControl,,Output,%string1%
Return

TypeOut:
GuiControlGet,Output
String2=
Loop,Parse,Output
{
	ascword:=asc(A_LoopField)
	SetFormat, INTEGER,H
	ascword+=0
	SetFormat, INTEGER,D
	StringTrimLeft,ascword,ascword,2
	if strlen(ascword)=1
		ascword:="0" . ascword
	StringUpper,ascword,ascword
	string2:=string2 . a_space . ascword
}
StringTrimLeft,string2,string2,1
GuiControl,,input,%string2%
ControlSend,,^{end},ahk_id %hwnd%
Return