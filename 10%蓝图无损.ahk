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
Gui, Add, Text, x6 y11 w180 h20 , 10`%��ʼ���ϵ����ͼ�������
Gui, Add, Text, x6 y41 w90 h20 , ��������Ŀ:
Gui, Add, Edit, x106 y41 w80 h20 Number vMaterial gCalculate,
Gui, Add, Edit, x6 y81 w180 Disabled vResult, �������:
; Generated using SmartGUI Creator 4.0
Gui, Show, x131 y91 h122 w195, ����
Return

GuiClose:
ExitApp

Calculate:
GuiControlGet,Material
Loop
{
	A:=Round(Material/1.1)*(0.1/(1+A_index-1))
	if A<0.5
	{
		Times:=A_Index-1
		Break
	}
}
GuiControl,,Result,�������:%Times%��
Return
