Section .data

f: db "File contents are:",0x0A
lf: equ $-f

msg1: db "Menu",0x0A
	db "1. Ascending Order",0x0A
	db "2. Descending Order",0x0A	
	db "3. Exit",0x0A
len1: equ $-msg1

msg: db "EXITING!INVALID INPUT",0x0A
len: equ $-msg

msg2: db "OPENING SUCCESSFUL",0x0A
len2: equ $-msg2

msg3: db "OPENING UNSUCCESSFUL",0x0A
len3: equ $-msg3

fname: db 'file.txt',0


Section .bss
choice: resb 2
buffer: resb 1000
fd_in: resb 8
buf_len: resb 8
ocount: resb 1
icount: resb 1

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

MOV rax,2
MOV rdi,fname
MOV rsi,2
MOV rdx,0777
Syscall

MOV qword[fd_in],rax
BT rax,63
JNC next
print msg3,len3
JMP exit

next:
print msg2,len2
MOV rax,0
MOV rdi,[fd_in]
MOV rsi,buffer
MOV rdx,1000
Syscall

DEC rax

MOV qword[buf_len],rax

print f,lf
print buffer,[buf_len]

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
next1:
CALL asc
JMP exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
next2:
CALL dsc
JMP exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asc:
MOV byte[ocount],5

q:
MOV byte[icount],4
MOV rsi,buffer
MOV rdi,buffer+1

k:
MOV bl,byte[rdi]
CMP byte[rsi],bl
JBE qw
MOV cl,byte[rsi]
MOV dl,byte[rdi]
MOV byte[rsi],dl
MOV byte[rdi],cl

qw:
ADD rsi,1
ADD rdi,1
DEC byte[icount]
JNZ k
DEC byte[ocount]
JNZ q

print buffer,[buf_len]


MOV rax,1
MOV rdi,[fd_in]
MOV rsi,buffer
MOV rdx,qword[buf_len]
Syscall

RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

dsc:
MOV byte[ocount],5


d:
MOV byte[icount],4
MOV rsi,buffer
MOV rdi,buffer+1

h:
MOV bl,byte[rdi]
CMP byte[rsi],bl
JAE op
MOV cl,byte[rsi]
MOV dl,byte[rdi]
MOV byte[rsi],dl
MOV byte[rdi],cl

op:
ADD rsi,1
ADD rdi,1
DEC byte[icount]
JNZ h
DEC byte[ocount]
JNZ d

print buffer,buf_len


MOV rax,1
MOV rdi,[fd_in]
MOV rsi,buffer
MOV rdx,qword[buf_len]
Syscall


RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

exit:
MOV rax,3
MOV rdi,[fd_in]
Syscall



MOV rax,60
MOV rdi,0
Syscall
