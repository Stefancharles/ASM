DATA SEGMENT
BUF   DB   20         ;存放最大字符个数20个
         DB   ?             ;存放实际输入字符个数
         DB   20 DUP(?)  ;存放输入字符
DATA ENDS
CODE SEGMENT
  ASSUME CS:CODE,DS:DATA
START:
   MOV   AX,DATA   ;缓冲区所在段基址
   MOV  DS,AX
   LEA  DX,BUF    ;缓冲区首址偏移地址
   MOV  AH,0AH
   INT  21H   
   MOV  AH,4CH
   INT  21H
CODE ENDS
     END  START    