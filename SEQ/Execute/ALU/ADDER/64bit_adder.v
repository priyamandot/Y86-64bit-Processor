//`include "1bit_adder.v"
module adder_64bit(A,B,Sum,carry_overflow);
input [63:0]A;
input [63:0]B;
output [63:0] Sum;
output carry_overflow;


wire [64:0] Cin;
assign Cin[0]=1'b0;

genvar iterator_add;
generate
    for(iterator_add=0;iterator_add<64;iterator_add=iterator_add+1)begin
      full_adder_1bit inst3(A[iterator_add],B[iterator_add],Cin[iterator_add],Sum[iterator_add],Cin[iterator_add+1]);
    end

endgenerate

assign carry_overflow=Cin[64];



endmodule