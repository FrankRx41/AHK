;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; AHK�汾��		1.0.48.5
; ���ԣ�		����
; ����ƽ̨��	WinXp/NT
; ���ߣ�		���� <healthlolicon@gmail.com>
; �ű����ͣ�	���
; �ű����ܣ�	�Զ�����������
;
; ��֪ȱ�ݣ�
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#NoEnv
#NoTrayIcon
#SingleInstance off
;~ #Include, I:\AutoHotKey\Lib\
SendMode Input

if 1=
goto,Gui
iniread,ToRun,%A_WinDir%\system32\Myrun.ini,HotStrings,%1%,%A_Space%
IfInString,ToRun,`%
run ,% ap(ToRun),,hide
Else
run,%Torun%
ExitApp

Gui:
Menu,MyContextMenu,Add,���Ƶ����а�,copy
Menu,MyContextMenu,Add,���б���ɾ��,delete
Menu,MyContextMenu,Add,��յ�ǰ�б�,clear
Gui, color, 000000, 000000
Gui, Add, ListView, +BackgroundTrans x-1 y-1 w480 h230 -LV0x10  NoSort AltSubmit vMyrun cffffff, �������|Ҫִ�л�򿪵ĳ����ļ�������
LV_ModifyCol(1,130)
LV_ModifyCol(2,345)
Gui, Add, Text, +BackgroundTrans cffffff x10 y241 w90 h20 , �������
Gui, Add, Text, +BackgroundTrans cffffff x136 y241 w190 h20 , Ҫִ�л�򿪵ĳ����ļ�������
Gui, Add, Text, +BackgroundTrans cffffff x350 y241 w120 h20 , ��Esc���رձ�����
Gui, Add, Edit, +BackgroundTrans cffffff x6 y266 w110 h20 vHotString ,
Gui, Add, Edit, +BackgroundTrans cffffff x136 y266 w220 h20 vCmd,
Gui, Add, Button, +BackgroundTrans x356 y266 w30 h20 gView, ...
Gui, Add, Button, +BackgroundTrans x396 y266 w70 h20 gAdd Default, ���
Gui +LastFound
Gui, Show, , Myrun - �Զ�����������
WinSet,  Transparent, 200 ,Myrun - �Զ�����������
Gui,-Caption
Gui, Show, w476 h295
WinSet,redraw
Gosub,ini2list
Return

View:
FileSelectFile,Cmd,,,���Ҫѡ���ļ��У�ѡ���ļ����������ļ����޸�·������
GuiControl,,Cmd,%Cmd%
Return

ini2list:
IfNotExist,%A_WinDir%\system32\Myrun.ini
FileAppend,
(
[HotStrings]
`;MyRun�����ļ�
Setting=C:\WINDOWS\system32\MyRunSetting.ini
),%A_WinDir%\system32\Myrun.ini
FileRead,AllString,%A_WinDir%\system32\Myrun.ini
loop,Parse,AllString,`n,`r
{
    if a_index=1
        Continue
    if Strlen(A_loopfield)=0
        break
    StringSplit,List,A_loopfield,=
    LV_Add(0,List1,List2)
    }
Return

GuiContextMenu:
if A_GuiControl <> Myrun
	Return
Menu, MyContextMenu, Show, %A_GuiX%, %A_GuiY%
Return

Copy:
FocusedRowNumber := LV_GetNext(0, "F")
if not FocusedRowNumber
    return
LV_GetText(copy1, FocusedRowNumber, 1)
LV_GetText(copy2, FocusedRowNumber, 2)
Clipboard:= copy1 . a_space . copy2
Return

~delete::
delete:
RowNumber = 0
Loop
{
    RowNumber := LV_GetNext(RowNumber - 1)
    if not RowNumber
        break
    Lv_GetText(HotString2del,RowNumber,1)
    IniDelete, %A_WinDir%\system32\Myrun.ini, HotStrings , %HotString2del%
    LV_Delete(RowNumber)
}

return

Clear:
LV_Delete()
FileDelete,%A_WinDir%\system32\Myrun.ini
Return

Add:
IfNotExist,%A_WinDir%\system32\MyrunSetting.ini
FileAppend,
(
[Setting]
`;�����Ƿ񵯳������1Ϊ��0Ϊ��
DontWarnAgain=0
`;���ò���������������µ�Ĭ�ϲ�����1Ϊ���ǣ�0Ϊȡ��
DefaultButton=1
),%A_WinDir%\system32\MyrunSetting.ini
IniRead,DontWarn,%A_WinDir%\system32\MyrunSetting.ini,Setting,DontWarnAgain,0
IniRead,DefaultButton,%A_WinDir%\system32\MyrunSetting.ini,Setting,DefaultButton,1
GuiControlGet,HotString
GuiControlGet,Cmd
iniread,IsExist,%A_WinDir%\system32\Myrun.ini,HotStrings,%HotString%,%A_Space%
if Strlen(IsExist)<>0
{
    if DontWarn=0
    {
        Gui, 2:+owner1
        Gui, 2:color,C6E2FF,C6E2FF
        Gui, 2:Add, Text,+BackgroundTrans  x16 y12 w120 h30 , �Ѵ�����ͬ�������`n%A_Space%�Ƿ񸲸ǣ�
        Gui, 2:Add, Button,+BackgroundTrans  x16 y51 w40 h20 gYes, ��
        Gui, 2:Add, Button,+BackgroundTrans  x86 y51 w40 h20 gNo, ��
        Gui, 2:Add, CheckBox,+BackgroundTrans  x16 y87 w140 h19 vDontWarnAgain,������ʾ�˾����
        Gui, 2:Show,, ���棡
        WinSet,  Transparent,200,���棡
        Gui, 2:-Caption
        Gui, 2:Show, w153 h108
        Return
    }
    If DefaultButton
        Gosub,yes
    Else
        Gosub,No
}
Else
{
    LV_Add(0,HotString,Cmd)
    IniWrite,%Cmd%,%A_WinDir%\system32\Myrun.ini,HotStrings,%HotString%
    }
Return

Yes:
Gui,2:submit
Gui,2:destroy
IniWrite,%DontWarnAgain%,%A_WinDir%\system32\MyRunSetting.ini,Setting,DontWarnAgain
IniWrite,1,%A_WinDir%\system32\MyRunSetting.ini,Setting,DefaultButton
Gosub,Overlay
Return

No:
Gui,2:submit
Gui,2:destroy
IniWrite,%DontWarnAgain%,%A_WinDir%\system32\MyRunSetting.ini,Setting,DontWarnAgain
IniWrite,0,%A_WinDir%\system32\MyRunSetting.ini,Setting,DefaultButton
Return

Overlay:
gui,1:default
Loop % LV_GetCount()
{
    LV_GetText(RetrievedText, A_Index,2)
    if RetrievedText=%IsExist%
    LV_Delete(A_Index)
}
LV_Add(0,HotString,Cmd)
IniWrite,%Cmd%,%A_WinDir%\system32\Myrun.ini,HotStrings,%HotString%
Return

Esc::
GuiClose:
ExitApp

ap(relative)        ;ת��Ϊ����·�� | thx to ashdisp
{
     splitPath,A_ScriptfullPath,,,,,ScriptDrive
     stringReplace,APPPath,relative,`%QLDir`%,% A_ScriptDir,All        ;����Ŀ¼
     stringReplace,APPPath,APPPath,`%WinDir`%,% A_Windir,All
     stringReplace,APPPath,APPPath,`%ProgramFiles`%,% A_ProgramFiles,All
     stringReplace,APPPath,APPPath,`%comspec`%,% comspec,All
     return APPPath
}