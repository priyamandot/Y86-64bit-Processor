//`include "1bit_fulladderwithM.v"
module subtractor_64bit(A,B,Sum,carry_overflow);
input [63:0]A;
input [63:0]B;
output [63:0] Sum;
output carry_overflow;
wire M;
assign M=1'b1;
wire [64:0] Cin;
assign Cin[0]=1'b1;

genvar iterator_sub;
generate
    for(iterator_sub=0;iterator_sub<64;iterator_sub=iterator_sub+1)begin
      full_subtractor_1bit inst3(A[iterator_sub],B[iterator_sub],Cin[iterator_sub],M,Sum[iterator_sub],Cin[iterator_sub+1]);
    end

endgenerate

assign carry_overflow=Cin[64];


endmodule