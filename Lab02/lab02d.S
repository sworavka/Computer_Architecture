.section .text
.globl lab02d

lab02d:
	ADD X0, X0, #1000
	ADRP X1, myvalue
	ADD X1, X1, :lo12:myvalue
	STUR X0, [X1, 0]
	mov X0, X5
	BR X30

.section .data

myvalue:
.byte 2
