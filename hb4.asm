data segment
array dw 12,11,22,33,44,55,66,77,88,99,111,222,333
number dw 55
low_idx dw ?
high_idx dw ?
data ends 
code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax
lea di,array
mov ax,number
cmp ax,[di+2]
ja chk_last
lea si,[di+2]
je exit
stc
jmp exit
chk_last:
mov si,[di]
shl si,1
add si,di
cmp ax,[si]
jb search
je exit
stc
jmp exit
search:
mov low_idx,1
mov bx,[di]
mov high_idx,bx
mov bx,di
mid:
mov  cx, low_idx
mov  dx, high_idx
cmp cx, dx
ja no_match
add  cx, dx
shr  cx, 1
mov  si, cx
shl  si, 1
compare:
cmp  ax, [bx+si]
je   exit
ja   higher
dec  cx
mov  high_idx, cx
jmp  mid
higher:
inc  cx
mov  low_idx, cx
jmp  mid
no_match:
stc
exit:
mov ax,4c00h 
int  21h 
code ends 
end start