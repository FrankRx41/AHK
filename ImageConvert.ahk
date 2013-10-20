;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; AHK�汾��		1.0.48.5
; ���ԣ�		����
; ����ƽ̨��	WinXp/NT
; ���ߣ�		���� <healthlolicon@gmail.com>
; �ű����ͣ�
; �ű����ܣ�	ͼƬ��ʽת��:jpg/png/bmp
; �ο���		http://www.autohotkey.com/forum/viewtopic.php?t=11860&postdays=0&postorder=asc&start=0
; ��֪ȱ�ݣ�	��ʽ���⼸�� ���������TIF�����ǲ����ã����ˡ�GDIP�ܴ���ĸ�ʽ���٣����Ǻ���
;				Դ�뻹û����������ֻŪ����������
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#Include GDIplusWrapper.ahk
ImageConvert(sFrom="",sTo="")				;������ĺ�����ͬ�����������ˡ���������Copy�������޸ĵĴ���
{
	#GDIplus_mimeType_BMP = image/bmp
	#GDIplus_mimeType_JPG = image/jpeg
	#GDIplus_mimeType_GIF = image/gif
	#GDIplus_mimeType_PNG = image/png
	#GDIplus_mimeType_TIF = image/tiff
	#EncoderQuality = {1D5BE4B5-FA4A-452D-9CDD-5DB35105E7EB}

	noParams = NONE

	SplitPath,sTo,,,sExtTo



	step = GDIplus_Start				;����GDIP
	If (GDIplus_Start() != 0)
		Goto GDIplusError

;~ 	if sFrom=							;����ճ����   ��Ъ�Թ��ϣ������������������ճ����ͼƬ
;~ 	{
;~ 		step = GDIplus_LoadBitmapFromClipboard
;~ 		If (GDIplus_LoadBitmapFromClipboard(bitmap) != 0)
;~ 			Goto GDIplusError
;~ 	}
;~ 	Else
;~ 	{
		step = GDIplus_LoadBitmap			;��ȡͼƬ
		If (GDIplus_LoadBitmap(bitmap, sFrom) != 0)
			Goto GDIplusError
;~ 	}

	if sExtTo=jpg
	{
		step = GDIplus_GetEncoderCLSID for JPG
		If (GDIplus_GetEncoderCLSID(jpgEncoder, #GDIplus_mimeType_JPG) != 0)
			Goto GDIplusError

		GDIplus_InitEncoderParameters(jpegEncoderParams, 1)
		jpegQuality = 100	; ͼƬ���� 0-100...
		step = GDIplus_AddEncoderParameter for JPG
		If (GDIplus_AddEncoderParameter(jpegEncoderParams, #EncoderQuality, jpegQuality) != 0)
			Goto GDIplusError

		step = GDIplus_SaveImage for JPG
		If (GDIplus_SaveImage(bitmap, sTo, jpgEncoder, jpegEncoderParams) != 0)
			Goto GDIplusError
			}


	Else If sExtTo=png
	{
		step = GDIplus_GetEncoderCLSID for PNG
		If (GDIplus_GetEncoderCLSID(pngEncoder, #GDIplus_mimeType_PNG) != 0)
			Goto GDIplusError

		step = GDIplus_SaveImage for PNG
		If (GDIplus_SaveImage(bitmap, sTo, pngEncoder, noParams) != 0)
			Goto GDIplusError
		}

	Else if sExtTo=bmp
	{
		step = GDIplus_GetEncoderCLSID for BMP
		If (GDIplus_GetEncoderCLSID(bmpEncoder, #GDIplus_mimeType_BMP) != 0)
			Goto GDIplusError

		step = GDIplus_SaveImage for BMP
		If (GDIplus_SaveImage(bitmap, sTo, bmpEncoder, noParams) != 0)
			Goto GDIplusError
	}

	GDIplus_DisposeImage(bitmap)

	Goto GDIplusEnd

	GDIplusError:
	If (#GDIplus_lastError != "")
		MsgBox 16, GDIplus Test, Error in %#GDIplus_lastError% (at %step%)
	GDIplusEnd:
		GDIplus_Stop()
}
