Section .data
mes: db "Enter Character",0x0A
lmes: equ $-mes

Section .bss
extern buffer,buf_len
count: resb 8
spc: resb 1

char: resb 2

%macro read 2
MOV rax,0
MOV rdi,0
MOV rsi,%1
MOV rdx,%2
Syscall
%endmacro


%macro print 2
MOV rax,1
MOV rdi,1
MOV rsi,%1
MOV rdx,%2
Syscall
%endmacro



Section .text
global main2
main2:
global space,enter,occurence

space:
MOV rcx,qword[buf_len]
MOV qword[count],rcx
MOV byte[spc],0
MOV rsi,buffer

up1:
MOV cl,byte[rsi]
CMP cl,20H
JNE l1
INC byte[spc]

l1:
INC rsi
DEC qword[count]
JNZ up1


ADD byte[spc],30H
print spc,1

RET

enter:
MOV rcx,qword[buf_len]
MOV qword[count],rcx
MOV byte[spc],0
MOV rsi,buffer

up2:
MOV cl,byte[rsi]
CMP cl,0x0A
JNE l2
INC byte[spc]

l2:
INC rsi
DEC qword[count]
JNZ up1

ADD byte[spc],30H
print spc,1
RET



occurence:
print mes,lmes
read char,2

MOV rcx,qword[buf_len]
MOV qword[count],rcx
MOV byte[spc],0
MOV rsi,buffer

up3:
MOV cl,byte[rsi]
CMP cl,byte[char]
JNE l3
INC byte[spc]

l3:
INC rsi
DEC qword[count]
JNZ up3

ADD byte[spc],30H
print spc,1
RET


htoa:

MOV rdi,spc
MOV qword[count],2
lab:
ROL cl,04
MOV dl,cl
AND dl,0FH
CMP dl,09
jbe lab1
ADD dl,07
lab1:
ADD dl,30H
MOV byte[rdi],dl
INC rdi
DEC qword[count]
JNZ lab
print spc,1

RET

exit:
MOV rax,60
MOV rdi,0
Syscall



