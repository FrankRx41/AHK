;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; AHK�汾��		1.0.48.5
; ���ԣ�		����
; ����ƽ̨��	WinXp/NT
; ���ߣ�		���� <healthlolicon@gmail.com>
; �ű����ͣ�	���
; �ű����ܣ�	���Լ���ָʾ�ƣ�����Ļ������ʾCaps��Scroll��Num��״̬��
;				For �װ����߼������Լ�����������ָʾ���û���
; ��֪ȱ�ݣ�
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#Persistent
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
Menu, Tray, NoStandard
Menu, Tray, Add,����,email
Menu, Tray, Add,����,setting
Menu, Tray, Add,�˳�,exit
Menu, Tray, Tip, ���Լ���ָʾ��(LockTip)
;~ Menu, Tray, Add,reload,reload
;------------------------------------------------------------------
Gosub,iniread
pos:
If pos=1						;�I
{
	posx := -30
	posy :=
	checked = ����
	}
Else If pos=2					;�J
{
	posx :=A_ScreenWidth - 170
	posy :=
	checked = ����
	}
Else If pos=3					;�L
{
	posx := -30
	posy :=A_ScreenHeight - 120
	checked = ����
	}
Else If pos=4					;�K
{
	posx :=A_ScreenWidth - 170
	posy :=A_ScreenHeight - 120
	checked = ����
	}
Color:
Colorhex =0x%Color%
SetFormat, INTEGER, H
CustomColor := Colorhex-1 ; �������κ� RGB ֵ���������ں����͸������
SetFormat, INTEGER, D
Gui +LastFound +AlwaysOnTop -Caption +ToolWindow ; +ToolWindow ���Ա�������������ʾ��ť�����Ҳ�������� alt-tab �˵���
Gui, Color, %CustomColor%
Gui, Font, s32 ; ѡ��32������
Gui, Add, Text, vNum_Lock c%Color%, ��
GetKeyState,Lock,NumLock,T
If Lock=D
	GuiControl,,Num_Lock,��
Gui, Add, Text, xp+40 vCaps_Lock c%Color%, ��
GetKeyState,Lock,CapsLock,T
If Lock=D
	GuiControl,,Caps_Lock,��
Gui, Add, Text, xp+40  vScroll_Lock c%Color%, ��
GetKeyState,Lock,ScrollLock,T
If Lock=D
	GuiControl,,Scroll_Lock,��
; ʹָ����ɫ�����ر��͸��������ʹ���屾��͸����Ϊ150
;~ Gui, Font, s20
;~ Gui, Add, Text,xp-70 yp+38 c%Color%,NL
;~ Gui, Add, Text,xp+41 c%Color%,CL
;~ Gui, Add, Text,xp+41 c%Color%,SL
WinSet, TransColor, %CustomColor% %TransColor%
Gui, Show, x%posx% y%posy% NoActivate
Return

;--------------------------------------------------------------------------------
~ScrollLock::
GetKeyState,Lock,ScrollLock,T
If Lock=D
	GuiControl,,Scroll_Lock,��
Else
	GuiControl,,Scroll_Lock,��
Return

~CapsLock::
GetKeyState,Lock,CapsLock,T
If Lock=D
	GuiControl,,Caps_Lock,��
Else
	GuiControl,,Caps_Lock,��
Return

~NumLock::
GetKeyState,Lock,NumLock,T
If Lock=D
	GuiControl,,Num_Lock,��
Else
	GuiControl,,Num_Lock,��
Return

;-----------------------------------------------------------------------------
setting:
Gui, 2:Add, GroupBox, x16 y11 w140 h100 , ָʾ��λ��
Gui, 2:Add, Radio, x26 y31 w50 h20 vpos, ����
Gui, 2:Add, Radio, x96 y31 w50 h20 , ����
Gui, 2:Add, Radio, x26 y71 w50 h20 , ����
Gui, 2:Add, Radio, x96 y71 w50 h20 checked, ����
Gui, 2:Add, GroupBox, x176 y11 w180 h100 , ָʾ����ɫ
Gui, 2:Add, Text, x196 y31 w84 h19 , 16����RGBֵ
Gui, 2:Add, Edit,vColor x196 y81 w130 h20,%Color%
Gui, 2:Font, underline
Gui, 2:Add, Text, x196 y56 w90 h20 gweb cRed, �鿴�ο�
Gui, 2:Font, norm
; Generated using SmartGUI Creator 4.0
GuiControl,2:,%checked%,1
Gui, 2:Add, GroupBox, x16 y120 w340 h70 , ͸����
Gui, 2:Add, Edit,xp+20 yp+25
Gui, 2:Add, UpDown, vTransColor  Range0-255,%TransColor%
Gui, 2:Add, Text, xp+150 yp+5,(0��255֮������,Ĭ��ֵ150)
Gui, 2:Show, h194 w369, ����
Return

2GuiClose:
Gui,2:Submit
Gosub,iniwrite
Reload
return

IniRead:
IniRead, TransColor,  LockTip.ini, ����,TransColor, 150
IniRead, pos, LockTip.ini, ����, Position, 4
IniRead, Color, LockTip.ini, ����, Color, 0000FF
Return
IniWrite:
If TransColor>255
	TransColor=255
If TransColor<0
	TransColor=0
IniWrite, %TransColor%,  LockTip.ini, ����,TransColor
IniWrite, %pos%, LockTip.ini, ����, Position
Gosub,ColorCheck
If OK
	IniWrite, %Color%, LockTip.ini, ����, Color
Return

ColorCheck:
Color :=RegExReplace(Color,"[^0-9a-fA-F]","")
If StrLen(Color)=6
	OK=1
Return
;-----------------------------------------------------------------------------
web:
Run,http://www.wahart.com.hk/rgb.htm
Return

email:
Run, mailto:heathlolicon@gmail.com?subject=����BUG���������飨LockTip��
Return

exit:
ExitApp
Return

;~ Reload:
;~ Reload
;~ Return