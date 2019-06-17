data segment
	grade dw 005ch, 005bh, 0055h, 0001h, 0011h, 0046h, 0050h, 0002h, 002dh, 
    0010h, 0032h, 0023h, 0035h, 0053h, 0009h, 000ch, 000ah, 001fh, 0007h, 
    0012h, 0021h, 0004h, 0040h, 0013h, 0031h, 0006h, 000eh, 000dh, 0026h, 0029h
	temp dw 30 dup(?)
	rank db 30 dup(1)
	outputinfo1 db 'Student $'
	outputinfo2 db ' score : $';分数
	outputinfo3 db ' rank: $';排名
	nextline db 0dh, 0ah, '$';换行
data ends

code segment
	assume cs:code, ds:data
start:
	mov ax, data
	mov ds, ax
	mov es, ax
	mov si, offset grade ;取成绩首地址
	mov di, offset temp ;取temp地址
	mov cx, 1eh   ;计数30
	rep movsw ;循环赋值 temp
	mov si, 00h
compare:	
	cmp si, 3ch ;60
	jz outputpart
	mov di, 00h
	mov bl, 01h
	mov ax, temp[si]
	nextcmp:
		cmp di, 3ch
		jz setrank
		cmp ax, temp[di]
		jae pass
		inc bl
		pass:
			add di, 2h
		jmp nextcmp
		setrank:
			shr si, 1
			mov rank[si], bl
			shl si, 1
	add si, 2h
	jmp compare
	
	; output 子程序
outputpart:	
	mov si, 00h
	mov di, 00h
	
outputs:
	cmp si, 3ch		; 1eh * 2 = 3ch
	jge quit
	mov cl, 0ah	
	mov ax, di			; 输出 'Student xx score:
	div cl
	add ax, 3030h		; to ascii
	mov bx, ax
	mov dx, offset outputinfo1
	mov ah, 9h
	int 21h
	mov ah, 2h
	mov dl, bl
	int 21h				;输出十位
	mov dl, bh			;输出个位
	int 21h
	mov dx, offset outputinfo2
	mov ah, 9h
	int 21h
	
	mov ah, 02h
	mov cl, 04h
	mov bx, temp[si]
	mov ch, 00h
printnumber:	
	cmp ch, 04h
	jz printleft
	mov dl, bh
	and dl, 0f0h
	shr dl, cl
	cmp dl, 09h
	jle number
	add dl, 07h
	number:
		add dl, 30h
	int 21h
	shl bx, cl
	inc ch
	jmp printnumber
printleft:
	mov dx, offset outputinfo3
	mov ah, 9h
	int 21h				;输出 ' rank : '
	mov bl, 0ah
	mov ah, 00h
	mov al, rank[di]
	div bl
	mov bx, ax
	mov ah, 02h
	mov dl, bl
	add dl, 30h
	int 21h
	mov dl, bh
	add dl, 30h
	int 21h
	mov ah, 9h
	mov dx, offset nextline
	int 21h
	add si, 02h
	inc di
	jmp outputs
quit:
	mov ah, 4ch
	int 21h
code ends
	end start