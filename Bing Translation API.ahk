;
; AHK�汾: 		B:1.0.48.5
;				L:1.1.3.0
; ����:			����/English
; ƽ̨:			Win7
; ����:			���� <healthlolicon@gmail.com>
;
;
;
;

#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%  ;
#Include C:\Users\Robin\Documents\AutoHotKey\Lib\codexchange.ahk
;APPID����
;http://www.bing.com/toolbox/bingdeveloper/
;
APPID=���APPID

ansi_cn=�й�
ansi_en=speak
;ת��
utf8_cn:=Ansi2UTF8(ansi_cn)
utf8_en:=Ansi2UTF8(ansi_en)
;url����
url_cn:=UrlEncode(utf8_cn)
url_en:=UrlEncode(utf8_en)

/*
Translate Method  V2
*/
;~ var1:=URLDownloadTovar("http://api.microsofttranslator.com/V2/Http.svc/Translate?appId=" . APPID . "&text=" . url_cn . "&form=zh-CHS&to=en")
;~ MsgBox,% UTF82Ansi(var1)

;~ var2:=URLDownloadTovar("http://api.microsofttranslator.com/V2/Http.svc/Translate?appId=" . APPID . "&text=" . url_en . "&form=en&to=zh-CHS")
;~ MsgBox,% UTF82Ansi(var2)

/*
GetTranslations Method  V2
*/
HTTPRequest("http://api.microsofttranslator.com/V2/Http.svc/GetTranslations?appId=" . APPID . "&text=" . url_cn . "&form=zh-CHS&to=en&maxTranslations=5",var3,ck1,"Method:post")
MsgBox,% var3

HTTPRequest("http://api.microsofttranslator.com/V2/Http.svc/GetTranslations?appId=" . APPID . "&text=" . url_en . "&form=en&to=zh-CHS&maxTranslations=5",var4,ck2,"Method:post")
MsgBox,% var4
