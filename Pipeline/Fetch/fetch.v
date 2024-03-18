
module fetch(clk,f_PC,imem_error,f_icode,f_ifun,instr_valid,need_regids,need_valC,f_rA,f_rB,f_valC,f_valP,predPC,f_stat);

input [63:0]f_PC;
input clk;
reg [0:7]memory[0:1023];



reg [63:0]Bytes18;
output reg imem_error;
output reg[3:0]f_icode,f_ifun;
output reg  instr_valid,need_regids,need_valC;
output reg [3:0]f_rA,f_rB;
output reg[63:0]f_valC;
output reg [63:0] f_valP;
reg halt;
output reg [63:0]predPC;
output reg [2:0] f_stat;
initial begin
     $readmemh("cmov.txt",memory);
end 

always@(*)begin
halt = 0;
imem_error=0;
if(f_PC<64'd0 || f_PC>64'd1023)begin
    imem_error=1;
    f_icode=4'hx;
    f_ifun=4'hx;

end
else begin
f_icode=memory[f_PC][0:3];
 f_ifun=memory[f_PC][4:7];
if(f_icode==4'h0)begin  //halt
    halt=1;
    f_rA = 4'hx;
    f_rB = 4'hx;
    f_valC = 64'hx;
    f_valP=f_PC+1;
end
if(f_icode==4'h1)begin //nop
    f_valP=f_PC+1;
end
if(f_icode==4'h2)begin //rrmovq
    f_rA=memory[f_PC+1][0:3];
    f_rB=memory[f_PC+1][4:7];
    f_valP=f_PC+2;
end
if(f_icode==4'h3)begin //irmovq
    f_rA=memory[f_PC+1][0:3];
    f_rB=memory[f_PC+1][4:7];
    Bytes18[7:0] = memory[f_PC+2];
    Bytes18[15:8] = memory[f_PC+3];
    Bytes18[23:16] = memory[f_PC+4];
    Bytes18[31:24] = memory[f_PC+5];
    Bytes18[39:32] = memory[f_PC+6];
    Bytes18[47:40] = memory[f_PC+7];
    Bytes18[55:48] = memory[f_PC+8];
    Bytes18[63:56] = memory[f_PC+9];
    

     f_valC={ Bytes18[63:56], Bytes18[55:48],Bytes18[47:40], Bytes18[39:32], Bytes18[31:24], Bytes18[23:16] ,Bytes18[15:8],Bytes18[7:0]};
     f_valP=f_PC+10;
end

if(f_icode==4'h4)begin //rmmov
    f_rA=memory[f_PC+1][0:3];
    f_rB=memory[f_PC+1][4:7];
     Bytes18[7:0] = memory[f_PC+2];
    Bytes18[15:8] = memory[f_PC+3];
    Bytes18[23:16] = memory[f_PC+4];
    Bytes18[31:24] = memory[f_PC+5];
    Bytes18[39:32] = memory[f_PC+6];
    Bytes18[47:40] = memory[f_PC+7];
    Bytes18[55:48] = memory[f_PC+8];
    Bytes18[63:56] = memory[f_PC+9];
    

    f_valC={ Bytes18[63:56], Bytes18[55:48],Bytes18[47:40], Bytes18[39:32], Bytes18[31:24], Bytes18[23:16] ,Bytes18[15:8],Bytes18[7:0]};
     f_valP=f_PC+10;
end

if(f_icode==4'h5)begin//mrmov
    f_rA=memory[f_PC+1][0:3];
    f_rB=memory[f_PC+1][4:7];
     Bytes18[7:0] = memory[f_PC+2];
    Bytes18[15:8] = memory[f_PC+3];
    Bytes18[23:16] = memory[f_PC+4];
    Bytes18[31:24] = memory[f_PC+5];
    Bytes18[39:32] = memory[f_PC+6];
    Bytes18[47:40] = memory[f_PC+7];
    Bytes18[55:48] = memory[f_PC+8];
    Bytes18[63:56] = memory[f_PC+9];
    
    f_valC={ Bytes18[63:56], Bytes18[55:48],Bytes18[47:40], Bytes18[39:32], Bytes18[31:24], Bytes18[23:16] ,Bytes18[15:8],Bytes18[7:0]};
     f_valP=f_PC+10;
end

if(f_icode==4'h6)begin//op
    f_rA=memory[f_PC+1][0:3];
    f_rB=memory[f_PC+1][4:7];
    f_valP=f_PC+2;
end

if(f_icode==4'h7)begin //jmp
     Bytes18[7:0] = memory[f_PC+1];
    Bytes18[15:8] = memory[f_PC+2];
    Bytes18[23:16] = memory[f_PC+3];
    Bytes18[31:24] = memory[f_PC+4];
    Bytes18[39:32] = memory[f_PC+5];
    Bytes18[47:40] = memory[f_PC+6];
    Bytes18[55:48] = memory[f_PC+7];
    Bytes18[63:56] = memory[f_PC+8];
    
     f_valC={ Bytes18[63:56], Bytes18[55:48],Bytes18[47:40], Bytes18[39:32], Bytes18[31:24], Bytes18[23:16] ,Bytes18[15:8],Bytes18[7:0]};
     f_valP=f_PC+9;
end

if(f_icode==4'h8)begin//call
      Bytes18[7:0] = memory[f_PC+1];
    Bytes18[15:8] = memory[f_PC+2];
    Bytes18[23:16] = memory[f_PC+3];
    Bytes18[31:24] = memory[f_PC+4];
    Bytes18[39:32] = memory[f_PC+5];
    Bytes18[47:40] = memory[f_PC+6];
    Bytes18[55:48] = memory[f_PC+7];
    Bytes18[63:56] = memory[f_PC+8];
    
    f_valC={ Bytes18[63:56], Bytes18[55:48],Bytes18[47:40], Bytes18[39:32], Bytes18[31:24], Bytes18[23:16] ,Bytes18[15:8],Bytes18[7:0]};
     f_valP=f_PC+9;
end

if(f_icode==4'h2)begin//cmov
    f_rA=memory[f_PC+1][0:3];
    f_rB=memory[f_PC+1][4:7];
    f_valP=f_PC+2;
end

if(f_icode==4'h9)begin//ret
    f_valP=f_PC+1;
end

if(f_icode==4'hA)begin//pushq
    f_rA=memory[f_PC+1][0:3];
    f_rB=memory[f_PC+1][4:7];
    f_valP=f_PC+2;
end

if(f_icode==4'hB)begin//pushq
    f_rA=memory[f_PC+1][0:3];
    f_rB=memory[f_PC+1][4:7];
    f_valP=f_PC+2;
end


if((f_icode)==4'h3 || (f_icode)==4'h4 || (f_icode)==4'h5 || (f_icode)==4'h7 || (f_icode)==4'h8 )
begin
     need_valC=1'b1;
end
else begin
     need_valC=1'b0;
end

if((f_icode==4'h2) || (f_icode==4'h3) || (f_icode==4'h4) || (f_icode==4'h5) || (f_icode==4'h6) || (f_icode==4'hA) || (f_icode==4'hB) )begin
     need_regids=1'b1;
end
else begin
     need_regids=1'b0;
end

if(f_icode ==4'h0 || f_icode==4'h1 || f_icode==4'h2 || f_icode==4'h3 ||f_icode==4'h4 ||f_icode==4'h5 ||f_icode==4'h6 ||f_icode==4'h7 ||f_icode==4'h8 ||f_icode==4'h9 ||f_icode==4'hA ||f_icode==4'hB)begin
     instr_valid = 1'b1;
end
else begin
     instr_valid = 1'b0;
end
end

end


//predict PC
always@(*)begin
    //jump or call predict pc =valC ->we assume jump is taken
if(f_icode==4'h7)begin//jump
    predPC=f_valC;
end
else if(f_icode==4'h8)//call
begin
    predPC=f_valC;
end
else begin
    predPC=f_valP;
end
end


//f stat
always@(*)begin
    if(imem_error==1)begin
        f_stat=3'h2;
    end
    else if(instr_valid==0)begin
        f_stat=3'h3;
    end
    else if(halt==1)begin
        f_stat=3'h4;
    end
    else begin
        f_stat=3'h1;
    end
end


endmodule


//select PC
module selectPC(clk,F_predPC,W_valM,M_valA,M_Cnd,M_icode,W_icode,updatedPC);
input clk;
input [63:0]F_predPC,W_valM,M_valA;
input M_Cnd;
input [3:0]M_icode,W_icode;
output reg[63:0]updatedPC;
always@(*)begin
    //if write back stage reached to 'return'
    if(W_icode==4'h9)begin
        updatedPC=W_valM;// goes to memory address at top of stack
    end 
    //if memory stage reached 'jump'and Cnd not set ->jump not taken
    else if(M_icode==4'h7 && M_Cnd==0)begin
        updatedPC=M_valA;
    end
    else begin
        updatedPC=F_predPC;
    end
end
endmodule