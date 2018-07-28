Section .data
radius: dd 100.00

msg: db "Area is: "
len: equ $-msg

arraycnt: dw 05
point: db '.'
mul: dq 100
newline: db 0x0A
;;;;;;;;;;;;;;;;;;;;;;;;;;
Section .bss
area: resd 1
count: resb 1
ans: resb 2
cnt: resb 1
buffer: resb 10

%macro print 2
MOV rax,1
MOV rdi,1
MOV rsi,%1
MOv rdx,%2
Syscall
%endmacro
;;;;;;;;;;;;;;;;;;;;;;;;;

Section .text
global main
main:

FINIT
FLDZ
FLDPI
FMUL dword[radius]
FMUL dword[radius]
FST dword[area]
print msg,len
CALL display

JMP exit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
display:
FIMUL dword[mul]
FBSTP tword[buffer]

MOV rsi,buffer
ADD rsi,9
MOV byte[count],9
xy:
MOV cl,byte[rsi]
push rsi
CALL htoa_2
POP rsi
DEC rsi
DEC byte[count]
JNZ xy
print point,1
MOV cl,byte[buffer]
CALL htoa_2
print newline,1
RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
htoa_2:
MOV rdi,ans
MOV byte[cnt],2
uv:
ROL cl,04
MOV dl,cl
AND dl,0FH
CMP dl,09
JBE hi
ADD dl,07
hi:
ADD dl,30H
MOV byte[rdi],dl
INC rdi
DEC byte[cnt]
JNZ uv
print ans,2

RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
exit:
MOV rax,60
MOV rdi,0
Syscall
