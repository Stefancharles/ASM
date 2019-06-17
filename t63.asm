data segment
data ends
code segment
	assume cs:code,ds:data
 p  proc far
	mov ax,data
	mov ds,ax	
	mov ah,01h;接收键盘输入字符
	int 21h
	cmp al,'a'
	jb input;如果是小写就直接输出
	cmp al,'z'
	ja input;如果是小写就直接输出
	sub al,32	;否则就进行大小写转换
input :	xchg dl,al
	mov ah,02h;输出DL寄存器的字符到显示器
	int 21h
	mov ah,4ch;退出程序
	int 21h
	p endp
	code ends
	end p