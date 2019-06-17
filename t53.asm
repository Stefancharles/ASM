.model small
.data
	helpinfo db 'Input: $'
	outputinfo db 0dh, 0ah, 'Output: $'
.code
start:
	mov ax, @data
	mov ds, ax
	
	mov dx, offset helpinfo	
	mov ah, 9h
	int 21h
	
	mov ah, 1h
	int 21h
	cmp al, 0dh
	jz quit			;; 回车
	cmp al, 'a'	
	jb quit			;; < 'a'
	cmp al, 'z'		
	ja quit			;; > 'z'
	mov dx, offset outputinfo
	mov ah, 9h
	int 21h
	mov ah, 2h
	cmp al, 61h
	jz isa				;; 是 'a'
	cmp al, 7ah			
	jz isz				;; 是 'z'
isa:
	mov dl, 7ah
	int 21h
	mov dl, 61h
	int 21h
	inc dl
	int 21h
	jmp quit
isz:
	mov dl, 79h
	int 21h
	inc dl
	int 21h
	mov dl, 61h
	int 21h
	jmp quit
	
quit:
	mov ah, 4ch
	int 21h
	end start