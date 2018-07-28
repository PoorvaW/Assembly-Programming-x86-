Section .data
msg1: db "Menu",0x0A
	db "1. Number of Spaces",0x0A
	db "2. Number of Enters",0x0A	
	db "3. Occurence of Character",0x0A
	db "4. Exit",0x0A
len1: equ $-msg1

msg: db "EXITING!INVALID INPUT",0x0A
len: equ $-msg

msg2: db "OPENING SUCCESSFUL",0x0A
len2: equ $-msg2

msg3: db "OPENING UNSUCCESSFUL",0x0A
len3: equ $-msg3


fname: db 'file.txt',0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Section .bss

Section .bss
global buffer,buf_len

buffer: resb 1000
fd_in: resb 8
buf_len: resb 8
choice: resb 2

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Section .text
global main
main:

extern space,enter,occurence

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

MOV qword[buf_len],rax



print msg1,len1
read choice,2


CMP byte[choice],31H
JE next1
CMP byte[choice],32H
JE next2
CMP byte[choice],33H
JE next3
CMP byte[choice],34H
JE exit
print msg,len
JMP exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
next1:
CALL space

JMP exit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
next2:
CALL enter
JMP exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
next3:
CALL occurence

JMP exit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

exit:

MOV rax,3
MOV rdi,[fd_in]
Syscall



MOV rax,60
MOV rdi,0
Syscall

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
