//`include "1bit_and.v"
module and_64bit(A,B,Y);
input [63:0] A;
input [63:0] B;

output[63:0] Y;

genvar iterator_and;
generate
    for(iterator_and=0;iterator_and<64;iterator_and=iterator_and+1)begin
      and_1bit inst1(A[iterator_and],B[iterator_and],Y[iterator_and]);
    end
endgenerate



endmodule