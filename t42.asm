data segment
	A dw 5
	B dw 6
data ends

code segment
	assume cs:code, ds:data
start:
	mov ax, data
	mov ds, ax
	mov ax, A
	mov bx, B
	test ax, 0001h ;判断奇偶性
	jz a_even	; A 是偶数
	test bx, 0001h
	jz quit		; A 是奇数，B是偶数
	inc ax  ;加一
	inc bx
	mov A, ax
	mov B, bx
	jmp quit
a_even:			
		test bx, 0001h
		jz quit			; A，B都是偶数
		xchg ax, bx
		mov A, ax
		mov B, bx
quit:
	mov ah, 4ch;退出
	int 21h
code ends
	end start