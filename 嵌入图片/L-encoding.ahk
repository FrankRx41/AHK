#include Ascii85.ahk

; Find it at http://www.autohotkey.com/forum/viewtopic.php?p=44718#44718
#include BinReadWrite.ahk

LineLength=70			;����ÿ�г���

; ��ȡ�ļ�
VarSetCapacity(Input, 100000)
h:=OpenFileForRead("moeimouto.png") ; file taken at http://www.autohotkey.com/docs/images/AutoHotkey_logo.gif
BinarySize:=ReadFromFile(h, Input, 0, FILE_BEGIN)	; �ļ���С
CloseFile(h)	; �ر��ļ�

; ����ת������ļ�����
neededmemory := (BinarySize+3)/4*5 ; BIN�������ƣ�->ASCII85 ת�����賤��
neededmemory += (neededmemory + LineLength - 1) / LineLength * 2 ; ����CR/LF���з����賤��
neededmemory += 5 ; ���������Adobeǰ��׺"<~" "~>"��\0�Ļ�����������

; �����ڴ�ռ�
VarSetCapacity(Output,neededmemory)

; ת����ASCII85
OutputSize:=Ascii85_Encoder(&Input, BinarySize, &Output, LineLength)

; ����'\0' ����֪AHK���ı��Ĵ�СΪ0xFFFFFFFF
NumPut(0, Output, OutputSize, "char")
VarSetCapacity(Output, -1)

; ת��һЩAHK������з���
Ascii85_AhkEmbedParser(Output, Output)

; д���ļ�
FileDelete, logo.asc
FileAppend, %Output%, logo.asc