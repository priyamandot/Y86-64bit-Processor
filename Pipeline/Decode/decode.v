module decode(clk,D_stat,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,
e_dstE,e_valE,M_dstE,M_valE,M_dstM,m_valM,W_dstM, W_valM,W_dstE,W_valE,
d_icode, d_ifun, d_valA, d_valB, d_valC, d_dstE,d_dstM, d_srcA,d_srcB, d_stat,
rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9, r10, r11, r12, r13, r14);

//inputs
input clk;

input [2:0] D_stat;
input [3:0] D_icode, D_ifun;
input [3:0] D_rA,D_rB;
input [63:0] e_valE, M_valE, m_valM,W_valM,W_valE, D_valC, D_valP;
input [3:0] e_dstE, M_dstE, M_dstM, W_dstM, W_dstE;

input [63:0] rax;
input [63:0] rcx;
input [63:0] rdx;
input [63:0] rbx;
input [63:0] rsp;
input [63:0] rbp;
input [63:0] rsi;
input [63:0] rdi;
input [63:0] r8;
input [63:0] r9;
input [63:0] r10;
input [63:0] r11;
input [63:0] r12;
input [63:0] r13;
input [63:0] r14;

output reg [2:0] d_stat;
output reg [3:0] d_icode, d_ifun;
output reg [63:0] d_valA,d_valB, d_valC;
output reg [3:0] d_dstE, d_dstM, d_srcA, d_srcB;


//creating fifteen 64-bit registers and assigning each a hexadecimal value from 0-14, t
//register values are inputs from write back stage
reg [63:0] register_file[0:14];

//no register assigned: 4'hF 

always@(*) begin
register_file[0] <= rax;
register_file[1] <= rcx;
register_file[2] <= rdx;
register_file[3] <= rbx;
register_file[4] <= rsp;
register_file[5] <= rbp;
register_file[6] <= rsi;
register_file[7] <= rdi;
register_file[8] <= r8;
register_file[9] <= r9;
register_file[10] <= r10;
register_file[11] <= r11;
register_file[12] <= r12;
register_file[13] <= r13;
register_file[14] <= r14;

//passing icode ifun valC stat directly from D_register
d_icode <= D_icode;
d_ifun <= D_ifun;
d_valC <= D_valC;
d_stat <= D_stat;

//srcA
case(D_icode) 
    4'h2,4'h4,4'h6,4'hA : d_srcA = D_rA;
    4'h9,4'hB : d_srcA = 4'h4;
    default : d_srcA = 4'hF;
endcase

//srcB
case(D_icode) 
    4'h4,4'h6,4'h5 : d_srcB = D_rB;
    4'hA,4'hB,4'h8, 4'h9 : d_srcB = 4'h4;
    default : d_srcB = 4'hF;
endcase

//dstE
case(D_icode) 
    4'h2,4'h3, 4'h6 : d_dstE = D_rB;
    4'hA,4'hB,4'h8,4'h9 : d_dstE = 4'h4;
    default : d_dstE = 4'hF;
endcase

//dstM
case(D_icode)
    4'h5,4'hB: d_dstM = D_rA;
    default : d_dstM = 4'hF;
endcase

end

//select+ fwd A - order must be maintained
always@(*) begin 
    if (D_icode == 4'h8 ||D_icode == 4'h7)
    d_valA = D_valP; // using incremented pc for call and jump
    if (d_srcA != 15) begin
    if (d_srcA == e_dstE)
    d_valA = e_valE; //forward from execute stage
    else if(d_srcA == M_dstM)
    d_valA = m_valM; //from memory stage
    else if(d_srcA == M_dstE)
    d_valA = M_valE; //from memory reg
    else if(d_srcA == W_dstM)
    d_valA = W_valM; //from wb reg
    else if(d_srcA == W_dstE)
    d_valA = W_valE; //from wb reg
    else 
    d_valA = register_file[d_srcA];// take reg value
    end 
end

//fwd B
always @(*) begin 
    if (d_srcB != 15) begin
    if(d_srcB == e_dstE)
    d_valB = e_valE; //from execute stage
    else if(d_srcB == M_dstM)
    d_valB = m_valM; //from memory stage
    else if(d_srcB == M_dstE)
    d_valB = M_valE; //from memory reg
    else if(d_srcB == W_dstM)
    d_valB = W_valM; //from wb reg
    else if(d_srcB == W_dstE)
    d_valB = W_valE; //from wb reg
    else
    d_valB = register_file[d_srcB];
    end
end
endmodule
