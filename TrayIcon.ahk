;
; AHK�汾:		Basic
; ����:			����/English
; ƽ̨:			Win7 (x64)
; ����:			���� <healthlolicon@gmail.com>
; ����:			����
; ����:			��������ͼ��
; ȱ��:			ͬ���̵�ͼ�� �޷�����(����ͨ���߳�������),��ֻ���ؼ������ĵ�һ��(����ͨ���޸�ѭ���Ľ�)
; �ο�:			http://blog.csdn.net/hailongchang/article/details/3454569
;				http://msdn.microsoft.com/en-us/library/bb760476%28v=vs.85%29.aspx
;				http://msdn.microsoft.com/en-us/library/bb787319%28v=vs.85%29.aspx
;				etc...


/*
e.g.:
TrayIcon("QQ.exe",0)		;����QQ
TrayIcon(-1,0,"ID")			;������������ͼ��


ID_or_PN:�μ�Cmd
Show:����1��ʾͼ��,����0����ͼ��,Ĭ��1
Cmd
	PN:ID_or_PN����ΪҪ���ص�����ͼ������������
	ID:ID_or_PN����Ϊͼ��ID,����-1����/��ʾ����ͼ��
*/

#NoEnv
DetectHiddenWindows, On
TrayIcon(ID_or_PN,Show=1,Cmd="PN")
{
	;<commctrl.h>
	;#define	WM_USER			0x400
	;#define	TB_HIDEBUTTON	(WM_USER+4)		0x404
	;#define	TB_GETBUTTON	(WM_USER+23)	0x417
	;#define	TB_BUTTONCOUNT	(WM_USER+24)	0x418
	;#define 	TB_GETBUTTONTEXTA	(WM_USER+45)0X42D
	;#define 	TB_GETBUTTONTEXTW	(WM_USER+75)
	WM_USER=0x400
	TB_HIDEBUTTON:=WM_USER+4
	TB_GETBUTTON:=WM_USER+23
	TB_BUTTONCOUNT:=WM_USER+24
	TB_GETBUTTONTEXTA:=WM_USER+45
	TB_GETBUTTONTEXTW:=WM_USER+75

	;;��ȡShell_TrayWnd->TrayNotifyWnd->SysPager->ToolbarWindow32(Spy++)�Ĵ��ھ��
	hwnd:=DllCall("FindWindow",Str,"Shell_TrayWnd",int,0)
	hwnd:=DllCall("FindWindowEx",Uint,hwnd,Uint,0,str,"TrayNotifyWnd",int,0)
	hwndSysPager:=DllCall("FindWindowEx",Uint,hwnd,Uint,0,str,"SysPager",int,0)
	if (!hwndSysPager)
		hwnd:=DllCall("FindWindowEx",Uint,hwnd,Uint,0,str,"ToolbarWindow32",int,0)
	Else
		hwnd:=DllCall("FindWindowEx",Uint,hwndSysPager,Uint,0,str,"ToolbarWindow32",int,0)

	ButtonCount:=DllCall("SendMessage",Uint,hwnd,Uint,TB_BUTTONCOUNT,int,0,int,0)

;~ 	MsgBox,��ǰ��%ButtonCount%������ͼ��

	if Cmd=PN
	{
		;;��ȡToolbarWindow32�Ľ���ID
		;;rtn �߳�ID
		;;PID ����ID
		rtn:=DllCall("GetWindowThreadProcessId",Uint,hwnd,UintP,PID)
		;;�򿪽���,��ȡ���
		hProcess:=DllCall("OpenProcess",Uint,0x0008|0x0010|0x0020,int,0,Uint,PID)
		;�ڽ����ڷ���һ���ڴ�
		lngAddress:=DllCall("VirtualAllocEx",Uint,hProcess,Int,0,Uint,0x4096,Uint,0x1000,Uint,0x04)

		Found=0
		Loop,% ButtonCount
		{
;~ 			DllCall("SendMessage",Uint,hwnd,Uint,TB_GETBUTTON,Uint,A_index-1,Uint,lngAddress)		;��Ч,ֻ�����ɵ�һ��ͼ�����Ϣ,����
			SendMessage, TB_GETBUTTON, A_Index - 1,lngAddress,ToolbarWindow321, ahk_class Shell_TrayWnd
			VarSetCapacity(info, 24)
			VarSetCapacity(Text, 24)
			DllCall("ReadProcessMemory",Uint,hProcess,Uint,lngAddress,Uint,&Text,Int,24,int,0)
			iBitmap		:= NumGet(Text, 0)
			idCommand	:= NumGet(Text, 4)
			Tmp			:= NumGet(Text, 8)		;	BYTE      fsState;
											;	BYTE      fsStyle;
											;	BYTE      bReserved[6];
			dwData		:= NumGet(Text, 16)
			iString		:= NumGet(Text, 20)
			/*
			x86(32λ)ϵͳʹ����δ����϶�
			http://msdn.microsoft.com/en-us/library/bb760476%28v=vs.85%29.aspx

			VarSetCapacity(Text, 20)
			DllCall("ReadProcessMemory",Uint,hProcess,Uint,lngAddress,Uint,&Text,Int,20,int,0)
			iBitmap		:= NumGet(Text, 0)
			idCommand	:= NumGet(Text, 4)
			Tmp			:= NumGet(Text, 8)		;	BYTE      fsState;
											;	BYTE      fsStyle;
											;	BYTE      bReserved[2];
			dwData		:= NumGet(Text, 12)
			iString		:= NumGet(Text, 16)
			*/
			DllCall("ReadProcessMemory", "Uint", hProcess, "Uint", dwData, "Uint", &info, "Uint", 24, "Uint", 0)
			hWnd  := NumGet(info, 0)
			uID   := NumGet(info, 4)
			nMsg  := NumGet(info, 8)
			hIcon := NumGet(info, 20)
			;��ȡά����ǰ���ھ���Ľ���PID
			rtn:=DllCall("GetWindowThreadProcessId",Uint,hwnd,UintP,PID)		;rtn�����߳���Ϣ,�ɹ���һ��������ͼ��
			;��ȡ������,DetectHiddenWindows, On ������ش���
			WinGet,ImageName,ProcessName,ahk_pid %PID%
			if (ImageName = ID_or_PN)
			{
				Found=1		;Found!
;~ 			MsgBox,% idcommand . " " . ImageName
				Break
			}
		}
		if Found
		{
			if show
				SendMessage, TB_HIDEBUTTON,idCommand,0,ToolbarWindow321, ahk_class Shell_TrayWnd
			Else
				SendMessage, TB_HIDEBUTTON,idCommand,1,ToolbarWindow321, ahk_class Shell_TrayWnd
		}
		DllCall("VirtualFreeEx",Uint,hProcess,UInt,lngAddress,Uint,0x4096,Uint,0x8000)	;MEM_RELEASE=0x8000
		DllCall("CloseHandle",Uint,hProcess)
	}
	Else if Cmd=ID
	{
		if ID_or_PN = -1
			Loop,% ButtonCount
			{
				if show
					SendMessage, TB_HIDEBUTTON,A_index-1,0,ToolbarWindow321, ahk_class Shell_TrayWnd
				Else
					SendMessage, TB_HIDEBUTTON,A_index-1,1,ToolbarWindow321, ahk_class Shell_TrayWnd
			}
		Else
		{
			if show
				SendMessage, TB_HIDEBUTTON,ID_or_PN,0,ToolbarWindow321, ahk_class Shell_TrayWnd
			Else
				SendMessage, TB_HIDEBUTTON,ID_or_PN,1,ToolbarWindow321, ahk_class Shell_TrayWnd
		}
	}
}

