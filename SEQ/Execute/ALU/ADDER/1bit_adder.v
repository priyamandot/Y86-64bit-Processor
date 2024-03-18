module full_adder_1bit(A,B,Cin,Sum,Carry);
input A,B,Cin;
output Sum,Carry;

wire temp1,temp2,temp3,temp4;
xor(temp1,A,B);
xor(Sum,temp1,Cin);
and(temp2,temp1,Cin);
and(temp3,A,B);
or(Carry,temp2,temp3);

endmodule