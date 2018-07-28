Section .data
msg1: db "Menu",0x0A
	db "1. Hexadecimal to BCD",0x0A
	db "2. BCD to Hexadecimal ",0x0A	
	db "3.Exit",0x0A
len1: equ $-msg1

msg2: db "Enter Hexadecimal Number",0x0A
len2: equ $-msg2

msg3: db "Enter BCD Number",0x0A
len3: equ $-msg3

msg: db "EXITING!INVALID INPUT",0x0A
len: equ $-msg

count: db 4
remcount: db 0
result: dd 0x00000000


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Section .bss
choice: resb 2
h: resb 5
b: resb 6
temp: resb 4

ha: resb 1


%macro print 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
Syscall
%endmacro

%macro read 2
mov rax,0
mov rdi,0
mov rsi,%1
mov rdx,%2
Syscall
%endmacro

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

next1:
print msg2,len2
read h,5
CALL ath

MOV byte[remcount],0
MOV bx,0x0A

x1:
MOV dx,0
DIV bx
PUSH dx
INC byte[remcount]
CMP ax,0
JNE x1

x2:
POP dx
ADD dx,30H
MOV word[ha],dx
print ha,2
DEC byte[remcount]
JNZ x2

JMP main
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

next2:
print msg3,len3
read b,6
CALL ath1



mov ebx,eax
and eax,0x0000000f
mov dx,0x01
mul dx
mov ecx,00000000H
add ecx,eax
ror ebx,4
mov eax,ebx
and eax,0x0000000f
mov dx,0x0A
mul dx
add ecx,eax
ror ebx,4
mov eax,ebx
and eax,0x0000000f
mov dx,0x64
mul dx
add ecx,eax
ror ebx,4
mov eax,ebx
and eax,0x0000000f
mov dx,0x3E8
mul dx
add ecx,eax
ror ebx,4
mov eax,ebx
and eax,0x0000000f
mov dx,0x2710
mul dx
add ecx,eax
CALL hta



JMP main
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ath:
MOV ax,00
MOV rsi,h
MOV byte[count],4
up:
ROL ax,4
MOV bl,byte[rsi]
CMP bl,39H
jbe next
SUB bl,7
next:
SUB bl,30H
ADD al,bl
INC rsi
DEC byte[count]
JNZ up
RET

ath1:
MOV eax,00000000
MOV rsi,b
MOV byte[count],5
up1:
ROL eax,4
MOV bl,byte[rsi]
SUB bl,30H
ADD al,bl
INC rsi
DEC byte[count]
JNZ up1
RET

hta:

mov byte[count],4
mov rsi,temp
up4:
rol cx,04
MOV dl,cl
and dl,0x0F
cmp dl,09
jbe next5
add dl,07
next5:
add dl,30H
mov byte[rsi],dl
inc rsi
dec byte[count]
jnz up4
print temp,4
RET


exit:
MOV rax,60
MOV rdi,0
Syscall



%ifdef
	OUTPUT
poorva@poorva-VirtualBox:~/MPL$ nasm -f elf64 Assignment3.asm
poorva@poorva-VirtualBox:~/MPL$ ld -o A3 Assignment3.o
ld: warning: cannot find entry symbol _start; defaulting to 00000000004000b0
poorva@poorva-VirtualBox:~/MPL$ ./A3
Menu
1. Hexadecimal to BCD
2. BCD to Hexadecimal 
3.Exit
1
Enter Hexadecimal Number
1234
4660Menu
1. Hexadecimal to BCD
2. BCD to Hexadecimal 
3.Exit
2
Enter BCD Number
04660
1234Menu
1. Hexadecimal to BCD
2. BCD to Hexadecimal 
3.Exit
3

%endif
