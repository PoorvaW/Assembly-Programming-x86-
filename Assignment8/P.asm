Section .data

f: db "File contents are:",0x0A
lf: equ $-f

msg: db "EXITING! NO MATCH FOUND",0x0A
len: equ $-msg

msg2: db "OPENING SUCCESSFUL",0x0A
len2: equ $-msg2

msg3: db "OPENING UNSUCCESSFUL",0x0A
len3: equ $-msg3

Section .bss
choice: resb 1
fname1: resb 10
fname2: resb 10
fname3: resb 10

buffer1: resb 1000
fd_in1: resb 8
buf_len1: resb 8

buffer2: resb 1000
fd_in2: resb 8
buf_len2: resb 8

buffer3: resb 1000
fd_in3: resb 8
buf_len3: resb 8


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
global main
main:

POP rsi
POP rsi
POP rsi
MOV rax,0
MOV al,byte[rsi]
MOV byte[choice],al
CMP byte[choice],74H
JE next1

CMP byte[choice],63H
JE next2

CMP byte[choice],64H
JE next3


print msg,len
JMP exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
next1:
POP rsi
MOV rdi,fname1

up:
MOV rax,0
MOV al,byte[rsi]
MOV byte[rdi],al
CMP byte[rsi],0
JE low
INC rsi
INC rdi
JMP up


low:
MOV rax,2
MOV rdi,fname1
MOV rsi,2
MOV rdx,0777
Syscall

MOV qword[fd_in1],rax
BT rax,63
JNC next
print msg3,len3
JMP exit

next:
print msg2,len2
MOV rax,0
MOV rdi,[fd_in1]
MOV rsi,buffer1
MOV rdx,1000
Syscall

MOV qword[buf_len1],rax
print f,lf
print buffer1,buf_len1

MOV rax,3
MOV rdi,[fd_in1]
Syscall

JMP exit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
next2:

POP rsi
MOV rdi,fname1

up1:
MOV rax,0
MOV al,byte[rsi]
MOV byte[rdi],al
CMP byte[rsi],0
JE low1
INC rsi
INC rdi
JMP up1


low1:
MOV rax,2
MOV rdi,fname1
MOV rsi,2
MOV rdx,0777
Syscall

MOV qword[fd_in1],rax


MOV rax,0
MOV rdi,[fd_in1]
MOV rsi,buffer1
MOV rdx,1000
Syscall

MOV qword[buf_len1],rax





POP rsi
MOV rdi,fname2

up2:
MOV rax,0
MOV al,byte[rsi]
MOV byte[rdi],al
CMP byte[rsi],0
JE low2
INC rsi
INC rdi
JMP up2

low2:
MOV rax,2
MOV rdi,fname2
MOV rsi,2
MOV rdx,0777
Syscall

MOV qword[fd_in2],rax


MOV rax,1
MOV rdi,[fd_in2]
MOV rsi,buffer1
MOV rdx,[buf_len1]
Syscall



JMP exit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
next3:


POP rsi
MOV rdi,fname3

up3:
MOV rax,0
MOV al,byte[rsi]
MOV byte[rdi],al
CMP byte[rsi],0
JE low3
INC rsi
INC rdi
JMP up3


low3:

MOV rax,87
MOV rdi,fname3
Syscall


JMP exit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

exit:
MOV rax,60
MOV rdi,0
Syscall


