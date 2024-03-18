module decode_writeBack(clk, icode, ifun, rA, rB, Cnd, valE, valM, dstE, dstM, srcA, srcB, valA, valB, rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9, r10, r11, r12, r13, r14);

//inputs
input clk;

input [3:0] icode;
input [3:0] ifun;
input [3:0] rA;
input [3:0] rB;
input Cnd;
input [63:0] valE;
input [63:0] valM;


output [3:0] dstE;
output [3:0] dstM;
output [3:0] srcA;
output [3:0] srcB;

output reg [63:0] valA;
output reg [63:0] valB;

output reg [63:0] rax;
output reg [63:0] rcx;
output reg [63:0] rdx;
output reg [63:0] rbx;
output reg [63:0] rsp;
output reg [63:0] rbp;
output reg [63:0] rsi;
output reg [63:0] rdi;
output reg [63:0] r8;
output reg [63:0] r9;
output reg [63:0] r10;
output reg [63:0] r11;
output reg [63:0] r12;
output reg [63:0] r13;
output reg [63:0] r14;

//creating fifteen 64-bit registers and assigning each a hexadecimal value from 0-14, the last one
//indicates no register assigned in the y86-64 ISA 
reg [63:0] register_file[14:0];


parameter RNONE = 4'hF ;

//initialising each register with a constant value of 0 
initial
begin
register_file[0] = 64'h1;
register_file[1] = 64'h8;
register_file[2] = 64'h3;
register_file[3] = 64'h5;
register_file[4] = 64'h100;
register_file[5] = 64'h6;
register_file[6] = 64'h7;
register_file[7] = 64'h5;
register_file[8] = 64'h9;
register_file[9] = 64'ha;
register_file[10] = 64'hb;
register_file[11] = 64'h1;
register_file[12] = 64'h2;
register_file[13] = 64'h3;
register_file[14] = 64'h4;
end

srcA_define srcAres(.icode(icode), .rA(rA), .srcA(srcA));
srcB_define srcBres(.icode(icode), .rB(rB), .srcB(srcB));
dstE_define dstEres(.icode(icode), .rB(rB), .Cnd(Cnd), .dstE(dstE));
dstM_define dstMres(.icode(icode), .rA(rA), .dstM(dstM));


//decode
always@(*) begin
    if (srcA != RNONE) begin
		valA = register_file[srcA];	
	end
    else begin 
        valA = 64'hx;
    end

	if (srcB != RNONE) begin
		valB = register_file[srcB];
	end
    else begin 
        valB = 64'hx;
    end
	
end



//write back
always @(posedge(clk)) begin

	if(dstE != RNONE) begin
		register_file[dstE] = valE;
	end

	if(dstM != RNONE) begin
		register_file[dstM] = valM;
	end
	
end

always @(*) begin
    rax = register_file[0];
    rcx = register_file[1];
    rdx = register_file[2];
    rbx = register_file[3];
    rsp = register_file[4];
    rbp = register_file[5];
    rsi = register_file[6];
    rdi = register_file[7];
    r8 = register_file[8];
    r9 = register_file[9];
    r10 = register_file[10];
    r11 = register_file[11];
    r12 = register_file[12];
    r13 = register_file[13];
    r14 = register_file[14];
end

endmodule

module srcA_define(icode,rA,srcA); 
input [3:0] icode;
input [3:0] rA;

output reg [3:0] srcA;

always@(icode,rA) begin 
    case(icode) 
    4'h2,4'h4,4'h6,4'hA : srcA = rA;
    4'h9,4'hB : srcA = 4'h4;
    default : srcA = 4'hF;
    endcase
end
endmodule

module srcB_define(icode,rB,srcB); 
input [3:0] icode;
input [3:0] rB;

output reg [3:0] srcB;

always@(icode,rB) begin 
    case(icode) 
    4'h4,4'h6,4'h5 : srcB = rB;
    4'hA,4'hB,4'h8, 4'h9 : srcB = 4'h4;
    default : srcB = 4'hF;
    endcase
end
endmodule

module dstE_define(icode, rB, Cnd, dstE); 
input [3:0] icode;
input [3:0] rB;
input Cnd;

output reg [3:0] dstE;

always@(icode,rB,Cnd) begin 
    case(icode) 
    4'h2:
        if (Cnd)
            dstE = rB; 
        else 
            dstE = 4'hF;
    4'h3, 4'h6 : dstE = rB;
    4'hA,4'hB,4'h8,4'h9 : dstE = 4'h4;
    default : dstE = 4'hF;
    endcase
end
endmodule

module dstM_define(icode, rA, dstM); 
input [3:0] icode;
input [3:0] rA;

output reg [3:0] dstM;

always@(icode,rA) begin 
    case(icode)
    4'h5,4'hB: dstM = rA;
    default : dstM = 4'hF;
    endcase
end
endmodule

