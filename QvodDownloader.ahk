#NoTrayIcon
#include D:\AutoHotkey\Lib\codexchange.ahk
Gui, Add, Text, x12 y10 w190 h20 , Qvod����:
Gui, Add, Edit, x12 y40 w320 h90 gLinks vLinks,
Gui, Add, Text, x12 y140 w100 h30 , ��������:
Gui, Add, Edit, x12 y170 w320 h90 Disabled vContent,
Gui, Add, Button, x22 y270 w50 h30 gDL, ����
Gui, Add, Button, x76 y270 w60 h30 gGetTorrent, ��ȡ����
Gui, Add, Text, x+8 y280 w20 h20 , ��
Gui, Add, DropDownList, xp+20 y276 w50 vDDL,
Gui, Add, Text, xp+80 y280 w60 h30 , ����Ƶ
; Generated using SmartGUI Creator 4.0
Gui, Show, x137 y94  w338, QvodDownloader
Return

GuiClose:
ExitApp

Links:
GuiControlGet,Links
;;��unicode������ԭ
while pos := RegExMatch(Links, "(%u|\\u)\w{4}")
{
        Tmp := SubStr(Links, pos+2, 4)
        Tmp := UnicodeLECode2Ansi(Tmp)
        Links := RegExReplace(Links, "(%u|\\u)\w{4}", Tmp, "", 1)
}
;;Url�����
Alllinks:=UrlUnEscape(Links)
;|��������е�����
StringReplace,Alllinks,Alllinks,|,*,all
Alllinks .= "*"
Pos=1
Count=0
Loop
{
	pos:=RegExMatch(Alllinks,"://\d+?\*(\w+?)\*(.*?)\*",info_,Pos)
	if pos=0
		Break
	Count++
	task_%Count%_info_1:=info_1
	task_%Count%_info_2:=info_2
	pos++
}
Content=
GuiControl,,DDL,|
loop,% Count
{
	Content:=Content . A_index .  ". �ļ�:" . task_%A_index%_info_2 . "  hash:" .  task_%A_index%_info_1 . "`n"
	GuiControl,,DDL,%a_index%
}
StringTrimRight,content,content,1
GuiControl,,content,%content%
Return



DL:
GuiControlGet,DDL
if !DDL
	Return
Name:=task_%DDL%_info_2 . "_" . task_%DDL%_info_1 . ".exe"
FileCopy,QvodPlus.exe,%Name%
Run,% name
Return

GetTorrent:
GuiControlGet,DDL
if !DDL
	Return
Name:=task_%DDL%_info_2 . "_" . task_%DDL%_info_1 . ".exe"
FileCopy,Qvod.dll,%Name%
Run,% name,,hide
File:=A_ScriptDir . "_" . task_%DDL%_info_2
StringReplace,file,file,:,_,All
StringReplace,file,file,\,_,All
loop,30
{
	IfExist,%A_AppDataCommon%\KuaiWan\Data\%File%.torrent
		Break
	Else
	{
		if A_index=30
		{
			MsgBox,����
			gosub,del
			Return
			}
		Else
			Sleep,1000
		}
	}
FileMove,%A_AppDataCommon%\KuaiWan\Data\%File%.torrent,%A_ScriptDir%\%File%.torrent
del:
Process,close,%Name%
process,WaitClose,%Name%
FileDelete,% Name
FileDelete,%A_AppDataCommon%\KuaiWan\Data\%File%*
Return

UnicodeLECode2Ansi(a)
{
        a := "0x" . a
        VarSetCapacity(LE, 2, "UShort")
        NumPut(a, LE)
        VarSetCapacity( Ansi, 2, 0)
        DllCall( "WideCharToMultiByte", Int, 0, Int, 0, UInt, &LE, Int, -1, Str, Ansi, Int, 2, Int, 0,Int, 0)
        Return Ansi
}