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

module and_1bit(A,B,Y);
input A,B;
output Y;
wire temp;

and(temp,A,B);
assign Y=temp;
endmodule


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
module xor_1bit(A,B,Y);
input A,B;
output Y;
wire temp;

xor(temp,A,B);
assign Y=temp;
endmodule

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
module alu_64bit(Control,X,Y,Result,Overflow,Zero_flag,Sign_flag,Overflow_flag);
input [63:0]X;
input [63:0]Y;
input [1:0] Control;
output reg [63:0] Result;
output reg Overflow;
output reg Zero_flag,Sign_flag,Overflow_flag;

wire[63:0]adder_out;
wire adder_overflow;
wire[63:0]subtractor_out;
wire subtractor_overflow;
wire[63:0]and_out;
wire[63:0]xor_out;

adder_64bit inst10(X,Y,adder_out,adder_overflow);
subtractor_64bit inst1(X,Y,subtractor_out,subtractor_overflow);
and_64bit inst2(X,Y,and_out);
xor_64bit inst3(X,Y,xor_out);

always@(*)
begin
    case(Control)

    2'b00:begin
        //X+Y
        Result=adder_out;
        Overflow=adder_overflow;
        if(Result==0)begin
            Zero_flag=1'b1;
        end
        else begin
            Zero_flag=1'b0;
        end
        Overflow_flag=Overflow;
        if(X[63]==1 || Y[63]==1)begin
            Sign_flag=1'b1;
        end
        else begin
            Sign_flag=1'b0;
        end


    end

    2'b01:begin
        //X-Y
        Result=subtractor_out;
        Overflow=subtractor_overflow;
        if(Result==0)begin
            Zero_flag=1'b1;
        end
        else begin
            Zero_flag=1'b0;
        end
        Overflow_flag=Overflow;
        if(X<Y && X[63]!=1 && Y[63]!=1)begin
            Sign_flag=1'b1;
        end
        else if(X[63]==1)begin
            Sign_flag=1'b1;
        end
        else begin
            Sign_flag=1'b0;
        end
    end

    2'b10:begin
        
        
        Result=and_out;
        Overflow=1'b0;
        if(Result==0)begin
            Zero_flag=1'b1;
        end
        else begin
            Zero_flag=1'b0;
        end
        Overflow_flag=Overflow;
        Sign_flag=1'b0;
    end

    2'b11:begin
        
        Result=xor_out;
        Overflow=1'b0;
        if(Result==0)begin
            Zero_flag=1'b1;
        end
        else begin
            Zero_flag=1'b0;
        end
        Overflow_flag=Overflow;
        Sign_flag=1'b0;
    end



    endcase


end

endmodule