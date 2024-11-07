`timescale 1ns/1ps
module SignExtenderTest;
    task passTest;
        input [64:0] actualOut, expectedOut;
        input [1:0] testType;
        inout [7:0] passed;

        if(actualOut == expectedOut) begin $display("%s passed", testType); passed = passed + 1; end
        else $display("%s failed: %x should be %x", testType, actualOut, expectedOut);
    endtask
    task allPassed;
        input [7:0] passed;
        input [7:0] numTests;
        
        if(passed == numTests) $display ("All tests passed");
        else $display("Some tests failed");
    endtask
    reg [25:0] Imm16;
    reg [1:0] Ctrl;
    reg [7:0] passed;
    wire [63:0] BusImm;

    SignExtender uut (
        .Imm16(Imm16),
        .Ctrl(Ctrl),
        .BusImm(BusImm)
    );

    initial begin
        Imm16 = 0;
        Ctrl = 0;
        passed = 0;
        {Imm16, Ctrl} = {26'b01010100101001010101000101, 2'h0}; #40; passTest(BusImm, 64'b0000000000000000000000000000000000000000000000000000010101000101, "I-type", passed);
        {Imm16, Ctrl} = {26'b01001001010010101010101000, 2'h0}; #40; passTest(BusImm, 64'b1111111111111111111111111111111111111111111111111111101010101000, "I-type", passed);
        {Imm16, Ctrl} = {26'b11110000011001001001001000, 2'h0}; #40; passTest(BusImm, 64'b0000000000000000000000000000000000000000000000000000001001001000, "I-type", passed);
        {Imm16, Ctrl} = {26'b01011101001010101010101010, 2'h0}; #40; passTest(BusImm, 64'b1111111111111111111111111111111111111111111111111111101010101010, "I-type", passed);
        {Imm16, Ctrl} = {26'b01010101110001001001001001, 2'h0}; #40; passTest(BusImm, 64'b0000000000000000000000000000000000000000000000000000001001001001, "I-type", passed);
        {Imm16, Ctrl} = {26'b01010101010101010010101101, 2'h1}; #40; passTest(BusImm, 64'b1111111111111111111111111111111111111111111111111111111101010101, "D-type", passed);
        {Imm16, Ctrl} = {26'b01110001110000100010010001, 2'h1}; #40; passTest(BusImm, 64'b0000000000000000000000000000000000000000000000000000000001110000, "D-type", passed);
        {Imm16, Ctrl} = {26'b01010101011111001001000100, 2'h1}; #40; passTest(BusImm, 64'b1111111111111111111111111111111111111111111111111111111101011111, "D-type", passed);
        {Imm16, Ctrl} = {26'b10010010010101001001010010, 2'h1}; #40; passTest(BusImm, 64'b0000000000000000000000000000000000000000000000000000000010010101, "D-type", passed);
        {Imm16, Ctrl} = {26'b10010010010010101010011010, 2'h1}; #40; passTest(BusImm, 64'b0000000000000000000000000000000000000000000000000000000010010010, "D-type", passed);
        {Imm16, Ctrl} = {26'b01011010010010010010010010, 2'h2}; #40; passTest(BusImm, 64'b0000000000000000000000000000000000000001011010010010010010010010, "B-type", passed);
        {Imm16, Ctrl} = {26'b00100100101001010101111111, 2'h2}; #40; passTest(BusImm, 64'b0000000000000000000000000000000000000000100100101001010101111111, "B-type", passed);
        {Imm16, Ctrl} = {26'b00000100000000000000000000, 2'h2}; #40; passTest(BusImm, 64'b0000000000000000000000000000000000000000000100000000000000000000, "B-type", passed);
        {Imm16, Ctrl} = {26'b11111111111110111111111110, 2'h2}; #40; passTest(BusImm, 64'b1111111111111111111111111111111111111111111111111110111111111110, "B-type", passed);
        {Imm16, Ctrl} = {26'b01001010101001010101010101, 2'h2}; #40; passTest(BusImm, 64'b0000000000000000000000000000000000000001001010101001010101010101, "B-type", passed);
        {Imm16, Ctrl} = {26'b00000000111111111110000000, 2'h3}; #40; passTest(BusImm, 64'b0000000000000000000000000000000000000000000000000001111111111100, "CB-type", passed);
        {Imm16, Ctrl} = {26'b10101010010010101010010101, 2'h3}; #40; passTest(BusImm, 64'b1111111111111111111111111111111111111111111111010100100101010100, "CB-type", passed);
        {Imm16, Ctrl} = {26'b10010101010101010101001001, 2'h3}; #40; passTest(BusImm, 64'b0000000000000000000000000000000000000000000000101010101010101010, "CB-type", passed);
        {Imm16, Ctrl} = {26'b01010010100101010010101001, 2'h3}; #40; passTest(BusImm, 64'b0000000000000000000000000000000000000000000000100101001010100101, "CB-type", passed);
        {Imm16, Ctrl} = {26'b00000000011111010110010001, 2'h3}; #40; passTest(BusImm, 64'b0000000000000000000000000000000000000000000000000000111110101100, "CB-type", passed);
        #10
        allPassed(passed, 20);
    end
    initial begin
        $dumpfile("SignExtenderTest.vcd");
        $dumpvars(0, SignExtenderTest);
    end
endmodule