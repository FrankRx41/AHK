;
; AHK�汾: 		B:1.0.48.5 L:1.0.92.0
; ����:			����/English
; ƽ̨:			Win7
; ����:			���� <healthlolicon@gmail.com>
; ����:			����
; ����:			ʶ��ͼ������
;
;
;~ File=C:\Users\Robin\Desktop\Temp\�׿�YSTһ����ɨ�߰�.jpg
;~ MsgBox,% GetImageTypeA(File)

GetImageTypeA(File)
{
	;Type 0 Unknow
	;Type 1 BMP		*.bmp
	;Type 2 JPEG	*.jpg *.jpeg
	;Type 3 PNG		*.png
	;Type 4 gif		*.gif
	;Type 5 TIFF	*.tif
	FileRead,FileHead,*m4 %File%
  	Filehead_Hex:=NumGet(Filehead)

	if FileHead_hex=0x474E5089				;С��  ʵ������Ϊ 89 50 4E 47 ��ͬ	PNG�ļ�ͷ��ʵ��8�ֽ�
		Type=png	;3		;	png
	Else If FileHead_hex=0x38464947		;gif�ļ�ͷ6�ֽ�
		Type=gif	;4		;	gif
	Else
	{
		Filehead_hex&=0xFFFF
		If FileHead_hex=0x4D42				;BMP���ļ�ͷֻ��2�ֽ�
			Type=bmp	;1		;	bmp
		Else if FileHead_hex=0xD8FF		;JPG�ļ�ͷҲֻ��2�ֽ�
			Type=jpg	;2		;	jpg/jpeg
		Else If FileHead_hex=0x4949		;TIFF�ļ�ͷ2�ֽ� II
			Type=tif	;5		;	tif
		Else If FileHead_hex=0x4D4D		;MM
			Type=tif	;5		;	tif
		Else
			Type=0		;	Unknow
		}
	Return,Type
	}
