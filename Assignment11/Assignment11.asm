Section .data

four: dq 04
two: dq 02

ff1: db "%lf + i%lf",10,0
ff2: db "%lf - i%lf",10,0

formatpf: db "%lf",10,0
formatsf: db "%lf",0

msg1: db "Enter a: "
len1: equ $-msg1

msg2: db "Enter b: "
len2: equ $-msg2

msg3: db "Enter c: "
len3: equ $-msg3

msg: db "Roots are: ",0x0A
len: equ $-msg

errormsg: db "a cannot be 0, try again!",0x0A
elen: equ $-errormsg

Section .bss
a: resq 1
b: resq 1
c: resq 1

bsquare: resq 1
fourac: resq 1
twoa: resq 1
discriminant: resq 1
real: resq 1
imag: resq 1
root1: resq 1
root2: resq 1
disroot: resq 1

%macro myprintf 1
MOV rdi,formatpf
SUB rsp,8
MOVSD xmm0,[%1]
MOV rax,1
CALL printf
ADD rsp,8
%endmacro

%macro myscanf 1
MOV rdi,formatsf
MOV rax,0
SUB rsp,8
MOV rsi,rsp
CALL scanf
MOV r8,qword[rsp]
MOV qword[%1],r8
ADD rsp,8
%endmacro

%macro print 2
MOV rax,1
MOV rdi,1
MOV rsi,%1
MOV rdx,%2
Syscall
%endmacro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Section .text
global main
main:

extern printf,scanf
print msg1,len1
myscanf a
CMP qword[a],0
JE low
JMP next
low:
print errormsg,elen
JMP main
next:
print msg2,len2
myscanf b
print msg3,len3
myscanf c

FINIT

	;;;;;b^2;;;;;
FLDZ 
FADD qword[b]
FMUL ST0
FST qword[bsquare]


	;;;;;4ac;;;;;
FLDZ
FILD qword[four]
FMUL qword[a]
FMUL qword[c]
FST qword[fourac]



	;;;;;;2a;;;;;;;
FLDZ
FILD qword[two]
FMUL qword[a]
FST qword[twoa]


	;;;;b^2-4ac;;;
FLDZ
FADD qword[bsquare]
FSUB qword[fourac]
FST qword[discriminant]
	BTR qword[discriminant],63
	JC imaginary
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;real roots;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FLDZ
FADD qword[discriminant]
FSQRT
FST qword[disroot]
print msg,len
FLDZ
FADD qword[disroot]
FSUB qword[b]
FDIV qword[twoa]
FSTP qword[root1]
myprintf root1

FLDZ
FSUB qword[disroot]
FSUB qword[b]
FDIV qword[twoa]
FSTP qword[root2]
myprintf root2
JMP exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;imaginary roots;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
imaginary:
FLDZ
FADD qword[discriminant]
FSQRT
FST qword[disroot]

FLDZ 
FSUB qword[b]
FDIV qword[twoa]
FSTP qword[real]

FLDZ 
FADD qword[disroot]
FDIV qword[twoa]
FSTP qword[imag]

print msg,len

MOV rdi,ff1
SUB rsp,8
MOVSD xmm0,qword[real]
MOVSD xmm1,qword[imag]
MOV rax,2
CALL printf
ADD rsp,8

MOV rdi,ff2
SUB rsp,8
MOVSD xmm0,qword[real]
MOVSD xmm1,qword[imag]
MOV rax,2
CALL printf
ADD rsp,8
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
exit:
MOV rax,60
MOV rdi,0
Syscall
