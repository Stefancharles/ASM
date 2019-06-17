data segment 
num1      dw    1199H
num2      dw    1166H
sum       dw    ? 
data ends
code   segment  'code'
       assume   cs:code,ds:code,ss:code,es:code
org   100H
begin:    jmp   main

main      proc  near
          mov   ax,data
          mov  ds,  ax
          mov   ax,  num1
          add   ax,  num2
          mov   sum, ax
          mov   ax,  4c00h
          int   21h
main      endp
code      ends
          end   begin
