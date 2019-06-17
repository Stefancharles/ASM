data   segment
string1 db 'test'
count = 4
string2 db 4 dup(?)
data ends
stack SEGMENT
DB 100 DUP(?)
stack ENDS 

code   segment
assume   cs:code,ds:data,ss:stack
          org   100H
begin:    jmp   main
main      proc  near
          mov ax,data
          mov ds,ax
          mov cx,count
          mov si,offset string1
          mov di,offset string2
movstring:     
          mov al,[si]
          mov [di],al
          inc si
          inc di
          loop movstring
exit:
          mov     ax,  4c00h
          int     21h
main      endp
code      ends
          end   begin
