`timescale 1ns / 1ps

`define STRLEN 32
module RegisterFileTest_v;
initial begin
        $dumpfile("RegisterFileTest.vcd");
        $dumpvars(0, RegisterFileTest_v);
    end

	task passTest;
		input [63:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [63:0] BusW;
	reg [4:0] RA;
	reg [4:0] RB;
	reg [4:0] RW;
	reg RegWr;
	reg Clk;
	reg [7:0] passed;

	// Outputs
	wire [63:0] BusA;
	wire [63:0] BusB;

	// Instantiate the Unit Under Test (UUT)
	MiniRegisterFile uut (
		.BusA(BusA), 
		.BusB(BusB), 
		.BusW(BusW), 
		.RA(RA), 
		.RB(RB), 
		.RW(RW), 
		.RegWr(RegWr), 
		.Clk(Clk)
	);

    integer i;
    initial begin
		Clk = 0;
		passed = 0;
        $display("Initializing registers to their respective numbers...");
        for(i=0;i<32;i=i+1)begin
            RW = i;
            if(i!=31)begin 
                BusW = i;
            end
            else begin 
                BusW = 0;
            end
            RegWr = 1;
            #5 Clk = 1; #5 Clk = 0;
        end
        RegWr = 0;

        {RA, RB, RW, BusW, RegWr} = {5'h0, 5'h1, 5'h0, 64'h0, 1'b0};
		#10
		passTest(BusA, 64'd0, "Initial value check 1", passed);
		passTest(BusB, 64'd1, "Initial value check 2", passed);
		#10; Clk = 0; #10; Clk = 1;

        {RA, RB, RW, BusW, RegWr} = {5'h2, 5'h3, 5'h1, 64'h1000, 1'b0};
		#10
		passTest(BusA, 64'd2, "Initial value check 3", passed);
		passTest(BusB, 64'd3, "Initial value check 4", passed);
		#10; Clk = 0; #10; Clk = 1;
        
        {RA, RB, RW, BusW, RegWr} = {5'h4, 5'h5, 5'h0, 64'h1000, 1'b1};
		#10
		passTest(BusA, 64'd4, "Initial value check 5", passed);
		passTest(BusB, 64'd5, "Initial value check 6", passed);
		#10; Clk = 0; #10; Clk = 1;

        {RA, RB, RW, BusW, RegWr} = {5'h6, 5'h7, 5'hA, 64'h1010, 1'b1};
		#10
		passTest(BusA, 64'd6, "Initial value check 7", passed);
		passTest(BusB, 64'd7, "Initial value check 8", passed);
		#10; Clk = 0; #10; Clk = 1;

        {RA, RB, RW, BusW, RegWr} = {5'h8, 5'h9, 5'hB, 64'h103000, 1'b1};
		#10
		passTest(BusA, 64'd8, "Initial value check 9", passed);
		passTest(BusB, 64'd9, "Initial value check 10", passed);
		#10; Clk = 0; #10; Clk = 1;

        {RA, RB, RW, BusW, RegWr} = {5'hA, 5'hB, 5'hC, 64'h0, 1'b0};
		#10
		passTest(BusA, 64'd4112, "Initial value check 11", passed);
		passTest(BusB, 64'd1060864, "Initial value check 12", passed);
		#10; Clk = 0; #10; Clk = 1;

        {RA, RB, RW, BusW, RegWr} = {5'hC, 5'hD, 5'hD, 64'hABCD, 1'b1};
		#10
		passTest(BusA, 64'd12, "Initial value check 13", passed);
		passTest(BusB, 64'd43981, "Initial value check 14", passed);
		#10; Clk = 0; #10; Clk = 1;

        {RA, RB, RW, BusW, RegWr} = {5'hE, 5'hF, 5'hE, 64'h9080009, 1'b0};
		#10
		passTest(BusA, 64'd14, "Initial value check 15", passed);
		passTest(BusB, 64'd15, "Initial value check 16", passed);
		#10; Clk = 0; #10; Clk = 1;

        allPassed(passed, 16);
        $finish;
    end
    always #5 Clk = ~Clk;
endmodule