module full_subtractor_1bit(A,B,Cin,M,Sum,Carry);
input A,B,Cin,M;
output Sum,Carry;

wire temp1,temp2,temp3,temp4;
wire bxorM;
xor(bxorM,B,M);
xor(temp1,A,bxorM);
xor(Sum,temp1,Cin);
and(temp2,temp1,Cin);
and(temp3,A,bxorM);
or(Carry,temp2,temp3);

endmodule