Section .data

msg1: db "Array is: ",0x0A
len1: equ $-msg1

array: dw 0x1234,0xA812,0x0231,0x83A3,0x1223,0xF12D,0x3331,0x6281,0xDCB2,0x7628,0x0A

msg: db "0x1234,0xA812,0x0231,0x83A3,0x1223,0xF12D,0x3331,0x62G1,0xDCB2,0x7628",0x0A
len: equ $-msg

msg2: db "Number of positive nos. is ",0x0A
len2: equ $-msg2

msg3: db "Number of negative nos. is ",0x0A
len3: equ $-msg3

neg: db 0
pos: db 0
count: db 10
var: db 0x0A

Section .text
global main
main:

mov rax,1
mov rdi,1
mov rsi,msg1
mov rdx,len1
Syscall

mov rax,1
mov rdi,1
mov rsi,msg
mov rdx,len
Syscall

mov rsi,array

up:
mov ax,word[rsi]
BT ax,15
JC next
INC byte[pos]
add rsi,2
DEC byte[count]
JNZ up
JZ end

next:
INC byte[neg]
add rsi,2
DEC byte[count]
JNZ up

end:
CMP byte[pos],9
jbe next1
ADD byte[pos],7H

next1:
ADD byte[pos],30H

CMP byte[neg],9
jbe next2
ADD byte[neg],7H

next2:
ADD byte[neg],30H

mov rax,1
mov rdi,1
mov rsi,msg2
mov rdx,len2
Syscall



mov rax,1
mov rdi,1
mov rsi,pos
mov rdx,1
Syscall

mov rax,1
mov rdi,1
mov rsi,var
mov rdx,1
Syscall

mov rax,1
mov rdi,1
mov rsi,msg3
mov rdx,len3
Syscall



mov rax,1
mov rdi,1
mov rsi,neg
mov rdx,1
Syscall

mov rax,1
mov rdi,1
mov rsi,var
mov rdx,1
Syscall

mov rax,60
mov rdi,0
Syscall




