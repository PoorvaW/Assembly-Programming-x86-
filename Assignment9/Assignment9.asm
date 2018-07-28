Section .data
msg1: db "Factorial is: ",0x0A
len1: equ $-msg1
count: db 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Section .bss
num: resb 1
ans: resb 8

%macro print 2
MOV rax,1
MOV rdi,1
MOV rsi,%1
MOV rdx,%2
Syscall
%endmacro



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Section .text

POP rsi
POP rsi

MOV rax,0
MOV rax,1

POP rsi
MOV ebx,0
MOV bl,byte[rsi]
SUB bl,30H

FACTORIAL:
MUL ebx
DEC bx
JNZ low
RET 

low:
CALL FACTORIAL
CALL htoa


print msg1,len1
print ans,8
JMP exit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
htoa:

MOV rdi,ans
MOV byte[count],8
up2:
ROL eax,04
MOV dl,al
AND dl,0FH
CMP dl,09H
jbe n2
ADD dl,07H
n2:
ADD dl,30H
MOV byte[rdi],dl
INC rdi
DEC byte[count]
JNZ up2


RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
exit:
MOV rax,60
MOV rdi,0
Syscall
