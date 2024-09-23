.globl lab03c
lab03c:
	ADRP X3, my_array
	ADD X3, X3, :lo12:my_array
	MOV X1, #0
	MOV X4, #5
loop:
	CMP X1, #40
	BGE finish
	ADD X5, X3, X1
	STUR X4, [X5]
	ADD X1, X1, #4
	ADD X4, X4, #1
	B loop
finish:
	BR X30
.section .data
my_array: .space 40
