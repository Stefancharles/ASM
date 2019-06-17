.model small
.data
	helpinfo db 'Input(Y/N): $';帮助信息
	outputyes db 0dh, 0ah, 'Output: Y!', 0dh, 0ah, '$'
	outputno db 0dh, 0ah, 'Output: N!', 0dh, 0ah, '$'
    warninfo db 0dh, 0ah, 'Warning: Please contact Stefan!', 0dh, 0ah, '$'
.code
start:
	mov ax, @data
	mov ds, ax
    jmp proshow
proshow:
	mov dx, offset helpinfo	;打印帮助信息
	mov ah, 9h
	int 21h
	mov ah, 1h;键盘输入
	int 21h
	cmp al, 59h
	jz isy			;is Y
	cmp al,4eh	
	jz isn			;is N
	cmp al,1bh	
	jz isesc	  ;is esc
    mov dx, offset warninfo;打印警告信息
	mov ah, 9h
	int 21h
    jmp quit
isy:
	mov dx, offset outputyes;打印yes信息
	mov ah, 9h
	int 21h
    jmp quit
isn:
	mov dx, offset outputno;打印no信息
	mov ah, 9h
	int 21h
    jmp quit
isesc:;按下esc键则退出
mov ah, 4ch
int 21h
quit:;循环工作
	jmp proshow
	end start