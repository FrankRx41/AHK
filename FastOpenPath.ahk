;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; AHK�汾:		1.0.48.5
; ����:			����
; ����ƽ̨:		WinXp/NT
; ����:			���� <healthlolicon@gmail.com>
; �ű�����:		Ӧ�ó���
; �ű�����:		���ٴ򿪹��������ļ���·�����ļ��������Լ�ע���
; �ο�:			AHK ��͵�\8.���ٽ���ע���.ahk�ж�λע���ķ���
; ��֪ȱ��:		ֻ��ʶ��Http��ftp����www��ͷ��Url
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
Menu, Tray, NoStandard
Menu, Tray, Add, �˳�


^q::
ClipboardOld :=Clipboard
Clipboard =
send ^c
clipwait
If ErrorLevel
    return
Path :=Clipboard
Clipboard :=ClipboardOld
StringReplace, Path, Path, ��,��\, All
StringRight, LastChar, Path, 1
if LastChar = \ || /
    StringTrimRight, Path, Path, 1

KeyWordPos :=RegExMatch(Path, "HKEY")									; �Ƿ�Ϊע���
If (KeyWordPos=1)
{
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Applets\Regedit, LastKey, �ҵĵ���\%Path%
																		; ��Pathд��ע����б�ʾ����λ�õ���
	WinClose, ע���༭��											; �ر�ԭ����ע�����,����еĻ�
	Run, regedit
	}
Else																	; ʹ��If-Else�Ż����̣�ƽ�����Ҵ���Ϊ2��
{
	KeyWordPos :=RegExMatch(Path, "(http:|ftp:|www)")				; �Ƿ�Ϊ����
	If (KeyWordPos=1)
	{
		Path :=RegExReplace(Path, "[^a-zA-Z0-9:\.\?/\-_%]", "")
		Run, %Path%
		}
	Else
	{
		KeyWordPos :=RegExMatch(Path, "\w:")							; �����̷�λ��
		If (KeyWordPos=1)
		{
			Run, %Path%
			}
		}
	}
Return


�˳�:
ExitApp
Return