`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:02:47 03/05/2009
// Design Name:   ALU
// Module Name:   E:/350/Lab8/ALU/ALUTest.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`define STRLEN 32
module ALUTest_v;

	task passTest;
		input [64:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %x should be %x", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [63:0] BusA;
	reg [63:0] BusB;
	reg [3:0] ALUCtrl;
	reg [7:0] passed;

	// Outputs
	wire [63:0] BusW;
	wire Zero;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.BusW(BusW), 
		.Zero(Zero), 
		.BusA(BusA), 
		.BusB(BusB), 
		.ALUCtrl(ALUCtrl)
	);

	initial begin
		// Initialize Inputs
		BusA = 0;
		BusB = 0;
		ALUCtrl = 0;
		passed = 0;

        // Here is one example test vector, testing the ADD instruction:
		// {BusA, BusB, ALUCtrl} = {64'h1234, 64'hABCD0000, 4'h2}; #40; passTest({Zero, BusW}, 65'h0ABCD1234, "ADD 0x1234,0xABCD0000", passed);
		//Reformate and add your test vectors from the prelab here following the example of the testvector above.	
		{BusA, BusB, ALUCtrl} = {64'h8, 64'h8, 4'h0}; #40; passTest({Zero, BusW}, {1'h0,64'h8}, "AND 0x8,0x8", passed);
		{BusA, BusB, ALUCtrl} = {64'h5, 64'h7, 4'h0}; #40; passTest({Zero, BusW}, {1'h0,64'h5}, "AND 0x5,0x7", passed);
		{BusA, BusB, ALUCtrl} = {64'h8, 64'h0, 4'h0}; #40; passTest({Zero, BusW}, {1'h1,64'h0}, "AND 0x8,0x0", passed);
		{BusA, BusB, ALUCtrl} = {64'h0, 64'h0, 4'h1}; #40; passTest({Zero, BusW}, {1'h1,64'h0}, "OR 0x0,0x0", passed);
		{BusA, BusB, ALUCtrl} = {64'h7, 64'h0, 4'h1}; #40; passTest({Zero, BusW}, {1'h0,64'h7}, "OR 0x7,0x0", passed);
		{BusA, BusB, ALUCtrl} = {64'h7, 64'h5, 4'h1}; #40; passTest({Zero, BusW}, {1'h0,64'h7}, "OR 0x7,0x5", passed);
		{BusA, BusB, ALUCtrl} = {64'h0, 64'h0, 4'h2}; #40; passTest({Zero, BusW}, {1'h1,64'h0}, "ADD 0x0,0x0", passed);
		{BusA, BusB, ALUCtrl} = {64'h5, 64'h5, 4'h2}; #40; passTest({Zero, BusW}, {1'h0,64'hA}, "ADD 0x5,0x5", passed);
		{BusA, BusB, ALUCtrl} = {64'h7, 64'h3, 4'h2}; #40; passTest({Zero, BusW}, {1'h0,64'hA}, "ADD 0x7,0x3", passed);
		{BusA, BusB, ALUCtrl} = {64'h5, 64'h5, 4'h6}; #40; passTest({Zero, BusW}, {1'h1,64'h0}, "SUB 0x5,0x5", passed);
		{BusA, BusB, ALUCtrl} = {64'h5, 64'h2, 4'h6}; #40; passTest({Zero, BusW}, {1'h0,64'h3}, "SUB 0x5,0x2", passed);
		{BusA, BusB, ALUCtrl} = {64'hB, 64'h8, 4'h6}; #40; passTest({Zero, BusW}, {1'h0,64'h3}, "SUB 0xB,0x8", passed);
		{BusA, BusB, ALUCtrl} = {64'h0, 64'h0, 4'h7}; #40; passTest({Zero, BusW}, {1'h1,64'h0}, "PASS 0x0,0x0", passed);
		{BusA, BusB, ALUCtrl} = {64'hB, 64'hF, 4'h7}; #40; passTest({Zero, BusW}, {1'h0,64'hF}, "PASS 0xB,0xF", passed);
		{BusA, BusB, ALUCtrl} = {64'h8, 64'h6, 4'h7}; #40; passTest({Zero, BusW}, {1'h0,64'h6}, "PASS 0x8,0x6", passed);
		allPassed(passed, 15);
	end
	initial begin
		$dumpfile("ALUTest.vcd");
		$dumpvars(0,ALUTest_v);
	end
      
endmodule

