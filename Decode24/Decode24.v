module Decode24 (out, in);
    input[1:0] in;
    output[3:0] out;
// assign each bit individually
assign out[0] = (in==2'b00) ? 1:0;
assign out[1] = (in==2'b01) ? 1:0;
assign out[2] = (in==2'b10) ? 1:0;
assign out[3] = (in==2'b11) ? 1:0;
endmodule
