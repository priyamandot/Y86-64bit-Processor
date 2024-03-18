module and_1bit(A,B,Y);
input A,B;
output Y;
wire temp;

and(temp,A,B);
assign Y=temp;
endmodule


