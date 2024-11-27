module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch);
	input [63:0] CurrentPC, SignExtImm64;
	input Branch, ALUZero, Uncondbranch;
	output reg [63:0] NextPC;
	always @(*) begin
		#1;
		if((Branch && ALUZero)||(Uncondbranch && !ALUZero)) begin 
			#2;
			NextPC = CurrentPC + (SignExtImm64 << 2);
		end
		else begin
			#1;
			NextPC = CurrentPC + 4;
		end
	end
endmodule
