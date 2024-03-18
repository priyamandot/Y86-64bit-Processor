`include "./Memory/memory.v"
`include "./Memory/M_register.v"
`include "./Write_back/writeBack.v"
`include "./Write_back/W_register.v"
`include "./Decode/decode.v"
`include "./Decode/D_register.v"
`include "./Fetch/fetch.v"
`include "./Fetch/F_register.v"
`include "./Execute/execute.v"
`include "./Execute/E_register.v"
`include "controlLogic.v"

module pipeline; 

reg clk;
reg [63:0] f_PC;


//fetch
wire imem_error;
wire[3:0]f_icode,f_ifun;
wire  instr_valid,need_regids,need_valC;
wire [3:0]f_rA,f_rB;
wire[63:0]f_valC;
wire [63:0] f_valP;
wire [63:0]predPC;
wire [2:0] f_stat;

wire F_stall;
wire [63:0]F_predPC;

wire [63:0] updatedPC;

//decode
wire D_bubble, D_stall;
wire [3:0] D_rA, D_rB, D_icode, D_ifun;
wire [63:0] D_valC, D_valP;
wire [2:0] D_stat;

wire [63:0] rax;
wire [63:0] rcx;
wire [63:0] rdx;
wire [63:0] rbx;
wire [63:0] rsp;
wire [63:0] rbp;
wire [63:0] rsi;
wire [63:0] rdi;
wire [63:0] r8;
wire [63:0] r9;
wire [63:0] r10;
wire [63:0] r11;
wire [63:0] r12;
wire [63:0] r13;
wire [63:0] r14;

wire [2:0] d_stat;
wire [3:0] d_icode, d_ifun;
wire [63:0] d_valA,d_valB, d_valC;
wire [3:0] d_dstE, d_dstM, d_srcA, d_srcB;

//execute
wire E_bubble;
wire [2:0]E_stat;
wire [3:0]E_icode,E_ifun;
wire [63:0]E_valC,E_valB,E_valA;
wire[3:0]  E_dstE ,E_dstM;

wire set_cc;

wire [63:0] e_valA ;
wire[63:0] e_valE;
wire [3:0] e_dstE ,e_dstM;
wire [3:0]  e_icode;
wire [2:0]  e_stat ;
wire e_Cnd;

//memory
wire M_bubble;

wire [2:0] M_stat;
wire [3:0] M_icode;
wire [3:0] M_dstE, M_dstM;
wire [63:0] M_valA, M_valE;
wire M_Cnd;

wire[2:0] m_stat;
wire [3:0] m_icode;
wire [63:0] m_valE, m_valM;
wire [3:0] m_dstE, m_dstM;
wire dmem_error;
wire mem_read,mem_write;
wire [63:0] mem_addr;

//Write Back
wire W_stall;

wire [2:0] W_stat;
wire [3:0] W_icode;
wire [63:0] W_valE, W_valM;
wire [3:0] W_dstE, W_dstM;

wire [2:0] stat;


selectPC inst0(clk,F_predPC,W_valM,M_valA,M_Cnd,M_icode,W_icode,updatedPC);

f_reg inst1(clk,F_stall,f_PC,predPC,F_predPC);

fetch inst2(clk,f_PC,imem_error,f_icode,f_ifun,instr_valid,need_regids,need_f_valC,f_rA,f_rB,f_valC,f_valP,predPC,f_stat);

D_register inst3(clk, f_stat, f_icode, f_ifun, f_rA, f_rB, f_valC, f_valP,imem_error,instr_valid, D_stat, D_stall, D_bubble, D_icode, D_ifun,D_rA,D_rB,D_valC,D_valP); 

decode inst4(clk,D_stat,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,
e_dstE,e_valE,M_dstE,M_valE,M_dstM,m_valM,W_dstM, W_valM,W_dstE,W_valE,
d_icode, d_ifun, d_valA, d_valB, d_valC, d_dstE,d_dstM, d_srcA,d_srcB, d_stat,
rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9, r10, r11, r12, r13, r14);

e_reg inst5(clk,E_bubble,D_icode,D_ifun,D_valC,d_valA,d_valB,d_dstE,d_dstM,d_srcA,d_srcB,D_stat,E_stat,E_icode,E_ifun,E_valC,E_valA,E_valB,E_dstE,E_dstM,M_icode,e_Cnd);

execute inst6(E_stat,set_cc,E_icode,E_ifun,E_valC,E_valA,E_valB,E_dstE,E_dstM,e_stat ,e_icode ,e_Cnd ,e_valE ,e_valA ,e_dstE ,e_dstM);

M_register inst7(clk, E_stat, E_icode, e_dstE, E_dstM, E_valA, e_valE, e_Cnd, M_bubble, M_stat, M_icode, M_Cnd, M_valE, M_valA, M_dstE, M_dstM);

memory inst8(clk, M_icode, M_stat, M_valE, M_dstE, M_dstM, M_valA, m_stat, m_icode, m_valE, m_valM,m_dstE, m_dstM,mem_read, mem_write, mem_addr, dmem_error,M_Cnd,m_Cnd);

W_register inst9(clk,m_stat,M_icode,M_valE,m_valM, M_dstE, M_dstM,W_stall, W_stat,W_icode, W_valE, W_valM,W_dstE,W_dstM,m_Cnd,W_Cnd); 

writeBack inst10(clk,W_icode, W_stat,W_valE, W_valM, W_dstE, W_dstM, stat, rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9, r10, r11, r12, r13, r14,W_Cnd); 

control inst11(clk,W_stat,m_stat,M_icode,e_Cnd,E_dstM,E_icode,d_srcA,d_srcB,D_icode,W_stall,M_bubble,set_cc,E_bubble,D_bubble,D_stall,F_stall);

initial
    begin
    
    $dumpfile("pipeline.vcd");
    $dumpvars(0, pipeline);

    clk = 1;
    f_PC = 64'd0;

    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #1000;
    $finish;
    end

always @(*) begin 
    f_PC = updatedPC;
    
end

always #10 clk <= ~clk;

always @(*) begin 
    if(stat != 1)begin 
    #5;
    $finish;
    end
end

endmodule