// ARMv8 Assembly file containing "test" function.

//Note that by default C passes the first two arguments to a function
//call in registers X0 and X1 respectively.
	

	.globl test          	// Defining the symbol "test" for the
				// linker
test:
	LSR 	X1, X0, #5
	LSR	X2, X0, #5
        ADD	X0, X1, X2      // Perform the actual addition
	br	X30
