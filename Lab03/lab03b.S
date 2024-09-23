.globl lab03b
// word UIN = 31;
lab03b:
	ADRP X3, UIN
	ADD X3, X3, :lo12:UIN
	LDUR X2, [X3, #0]
	MOV X1, #10
loop:
	CBZ X1, finish
	SUB X2, X2, #1
	SUB X1, X1, #1
	B loop
finish:
	STUR X2, [X3, #0]
	BR X30
.section .data
UIN: .word 31
