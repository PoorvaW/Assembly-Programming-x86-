Section .data
msg1: db "Menu",0x0A
	db "1.Non-Overlapping without String",0x0A
	db "2.Non-Overlapping with String",0x0A
	db "3.Overlapping without String",0x0A
	db "4.Overlapping with String",0x0A
	db "5.Exit",0x0A
len1: equ $-msg1
let: db " : "
letl: equ $-let
nl: db "",0x0A
lnl: equ $-nl

msg4: db "After Copying: ",0x0A
len4: equ $-msg4

count: db 5
count1: db 5
count2: db 16
count3: db 5
count4: db 5
countn: db 5

msg2: db "EXITING!INVALID INPUT",0x0A
len2: equ $-msg2

msg3: db "Original Array is: ",0x0A
len3: equ $-msg3

array: dq 0x1234AAAABBBBCCCC,0x7654CDCDAFAFBBBB,0x1234567812345678,0xABCDABCDEFEFEFEF,0x9876543210ABCDBC,0x0,0x0,0x0,0x0,0x0
temp: dq 0x1234AAAABBBBCCCC,0x7654CDCDAFAFBBBB,0x1234567812345678,0xABCDABCDEFEFEFEF,0x9876543210ABCDBC,0x0,0x0,0x0,0x0,0x0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Section .bss
choice: resb 2
b: resb 16

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
JE next3
CMP byte[choice],34H
JE next4
CMP byte[choice],35H
JE exit
print msg2,len2
JMP exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

next1:
print msg3,len3
mov rsi,array
mov byte[count],5

up1:
MOV rbx,rsi
PUSH rsi
CALL hta
print let,letl
POP rsi
MOV rbx,qword[rsi]
PUSH rsi
CALL hta
print nl,lnl
POP rsi
ADD rsi,8
DEC byte[count]
JNZ up1

MOV rsi,array
MOV rdi,array+40
MOV byte[count1],5
up2:
MOV rcx,qword[rsi]
MOV qword[rdi],rcx
ADD rsi,8
ADD rdi,8
dec byte[count1]
JNZ up2

print nl,lnl
print msg4,len4

MOV rsi,array
MOV byte[count3],5
z:
MOV rbx,rsi
PUSH rsi
CALL hta
print let,letl
POP rsi
MOV rbx,qword[rsi]
PUSH rsi
CALL hta
print nl,lnl
POP rsi
ADD rsi,8
DEC byte[count3]
JNZ z

print nl,lnl

MOV rsi,array+40
MOV byte[count4],5
y:
MOV rbx,rsi
PUSH rsi
CALL hta
print let,letl
POP rsi
MOV rbx,qword[rsi]
PUSH rsi
CALL hta
print nl,lnl
POP rsi
ADD rsi,8
DEC byte[count4]
JNZ y

JMP main

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

next2:
print msg3,len3
mov rsi,array
mov byte[count],5

pq:
MOV rbx,rsi
PUSH rsi
CALL hta
print let,letl
POP rsi
MOV rbx,qword[rsi]
PUSH rsi
CALL hta
print nl,lnl
POP rsi
ADD rsi,8
DEC byte[count]
JNZ pq

MOV rsi,array
MOV rdi,array+40
MOV byte[count1],5
pq1:
MOVSQ
dec byte[count1]
JNZ pq1

print nl,lnl
print msg4,len4

MOV rsi,array
MOV byte[count3],5
pq2:
MOV rbx,rsi
PUSH rsi
CALL hta
print let,letl
POP rsi
MOV rbx,qword[rsi]
PUSH rsi
CALL hta
print nl,lnl
POP rsi
ADD rsi,8
DEC byte[count3]
JNZ pq2

print nl,lnl

MOV rsi,array+40
MOV byte[count4],5
pq3:
MOV rbx,rsi
PUSH rsi
CALL hta
print let,letl
POP rsi
MOV rbx,qword[rsi]
PUSH rsi
CALL hta
print nl,lnl
POP rsi
ADD rsi,8
DEC byte[count4]
JNZ pq3

JMP main


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
next3:

print msg3,len3
mov rsi,array
mov byte[count],5

xy:
MOV rbx,rsi
PUSH rsi
CALL hta
print let,letl
POP rsi
MOV rbx,qword[rsi]
PUSH rsi
CALL hta
print nl,lnl
POP rsi
ADD rsi,8
DEC byte[count]
JNZ xy

MOV rsi,array
MOV rdi,array+50
MOV byte[count1],5
xy1:
MOV rcx,qword[rsi]
MOV qword[rdi],rcx
ADD rsi,8
ADD rdi,8
dec byte[count1]
JNZ xy1


MOV rsi,array+50
MOV rdi,array+24
MOV byte[countn],5
xy3:
MOV rcx,qword[rsi]
MOV qword[rdi],rcx
ADD rsi,8
ADD rdi,8
dec byte[countn]
JNZ xy3


print nl,lnl
print msg4,len4

MOV rsi,array
MOV byte[count3],8
xy2:
MOV rbx,rsi
PUSH rsi
CALL hta
print let,letl
POP rsi
MOV rbx,qword[rsi]
PUSH rsi
CALL hta
print nl,lnl
POP rsi
ADD rsi,8
DEC byte[count3]
JNZ xy2
JMP main


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

next4:
print msg3,len3
mov rsi,array
mov byte[count],5

jk:
MOV rbx,rsi
PUSH rsi
CALL hta
print let,letl
POP rsi
MOV rbx,qword[rsi]
PUSH rsi
CALL hta
print nl,lnl
POP rsi
ADD rsi,8
DEC byte[count]
JNZ jk

MOV rsi,array
MOV rdi,array+50
MOV byte[count1],5
jk1:
MOVSQ
dec byte[count1]
JNZ jk1


MOV rsi,array+50
MOV rdi,array+24
MOV byte[countn],5
jk3:
MOVSQ
dec byte[countn]
JNZ jk3


print nl,lnl
print msg4,len4

MOV rsi,array
MOV byte[count3],8
jk2:
MOV rbx,rsi
PUSH rsi
CALL hta
print let,letl
POP rsi
MOV rbx,qword[rsi]
PUSH rsi
CALL hta
print nl,lnl
POP rsi
ADD rsi,8
DEC byte[count3]
JNZ jk2
JMP main




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


hta:
mov rdi,b
mov byte[count2],16
up3:
rol rbx,04
mov dl,bl
AND dl,0FH
CMP dl,09
jbe a
ADD dl,07H
a:
ADD dl,30H
MOV byte[rdi],dl
inc rdi
dec byte[count2]
jnz up3
print b,16
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
exit:
mov rax,60
mov rdi,0
Syscall



%ifdef
	OUTPUT
poorva@poorva-VirtualBox:~/MPL$ nasm -f elf64 Assignment2.asm
poorva@poorva-VirtualBox:~/MPL$ ld -o A2 Assignment2.o
ld: warning: cannot find entry symbol _start; defaulting to 00000000004000b0
poorva@poorva-VirtualBox:~/MPL$ ./A2
Menu
1.Non-Overlapping without String
2.Non-Overlapping with String
3.Overlapping without String
4.Overlapping with String
5.Exit
1
Original Array is: 
0000000000600922 : 1234AAAABBBBCCCC
000000000060092A : 7654CDCDAFAFBBBB
0000000000600932 : 1234567812345678
000000000060093A : ABCDABCDEFEFEFEF
0000000000600942 : 9876543210ABCDBC

After Copying: 
0000000000600922 : 1234AAAABBBBCCCC
000000000060092A : 7654CDCDAFAFBBBB
0000000000600932 : 1234567812345678
000000000060093A : ABCDABCDEFEFEFEF
0000000000600942 : 9876543210ABCDBC

000000000060094A : 1234AAAABBBBCCCC
0000000000600952 : 7654CDCDAFAFBBBB
000000000060095A : 1234567812345678
0000000000600962 : ABCDABCDEFEFEFEF
000000000060096A : 9876543210ABCDBC
Menu
1.Non-Overlapping without String
2.Non-Overlapping with String
3.Overlapping without String
4.Overlapping with String
5.Exit
2
Original Array is: 
0000000000600922 : 1234AAAABBBBCCCC
000000000060092A : 7654CDCDAFAFBBBB
0000000000600932 : 1234567812345678
000000000060093A : ABCDABCDEFEFEFEF
0000000000600942 : 9876543210ABCDBC

After Copying: 
0000000000600922 : 1234AAAABBBBCCCC
000000000060092A : 7654CDCDAFAFBBBB
0000000000600932 : 1234567812345678
000000000060093A : ABCDABCDEFEFEFEF
0000000000600942 : 9876543210ABCDBC

000000000060094A : 1234AAAABBBBCCCC
0000000000600952 : 7654CDCDAFAFBBBB
000000000060095A : 1234567812345678
0000000000600962 : ABCDABCDEFEFEFEF
000000000060096A : 9876543210ABCDBC
Menu
1.Non-Overlapping without String
2.Non-Overlapping with String
3.Overlapping without String
4.Overlapping with String
5.Exit
3
Original Array is: 
0000000000600922 : 1234AAAABBBBCCCC
000000000060092A : 7654CDCDAFAFBBBB
0000000000600932 : 1234567812345678
000000000060093A : ABCDABCDEFEFEFEF
0000000000600942 : 9876543210ABCDBC

After Copying: 
0000000000600922 : 1234AAAABBBBCCCC
000000000060092A : 7654CDCDAFAFBBBB
0000000000600932 : 1234567812345678
000000000060093A : 1234AAAABBBBCCCC
0000000000600942 : 7654CDCDAFAFBBBB
000000000060094A : 1234567812345678
0000000000600952 : ABCDABCDEFEFEFEF
000000000060095A : 9876543210ABCDBC
Menu
1.Non-Overlapping without String
2.Non-Overlapping with String
3.Overlapping without String
4.Overlapping with String
5.Exit
4
Original Array is: 
0000000000600922 : 1234AAAABBBBCCCC
000000000060092A : 7654CDCDAFAFBBBB
0000000000600932 : 1234567812345678
000000000060093A : 1234AAAABBBBCCCC
0000000000600942 : 7654CDCDAFAFBBBB

After Copying: 
0000000000600922 : 1234AAAABBBBCCCC
000000000060092A : 7654CDCDAFAFBBBB
0000000000600932 : 1234567812345678
000000000060093A : 1234AAAABBBBCCCC
0000000000600942 : 7654CDCDAFAFBBBB
000000000060094A : 1234567812345678
0000000000600952 : 1234AAAABBBBCCCC
000000000060095A : 7654CDCDAFAFBBBB
Menu
1.Non-Overlapping without String
2.Non-Overlapping with String
3.Overlapping without String
4.Overlapping with String
5.Exit
5

%endif

