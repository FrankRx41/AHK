;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; AHK�汾��		1.0.48.5
; ���ԣ�		����
; ����ƽ̨��	WinXp/NT
; ���ߣ�		���� <healthlolicon@gmail.com>
; �ű����ͣ�	����
; �ű����ܣ�	�������
;
; ��֪ȱ�ݣ�	ctrl+l������꣬ctrl+q�����������
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#Persistent
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
;~ Menu, Tray, NoStandard

Gosub,Lock
Return

Lock:
^l::
BlockInput,MouseMove
CustomColor = EEAA99 ; �������κ� RGB ֵ���������ں����͸������
Gui +LastFound +AlwaysOnTop -Caption +ToolWindow ; +ToolWindow ���Ա�������������ʾ��ť�����Ҳ�������� alt-tab �˵���
Gui, Color, %CustomColor%
Gui, Font, s32 ; ѡ��32������
Gui, Add, Text, cLime, �� �� �� �� ״ ̬ ; XX & YY ���������ô����Զ�������С
; ʹָ����ɫ�����ر��͸��������ʹ���屾��͸����Ϊ150
WinSet, TransColor, %CustomColor% 150
YY:=A_ScreenHeight/2
XX:=A_ScreenWidth/2-200
Gui, Show, x%XX% y%YY% NoActivate ; ����������ı䵱ǰ����Ĵ���
Return

^q::
InputBox,password,%A_Space%,%A_Space%,HIDE,250,120
If password = password
{
	BlockInput,MouseMoveOff
	Gui, destroy
	}
Else if password = exitapp
	ExitApp
Return

$SC15B::
Return

~r::
if A_PriorHotkey=$SC15B
	if A_TimeSincePriorHotkey<1000
		send,#r
Return
