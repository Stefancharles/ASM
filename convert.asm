.model small
.data
	inputinfo db 50 dup(?) ;最大处量
	helpinfo db 'Input: $'
	outputinfo db 'Output: $'
	warninfo db 0dh, 0ah, 'Warning: Can not deal with so many words! Please contact Cyberpunk!', 0dh, 0ah, '$'
;超过50字提示
.code
start:
	mov ax, @data
	mov ds, ax
	
	mov dx, offset helpinfo	
	mov ah, 9h;输出提示
	int 21h
	
	mov si, 0h
	mov ah, 1h
let0:
	int 21h
	mov inputinfo[si], al
	inc si
	cmp al, 0dh
	jz let1
	cmp si, 100
	jl let0
	mov dx, offset warninfo
	mov ah, 9h;输出警告字符
	int 21h	
let1:
	mov bx, 0h
	mov dx, offset outputinfo
	mov ah, 9h;输出转大写后的字符
	int 21h
let2:
	and inputinfo[bx], 0dfh
	mov dl, inputinfo[bx]
	mov ah, 2h;从键盘接收字符
	int 21h
	inc bx
	dec si
	jnz let2
	mov ah, 4ch
	int 21h
	end start