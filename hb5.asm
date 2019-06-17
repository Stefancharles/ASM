data  segment
      ary     dw  10,20,30,40,50,60,70,80,90,100
      count   dw  10
      sum     dw  ?
      table   dw  3  dup (?)         ; 地址表
data  ends
code  segment
main  proc   far
      assume cs:code, ds:data
      push   ds
      sub    ax, ax
      push   ax
      mov    ax, data
      mov    ds, ax  ;ds指向数据段
      mov    table,   offset  ary  ;取数组首地址放地址表第一个
      mov    table+2, offset  count;取计数的地址放第二个
      mov    table+4, offset  sum;取sum地址放第三个
      mov    bx, offset  table;地址表首地址送bx
      call   proadd
      ret
main  endp
proadd  proc  near
        push  ax
        push  cx
        push  si
        push  di  ;保存现场
        mov   si, [bx]
        mov   di, [bx+2]
        mov   cx, [di]
        mov   di, [bx+4]
        xor   ax, ax
next:    
        add   ax, [si]
        add   si, 2
        loop  next
        mov   [di],ax
        pop   di  ;恢复现场
        pop   si
        pop   cx
        pop   ax
        ret  ;返回调用
proadd  endp
code    ends
        end   main