module xor_1bit(A,B,Y);
input A,B;
output Y;
wire temp;

xor(temp,A,B);
assign Y=temp;
endmodule