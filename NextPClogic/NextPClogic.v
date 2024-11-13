module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch);
	input [63:0] CurrentPC, SignExtImm64;
	input Branch, ALUZero, Uncondbranch;
	output [63:0] NextPC;
	always @(*) begin
		#1;
		if((Branch && ALUZero)||(Uncondbranch && !ALUZero0)) begin
			#2;
			nextPC = currentPC + (imm << 2);
		end
		else begin
			#1;
			nextPC = currentPC + 4;
		end
	end
endmodule
