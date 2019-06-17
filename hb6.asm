DATA   SEGMENT
CSBAK   DW ?
IPBAK  DW ?
MKBAK   DB ?
DATA   ENDS
 
CODE    SEGMENT
        ASSUME CS:CODE,DS:DATA
START   PROC FAR
        MOV         AX,DATA
        MOV         DS,AX
        IN     AL,21H          ;保留8259初始屏蔽字的状态
        MOV         MKBAK,AL
        CLI                     ;关中断
        AND     AL,11111101B        ;打开键盘屏蔽
        OUT         21h,AL
        MOV         AX,0     ;修改键盘中断的中断矢量
        MOV         ES,AX
        MOV         DI,24H              ;IRQ1,09H,24H=09H*4
        MOV         AX,ES:[DI]
        MOV         IPBAK,AX            ;写入IP
        MOV         AX,OFFSET MYINT
        CLD
        STOSW
        MOV         AX,ES:[DI]      ;写入CS
        MOV         CSBAK,AX
        MOV         AX,SEG MYINT
        STOSW
        XOR         DX,DX           ;清计数器
 A1: STI                     ;开中断
        CMP         DX,10H              ;是否按了8次键
        JZ      A2              ;是，结束程序运行
        JMP         A1              ;否则继续等待键盘中断
A2:  PUSH        DX              ;保存计数值
CLI                     ;关中断
        MOV         AX,0                ;恢复系统中断矢量
        MOV         ES,AX
        MOV         DI,24H            ;IRQ1,09H
        MOV         AX,IPBAK
        CLD
        STOSW
        MOV         AX,CSBAK
        STOSW
        MOV         AL,MKBAK            ;恢复系统8259屏蔽字
        OUT         21h,AL
        STI                         ;开中断
        POP         DX              ;显示计数值
        CALL        SHWORD
        MOV         AX,4C00H
        INT         21H
        RET
       START   ENDP
MYINT   PROC    FAR                 ;自定义键盘中断处理程序
        STI                     ;开中断
        INC     DX              ;计数加一
        IN      AL,60H              ;读入扫描码（用户可对此键值进行处理）
        PUSH    DX
        MOV     DL,AL
        CALL    SHWORD
        POP     DX
        IN      AL,61H              ;读入控制字节
        MOV     AH,AL
        OR      AL,80H
        OUT     61H,AL              ;复位键盘
        CLI                                  ;关中断
        MOV     AL,20H              ;中断结束命令送中断控制器
        OUT 20H,AL
        IRET                        ;中断返回
MYINT   ENDP
SHWORD  PROC    NEAR                    ;2→16进制显示
        MOV     CX,4
AGA:    ROL     DX,1
              ROL     DX,1
              ROL     DX,1
              ROL     DX,1
              MOV     AL,DL
             AND     AL,0FH
             CMP     AL,10
            JC      NEXT2
            ADD     AL,7
NEXT2:  ADD     AL,30H
        MOV     AH,0EH
        INT     10H
        LOOP    AGA
        MOV     DL,0AH
        MOV     AH,02H
        INT     21H
        MOV     DL,0DH
        MOV     AH,02H
        INT     21H
    RET
SHWORD  ENDP
CODE ENDS
     END START