Section .data
msg1: db 0x0A,"Menu",0x0A
	db "1. Successive Addition",0x0A
	db "2. Add and shift ",0x0A	
	db "3.Exit",0x0A
len1: equ $-msg1

msg2: db "Enter First Number",0x0A
len2: equ $-msg2

msg3: db "Enter Second Number",0x0A
len3: equ $-msg3

msg: db "EXITING!INVALID INPUT",0x0A
len: equ $-msg
count: db 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Section .bss
num1: resb 3
choice: resb 2
t1: resb 2
t2: resb 4

%macro print 2
MOV rax,1
MOV rdi,1
MOV rsi,%1
MOV rdx,%2
Syscall
%endmacro

%macro read 2
MOV rax,0
MOV rdi,0
MOV rsi,%1
MOV rdx,%2
Syscall
%endmacro

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Section .text
global main
main:

print msg1,len1
read choice,2

CMP byte[choice],31H
JE next1
CMP byte[choice],32H
JE next2
CMP byte[choice],33H
JE exit
print msg,len
JMP exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

next1:
print msg2,len2
read num1,3
CALL ath_2

MOV word[t1],0
MOV word[t1],ax

print msg3,len3
read num1,3
CALL ath_2

MOV bx,ax


MOV ax,0x0000000000000000
l1:
ADD ax,word[t1]
DEC bx
JNZ l1

CALL hta


JMP main
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
next2:
print msg2,len2
read num1,3
CALL ath_2
MOV word[t1],0
MOV word[t1],ax 

print msg3,len3
read num1,3
CALL ath_2

MOV bx,ax  ;;;;;multiplier in bx

MOV cx,word[t1] ;;;;;multiplicant in cx
MOV ax,0
MOV byte[count],8

x:
SHR bx,1
JNC xy
ADD ax,cx
xy:
SHL cx,1
DEC byte[count]
JNZ x

CALL hta

JMP main

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ath_2:
MOV ax,00
MOV rsi,num1
MOV byte[count],02
up:
ROL ax,04
MOV bl,byte[rsi]
CMP bl,39H
jbe n
SUB bl,07H
n:
SUB bl,30H
ADD al,bl
INC rsi
DEC byte[count]
JNZ up
RET


hta:
MOV rdi,t2
MOV byte[count],4
up2:
ROL ax,04
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
print t2,4

RET



exit:
MOV rax,60
MOV rdi,0
Syscall



