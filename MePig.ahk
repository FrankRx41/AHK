#NoTrayIcon
FileInstall,moe.jpg,%A_temp%\sayori.jpg,1
run,%A_temp%\sayori.jpg
InputBox,v,������,���롰������`n��������!,,150,150
If v=������
	ExitApp
Else
{
	IfInString,v,������
	{
	SetTimer,shutdown,5000
	MsgBox,48,TMD,Ѿ��ò��ͷ��ˣ�
	IfMsgBox, Ok
		Gosub,shutdown
	}
	Else
	{
		SetTimer,reboot,5000
		MsgBox,32,С��,������ʵ��������
		IfMsgBox, Ok
			Gosub, reboot
	}
}
Return

shutdown:
;~ Shutdown,13
Return

reboot:
;~ Shutdown,6
Return
