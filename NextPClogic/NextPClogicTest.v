`timescale 1ns / 1ps

module NextPClogicTest;

    // Inputs
    reg [63:0] CurrentPC;
    reg [63:0] SignExtImm64;
    reg Branch;
    reg ALUZero;
    reg Uncondbranch;

    // Outputs
    wire [63:0] NextPC;

    // Instantiate the Unit Under Test (UUT)
    NextPClogic uut (
        .CurrentPC(CurrentPC),
        .SignExtImm64(SignExtImm64),
        .Branch(Branch),
        .ALUZero(ALUZero),
        .Uncondbranch(Uncondbranch),
        .NextPC(NextPC)
    );

    initial begin
        // Initialize Inputs
        CurrentPC = 0;
        SignExtImm64 = 0;
        Branch = 0;
        ALUZero = 0;
        Uncondbranch = 0;
        #10;

        // Test Case 1: Default next instruction
        CurrentPC = 64'h1000;
        SignExtImm64 = 64'h0;
        Branch = 0;
        ALUZero = 0;
        Uncondbranch = 0;
        #5; // Wait for delay to ensure processing
        $display("CurrentPC: %h, SignExtImm64: %h, Branch: %h, ALUZero: %h, Uncondbranch: %h, NextPC: %h", CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch, NextPC);
        if (NextPC !== 64'h1004) $display("Test Case 1 Failed: NextPC = %h", NextPC);
        else $display("Test Case 1 Passed: NextPC = %h", NextPC);
        
        // Test Case 2: Conditional branch taken
        CurrentPC = 64'h1000;
        SignExtImm64 = 64'h2;
        Branch = 1;
        ALUZero = 1;
        Uncondbranch = 0;
        #5; // Wait for delay to ensure processing
        $display("CurrentPC: %h, SignExtImm64: %h, Branch: %h, ALUZero: %h, Uncondbranch: %h, NextPC: %h", CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch, NextPC);
        if (NextPC !== 64'h1008) $display("Test Case 2 Failed: NextPC = %h", NextPC);
        else $display("Test Case 2 Passed: NextPC = %h", NextPC);

        // Test Case 3: Unconditional branch
        CurrentPC = 64'h1000;
        SignExtImm64 = 64'h1;
        Branch = 0;
        ALUZero = 0;
        Uncondbranch = 1;
        #5; // Wait for delay to ensure processing
        $display("CurrentPC: %h, SignExtImm64: %h, Branch: %h, ALUZero: %h, Uncondbranch: %h, NextPC: %h", CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch, NextPC);
        if (NextPC !== 64'h1004) $display("Test Case 3 Failed: NextPC = %h", NextPC);
        else $display("Test Case 3 Passed: NextPC = %h", NextPC);
        
        // Test Case 4: Conditional branch not taken
        CurrentPC = 64'h1000;
        SignExtImm64 = 64'h2;
        Branch = 1;
        ALUZero = 0;
        Uncondbranch = 0;
        #5; // Wait for delay to ensure processing
        $display("CurrentPC: %h, SignExtImm64: %h, Branch: %h, ALUZero: %h, Uncondbranch: %h, NextPC: %h", CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch, NextPC);
        if (NextPC !== 64'h1004) $display("Test Case 4 Failed: NextPC = %h", NextPC);
        else $display("Test Case 4 Passed: NextPC = %h", NextPC);

        $display("All test cases passed!");
    end
    initial begin
        $dumpfile("NextPClogicTest.vcd");
        $dumpvars(0, NextPClogicTest);
    end
endmodule