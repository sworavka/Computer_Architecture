module SignExtender(BusImm, Imm16, Ctrl);
    output reg [63:0] BusImm;
    input [25:0] Imm16;
    input [1:0] Ctrl;

    wire extBit;
    always @(Imm16,Ctrl) begin
        case (Ctrl)
            2'b00: BusImm = {{(64-12){Imm16[11]}}, Imm16[11:0]};
            2'b01: BusImm = {{(64-9){Imm16[20]}}, Imm16[20:12]};
            2'b10: BusImm = {{(64-25){Imm16[25]}}, Imm16[25:0]};
            2'b11: BusImm = {{(64-19){Imm16[23]}}, Imm16[23:5]};
            default: BusImm = 64'b0;
        endcase
    end
endmodule