module HalfAdd(Cout, Sum, A, B);
	input A,B;
	output Cout, Sum;
//xor ensures the carry bit isn't counted
xor(Sum,A,B);
//only carry when needed
and(Cout,A,B);
endmodule