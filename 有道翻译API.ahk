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
keyfrom=��ע��ʱ��д��keyfrom
APIKEY=���APIKEY

ansi_cn=�й�
ansi_en=speak
;ת��
utf8_cn:=Ansi2UTF8(ansi_cn)
utf8_en:=Ansi2UTF8(ansi_en)
;url����
url_cn:=UrlEncode(utf8_cn)
url_en:=UrlEncode(utf8_en)

;get
/*
http://fanyi.youdao.com/fanyiapi.do?keyfrom=<WebSiteName(keyfrom)>&key=<API KEY>&type=data&doctype=json&version=1.1&q=
*/
var1:=URLDownloadTovar("http://fanyi.youdao.com/fanyiapi.do?keyfrom=" . keyfrom . "&key=" . APIKEY . "&type=data&doctype=json&version=1.1&q=" . url_cn)
MsgBox,% UTF82Ansi(var1)

var2:=URLDownloadTovar("http://fanyi.youdao.com/fanyiapi.do?keyfrom=" . keyfrom . "&key=" . APIKEY . "&type=data&doctype=json&version=1.1&q=" . url_en)
MsgBox,% UTF82Ansi(var2)