module Mux21(out,in,sel);
   input [1:0] in;
   input sel;
   output out;
wire and1,and2,not_sel,or1;
// only allow in[1] truth through if selected output
and(and1,in[1],sel);
// only allow in[0] truth through if selected output
not(not_sel,sel);
and(and2,in[0],not_sel);
// output true if any truth was let through
or(out,and1,and2);
endmodule