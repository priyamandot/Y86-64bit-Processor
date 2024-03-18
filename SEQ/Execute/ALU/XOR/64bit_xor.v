//`include "1bit_xor.v"
module xor_64bit(A,B,Y);
input [63:0] A;
input [63:0] B;

output[63:0] Y;

genvar iterator_xor;
generate
    for(iterator_xor=0;iterator_xor<64;iterator_xor=iterator_xor+1)begin
      xor_1bit inst2(A[iterator_xor],B[iterator_xor],Y[iterator_xor]);
    end
endgenerate



endmodule