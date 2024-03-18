
module fetch(clk,PC,halt,imem_error,icode,ifun,instr_valid,need_regids,need_valC,rA,rB,valC,valP);

input [63:0]PC;
input clk;
reg [0:7]memory[0:1023];
//input [63:0] memory[0:1023];


reg [63:0]Bytes18;
output reg imem_error;
output reg[3:0]icode,ifun;
output reg  instr_valid,need_regids,need_valC;
output reg [3:0]rA,rB;
output reg[63:0]valC;
output reg [63:0] valP;
output reg halt;
integer i;
integer j;
reg [63:0]temp_valc;
 initial begin
     $readmemh("3.txt",memory);
  end 

always@(*)begin
halt = 0;
imem_error=0;
if(PC<64'd0 || PC>64'd1023)begin
    imem_error=1;
    icode=4'hx;
    ifun=4'hx;
end
else begin
icode=memory[PC][0:3];
 ifun=memory[PC][4:7];
if(icode==4'h0)begin  //halt
    halt=1;

end
if(icode==4'h1)begin //nop
    valP=PC+1;
end
if(icode==4'h2)begin //rrmovq
    rA=memory[PC+1][0:3];
    rB=memory[PC+1][4:7];
    valP=PC+2;
end
if(icode==4'h3)begin //irmovq
    rA=memory[PC+1][0:3];
    rB=memory[PC+1][4:7];
    Bytes18[7:0] = memory[PC+2];
    Bytes18[15:8] = memory[PC+3];
    Bytes18[23:16] = memory[PC+4];
    Bytes18[31:24] = memory[PC+5];
    Bytes18[39:32] = memory[PC+6];
    Bytes18[47:40] = memory[PC+7];
    Bytes18[55:48] = memory[PC+8];
    Bytes18[63:56] = memory[PC+9];
    

     valC={ Bytes18[63:56], Bytes18[55:48],Bytes18[47:40], Bytes18[39:32], Bytes18[31:24], Bytes18[23:16] ,Bytes18[15:8],Bytes18[7:0]};
     valP=PC+10;
end

if(icode==4'h4)begin //rmmov
    rA=memory[PC+1][0:3];
    rB=memory[PC+1][4:7];
     Bytes18[7:0] = memory[PC+2];
    Bytes18[15:8] = memory[PC+3];
    Bytes18[23:16] = memory[PC+4];
    Bytes18[31:24] = memory[PC+5];
    Bytes18[39:32] = memory[PC+6];
    Bytes18[47:40] = memory[PC+7];
    Bytes18[55:48] = memory[PC+8];
    Bytes18[63:56] = memory[PC+9];
    

    valC={ Bytes18[63:56], Bytes18[55:48],Bytes18[47:40], Bytes18[39:32], Bytes18[31:24], Bytes18[23:16] ,Bytes18[15:8],Bytes18[7:0]};
     valP=PC+10;
end

if(icode==4'h5)begin//mrmov
    rA=memory[PC+1][0:3];
    rB=memory[PC+1][4:7];
     Bytes18[7:0] = memory[PC+2];
    Bytes18[15:8] = memory[PC+3];
    Bytes18[23:16] = memory[PC+4];
    Bytes18[31:24] = memory[PC+5];
    Bytes18[39:32] = memory[PC+6];
    Bytes18[47:40] = memory[PC+7];
    Bytes18[55:48] = memory[PC+8];
    Bytes18[63:56] = memory[PC+9];
    
    valC={ Bytes18[63:56], Bytes18[55:48],Bytes18[47:40], Bytes18[39:32], Bytes18[31:24], Bytes18[23:16] ,Bytes18[15:8],Bytes18[7:0]};
     valP=PC+10;
end

if(icode==4'h6)begin//op
    rA=memory[PC+1][0:3];
    rB=memory[PC+1][4:7];
    valP=PC+2;
end

if(icode==4'h7)begin //jmp
     Bytes18[7:0] = memory[PC+1];
    Bytes18[15:8] = memory[PC+2];
    Bytes18[23:16] = memory[PC+3];
    Bytes18[31:24] = memory[PC+4];
    Bytes18[39:32] = memory[PC+5];
    Bytes18[47:40] = memory[PC+6];
    Bytes18[55:48] = memory[PC+7];
    Bytes18[63:56] = memory[PC+8];
    
     valC={ Bytes18[63:56], Bytes18[55:48],Bytes18[47:40], Bytes18[39:32], Bytes18[31:24], Bytes18[23:16] ,Bytes18[15:8],Bytes18[7:0]};
     valP=PC+9;
end

if(icode==4'h8)begin//call
      Bytes18[7:0] = memory[PC+1];
    Bytes18[15:8] = memory[PC+2];
    Bytes18[23:16] = memory[PC+3];
    Bytes18[31:24] = memory[PC+4];
    Bytes18[39:32] = memory[PC+5];
    Bytes18[47:40] = memory[PC+6];
    Bytes18[55:48] = memory[PC+7];
    Bytes18[63:56] = memory[PC+8];
    
    valC={ Bytes18[63:56], Bytes18[55:48],Bytes18[47:40], Bytes18[39:32], Bytes18[31:24], Bytes18[23:16] ,Bytes18[15:8],Bytes18[7:0]};
     valP=PC+9;
end

if(icode==4'h2)begin//cmov
    rA=memory[PC+1][0:3];
    rB=memory[PC+1][4:7];
    valP=PC+2;
end

if(icode==4'h9)begin//ret
    valP=PC+1;
end

if(icode==4'hA)begin//pushq
    rA=memory[PC+1][0:3];
    rB=memory[PC+1][4:7];
    valP=PC+2;
end

if(icode==4'hB)begin//pushq
    rA=memory[PC+1][0:3];
    rB=memory[PC+1][4:7];
    valP=PC+2;
end


if((icode)==4'h3 || (icode)==4'h4 || (icode)==4'h5 || (icode)==4'h7 || (icode)==4'h8 )
begin
     need_valC=1'b1;
end
else begin
     need_valC=1'b0;
end

if((icode==4'h2) || (icode==4'h3) || (icode==4'h4) || (icode==4'h5) || (icode==4'h6) || (icode==4'hA) || (icode==4'hB) )begin
     need_regids=1'b1;
end
else begin
     need_regids=1'b0;
end

if(icode ==4'h0 || icode==4'h1 || icode==4'h2 || icode==4'h3 ||icode==4'h4 ||icode==4'h5 ||icode==4'h6 ||icode==4'h7 ||icode==4'h8 ||icode==4'h9 ||icode==4'hA ||icode==4'hB)begin
     instr_valid = 1'b1;
end
else begin
     instr_valid = 1'b0;
end
end

end

endmodule
