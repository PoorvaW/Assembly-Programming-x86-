Section .data

msg1: db "We are working in protected mode",0x0A
len1: equ $-msg1

msg2: db "Content of MSW is: ",0x0A
len2: equ $-msg2

msg3: db "Content of GDTR is: ",0x0A
len3: equ $-msg3

msg4: db "Content of LDTR is: ",0x0A
len4: equ $-msg4

msg5: db "Content of IDTR is: ",0x0A
len5: equ $-msg5

msg6: db "Content of TR is: ",0x0A
len6: equ $-msg6
count: db 0

nl: db "",0x0A
lnl: equ $-nl

lim: db "LIMIT: "
llim: equ $-lim

base: db " BASE: "
lbase: equ $-base

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Section .bss
g: resb 6
m: resb 4
temp: resb 4
i: resb 6
l: resb 2
t: resb 2


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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Section .text
global main
main:

;;;;;;;;;;;;;;;;;MSW;;;;;;;;;;;;;;;;

SMSW eax
MOV dword[m],eax
BT eax,0
JC next
JMP exit
next:
print msg1,len1


print nl,lnl
print msg2,len2
MOV rsi,m
ADD rsi,2
MOV eax,0
MOV ax,word[rsi]
CALL hta

MOV rsi,m
MOV eax,0
MOV ax,word[rsi]
CALL hta

;;;;;;;;;;;;;;;END MSW;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;GDTR;;;;;;;;;;;;;

sgdt [g]
print nl,lnl
print nl,lnl
print msg3,len3
print lim,llim


MOV rsi,g+4
MOV eax,0
MOV ax,word[rsi]
CALL hta

print base,lbase
MOV rsi,g+2
MOV eax,0
MOV ax,word[rsi]
CALL hta

MOV rsi,g
MOV eax,0
MOV ax,word[rsi]
CALL hta

;;;;;;;;;;;;;;;;END GDTR;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;IDTR;;;;;;;;;;;;;;;;;;;;;
sidt [i]
print nl,lnl
print nl,lnl
print msg5,len5
MOV rsi,i+4
MOV eax,0
MOV ax,word[rsi]
CALL hta

MOV rsi,i+2
MOV eax,0
MOV ax,word[rsi]
CALL hta

MOV rsi,i
MOV eax,0
MOV ax,word[rsi]
CALL hta
;;;;;;;;;;;;;;;END IDTR;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;LDTR;;;;;;;;;;;;;;;;;;;;;

sldt [l]
print nl,lnl
print nl,lnl
print msg4,len4
mov eax,0
mov ax,word[l]
CALL hta

;;;;;;;;;;;;;;;END LDTR;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;TR;;;;;;;;;;;;;;;;;;;;;



str [t]
print nl,lnl
print nl,lnl
print msg6,len6
mov eax,0
mov ax,word[t]
CALL hta
print nl,lnl
print nl,lnl
;;;;;;;;;;;;;;;END TR;;;;;;;;;;;;;;;;;;


JMP exit

hta:
MOV rdi,temp
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
print temp,4


RET



exit:
MOV rax,60
MOV rdi,0
Syscall


