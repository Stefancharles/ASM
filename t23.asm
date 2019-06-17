data   segment
string1 db 'test$'
space db 0dh, 0ah,'$'
count = 4
string2 db 4 dup(?),'$'
data ends

code   segment
assume   cs:code,ds:data
          org   100H
begin:    jmp   main
main      proc  near
          mov ax,data
          mov ds,ax
          mov cx,count
          mov si,offset string1
          mov di,offset string2
copystring:     
          mov al,[si]
          mov [di],al
          inc si
          inc di
          loop copystring
show:
        mov dx, offset string1	
	    mov ah, 9h
	    int 21h;显示string1
        mov dx, offset space	
	    mov ah, 9h
	    int 21h;显示换行
        mov dx, offset string2	
	    mov ah, 9h
	    int 21h;显示string2
exit:
          mov     ax,  4c00h
          int     21h
main      endp
code      ends
          end   begin