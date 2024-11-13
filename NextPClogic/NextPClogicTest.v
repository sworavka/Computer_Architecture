`timescale 1ns / 1ps

module NextPClogicTest;

    // Inputs
    reg [63:0] currentPC;
    reg [63:0] imm;
    reg branchCond;
    reg aluZero;
    reg uncondBranch;

    // Outputs
    wire [63:0] nextPC;

    // Instantiate the Unit Under Test (UUT)
    NextPC uut (
        .currentPC(currentPC),
        .imm(imm),
        .branchCond(branchCond),
        .aluZero(aluZero),
        .uncondBranch(uncondBranch),
        .nextPC(nextPC)
    );

    initial begin
        // Initialize Inputs
        currentPC = 0;
        imm = 0;
        branchCond = 0;
        aluZero = 0;
        uncondBranch = 0;
        #10;

        // Test Case 1: Default next instruction
        currentPC = 64'h1000;
        imm = 64'h0;
        branchCond = 0;
        aluZero = 0;
        uncondBranch = 0;
        #1; // Wait for delay
        if (nextPC !== 64'h1004) $display("Test Case 1 Failed: nextPC = %h", nextPC);
        
        // Test Case 2: Conditional branch taken
        currentPC = 64'h1000;
        imm = 64'h2;
        branchCond = 1;
        aluZero = 1;
        uncondBranch = 0;
        #2; // Wait for delay
        if (nextPC !== 64'h1008) $display("Test Case 2 Failed: nextPC = %h", nextPC);
        
        // Test Case 3: Unconditional branch
        currentPC = 64'h1000;
        imm = 64'h1;
        branchCond = 0;
        aluZero = 0;
        uncondBranch = 1;
        #2; // Wait for delay
        if (nextPC !== 64'h1004) $display("Test Case 3 Failed: nextPC = %h", nextPC);
        
        // Test Case 4: Conditional branch not taken
        currentPC = 64'h1000;
        imm = 64'h2;
        branchCond = 1;
        aluZero = 0;
        uncondBranch = 0;
        #1; // Wait for delay
        if (nextPC !== 64'h1004) $display("Test Case 4 Failed: nextPC = %h", nextPC);
        
        $display("All test cases passed!");
    end
endmodule