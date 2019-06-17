data segment
buf db 101,0,101 dup(?)
sapce db 0ah,'First is not a space ',0ah,'$'
data ends

stack segment stack
dw 20h dup(?)
top label word
stack ends

code segment
    assume ds:data,cs:code,ss:stack
    p proc far 
    mov ax,data
    mov ds,ax
    mov ax,stack
    mov ss,ax
    lea sp,top  ;lea取top地址
    mov ah,01h  ;键盘输入一个字符
    int 21h
    cmp al,' '   ;看是否为空格
    jne notspace  ;不是则跳转到对应子程序
    lea si,buf
    inc si
    inc si
    lea di,buf
    inc di

input:  
    mov ah,01h  ;键盘输入一个字符（AH=1）
    int 21h
    cmp al,' '
    je inputEnd   ;遇到结尾空格则输入结束
    mov [si],al
    inc si
    inc BYTE PTR [di]
    jmp input   ;跳转到input子程序

notspace:  
    lea dx,sapce
    mov ah,09h ;输出显示一个以"$"字符结尾的字符串到显示器。
    int 21h
    mov ah,4ch
    int 21h

inputEnd:   
    mov cl,[di]
    lea di,buf
    inc di  
    inc di  

l1: mov dl,[di]
    mov ah,02h
    inc di
    int 21h
    loop l1   ;循环l1
    mov ah,4ch  ;调用能够结束当前正在执行的程序，返回DOS系统，用于汇编程序的结束位置。
    int 21h

    p endp
code ends 
    end p