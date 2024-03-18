
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
module alu_64bit(Control,X,Y,Result,carry,Zero_flag,Sign_flag,Overflow_flag);
input [63:0]X;
input [63:0]Y;
input [1:0] Control;
output reg [63:0] Result;
output reg carry;
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
        // Overflow=adder_overflow;
        if(Result==0)begin
            Zero_flag=1'b1;
        end
        else begin
            Zero_flag=1'b0;
        end
        // Overflow_flag=Overflow;
        if(X[63]==1 || Y[63]==1)begin
            Sign_flag=1'b1;
        end
        else begin
            Sign_flag=1'b0;
        end
        if(((X[63]==1) &&(Y[63]==1)))begin
            if(Sign_flag==1 && Y[63]!=1)begin
                Overflow_flag=1;
                
            end
            else if(Sign_flag!=1 && Y[63]==1)begin
                Overflow_flag=1;
                
            end
            else begin
                Overflow_flag=0;
                
            end
        end
        else begin
           
            Overflow_flag=0;
        end
        carry=adder_overflow;

    end

    2'b01:begin
        //X-Y
        Result=subtractor_out;
        // Overflow=subtractor_overflow;
        if(Result==0)begin
            Zero_flag=1'b1;
        end
        else begin
            Zero_flag=1'b0;
        end
        
        if(X<Y && X[63]!=1 && Y[63]!=1)begin
            Sign_flag=1'b1;
        end
        else if(X[63]==1)begin
            Sign_flag=1'b1;
        end
        else begin
            Sign_flag=1'b0;
        end
         if(((X[63]==1) &&(Y[63]==1)))begin
            if(Sign_flag==1 && Y[63]!=1)begin
                Overflow_flag=1;
              
            end
            else if(Sign_flag!=1 && Y[63]==1)begin
                Overflow_flag=1;
                
            end
            else begin
                Overflow_flag=0;
                
            end
        end
        else begin
           
            Overflow_flag=0;
        end
        carry=subtractor_overflow;


    end

    2'b10:begin
        
        
        Result=and_out;
        carry=1'b0;
        if(Result==0)begin
            Zero_flag=1'b1;
        end
        else begin
            Zero_flag=1'b0;
        end
        Overflow_flag=0;
        Sign_flag=1'b0;
        
    end

    2'b11:begin
        
        Result=xor_out;
        carry=1'b0;
        if(Result==0)begin
            Zero_flag=1'b1;
        end
        else begin
            Zero_flag=1'b0;
        end
        Overflow_flag=0;
        Sign_flag=1'b0;
    end



    endcase


end

endmodule
module ALU_A(E_icode,E_valA,E_valC,alu_A);
input [3:0]E_icode;
input [63:0]E_valA,E_valC;
output reg [63:0] alu_A;


//if icode irrmovq or iopq alu_A=valA
//iirmovq irmmovq,imrmovq aluA=valC
//icall ipushq -8
//ret pop 8
always @(*)begin
if(E_icode==4'h2 || E_icode==4'h6)
begin
     alu_A=E_valA;
end
else if(E_icode==4'h3|| E_icode==4'h4||E_icode==4'h5)
begin
     alu_A=E_valC;

end
else if(E_icode==4'h8||E_icode==4'hA)
begin
     alu_A=-64'd8;
end
else if(E_icode==4'h9||E_icode==4'hB)
begin
     alu_A=64'd8;
end


end

endmodule
module ALU_B(E_icode,E_valB,alu_B);
input [3:0]E_icode;
input [63:0]E_valB;
output reg[63:0]alu_B;
//keep valB 0 for rrmovq irmovq 
//alu_B=valB for op,rmmov,mrmov,pop,push,call,ret
always @(*)begin
if(E_icode==4'h4||E_icode==4'h5|| E_icode==4'h6|| E_icode==4'h8||E_icode==4'h9|| E_icode==4'hA||E_icode==4'hB)begin
     alu_B=E_valB;
end
else if(E_icode==4'h2||E_icode==4'h3)begin
   alu_B=64'b0;
end
end
endmodule
module alu_exe(set_cc,E_icode,E_ifun,alu_A,alu_B,e_valE,e_Cnd,ZF,SF,OF,alu_fn,carry);
input [3:0]E_icode,E_ifun;
input[63:0]alu_A,alu_B;
output reg [63:0]e_valE;
output reg e_Cnd,ZF,SF,OF;
input set_cc;

wire tempzf,tempsf,tempof;
output reg [1:0]alu_fn;
wire[63:0] tempvale;

output reg carry;
wire carrytemp;
//alu_fn=fn if icode=6
//alu_fn=add otherwise
always @(*)begin

if(E_icode==4'h6)begin
     alu_fn[0]=E_ifun[0];
     alu_fn[1]=E_ifun[1];
end
else
begin
     alu_fn=2'b0;
end


end
alu_64bit inst(alu_fn,alu_B,alu_A,tempvale,carrytemp,tempzf,tempsf,tempof);


always @(*)begin
    e_valE=tempvale;
    carry=carrytemp;
    
    

if(set_cc==1)begin
    ZF=tempzf;
    SF=tempsf;
    OF=tempof;
end

//if jmp cmov instruction - update cc accordingly
if(E_icode==4'h7||E_icode==4'h2)begin
    if(E_ifun==4'h0)begin // jmp operand
        e_Cnd=1;
    end 
    else if (E_ifun==4'h1)begin//jle
        e_Cnd=(SF^OF)|ZF;
    end
     else if(E_ifun==4'h2)begin//jl
        e_Cnd=SF^OF;

     end
    else if(E_ifun==4'h3)begin//je
        e_Cnd=ZF;

    end
    else if(E_ifun==4'h4)begin//je
        e_Cnd=~ZF;

    end
    else if(E_ifun==4'h5)begin//je
        e_Cnd=~(SF^OF);

    end
    else if(E_ifun==4'h6)begin//je
        e_Cnd=~(SF^OF) & ~ZF;

    end
end
else begin
    e_Cnd=0;
end
end

endmodule
module execute(E_stat,set_cc,E_icode,E_ifun,E_valC,E_valA,E_valB,E_dstE,E_dstM,e_stat ,e_icode ,e_Cnd ,e_valE ,e_valA ,e_dstE ,e_dstM);
input [3:0]E_icode,E_ifun;
input set_cc;
input [2:0] E_stat;
input [63:0]E_valA,E_valC,E_valB;
input [3:0] E_dstE,E_dstM;
wire ZF,SF,OF;
wire[1:0]alu_fn;
wire [63:0] alu_A;
wire [63:0] alu_B;
wire carry;

output reg [63:0] e_valA ;
output wire[63:0] e_valE;
output reg [3:0] e_dstE ,e_dstM;
output reg [3:0]  e_icode;
output reg [2:0]  e_stat ;
output wire e_Cnd;

ALU_A inst1(E_icode,E_valA,E_valC,alu_A);
ALU_B inst2(E_icode,E_valB,alu_B);
alu_exe inst3(set_cc,E_icode,E_ifun,alu_A,alu_B,e_valE,e_Cnd,ZF,SF,OF,alu_fn,carry);


always @(*) begin
    e_icode <= E_icode;
    e_stat  <= E_stat ;
    e_valA  <= E_valA ;
    e_dstM  <= E_dstM ;
    if(E_icode == 2) 
    begin
        if(e_Cnd == 1) begin
                e_dstE <= E_dstE;
            end

            else begin  
                e_dstE = 4'hF ;
            end
    end
    else  
            e_dstE <= E_dstE;
    end

    

endmodule