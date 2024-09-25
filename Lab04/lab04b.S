.globl lab04b

lab04b:
	SUB SP, SP, #16
	STUR LR, [SP, #8]
	STUR X0, [SP, #0]
	CBZ X0, base
	SUB X0, X0, #1
	BL lab04b
	LDUR X1, [SP, #0]
	BL my_mul
	B finish
base:
	ADD X0, X0, #1
finish:
	LDUR LR, [SP, #8]
	ADD SP, SP, #16
	BR LR
