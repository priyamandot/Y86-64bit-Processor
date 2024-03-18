module writeBack(clk,W_icode, W_stat,W_valE, W_valM, W_dstE, W_dstM, stat, rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9, r10, r11, r12, r13, r14,W_Cnd); 

input clk,W_Cnd;
input [2:0] W_stat;
input [3:0] W_icode;
input [63:0] W_valE,W_valM;
input [3:0] W_dstE, W_dstM;

output reg [2:0] stat;

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

reg [63:0] register_file[0:14];

//initialising each register with random values
initial
begin
register_file[0] <= 64'h1;
register_file[1] <= 64'h8;
register_file[2] <= 64'h6;
register_file[3] <= 64'h5;
register_file[4] <= 64'h100;
register_file[5] <= 64'h6;
register_file[6] <= 64'h7;
register_file[7] <= 64'h5;
register_file[8] <= 64'h9;
register_file[9] <= 64'ha;
register_file[10] <= 64'hb;
register_file[11] <= 64'h1;
register_file[12] <= 64'h2;
register_file[13] <= 64'h3;
register_file[14] <= 64'h4;
end

always@(posedge clk)begin 
    if(W_dstE != 4'hF)
    begin
    if(W_icode == 4'h2 && W_Cnd == 1)
    register_file[W_dstE] <= W_valE;
    else if(W_icode != 4'h2)
    register_file[W_dstE] <= W_valE;
    end

    if(W_dstM!= 4'hF)
    begin
    if(W_icode == 4'h2 && W_Cnd == 1)
    register_file[W_dstM] <= W_valM;
    else if(W_icode != 4'h2)
    register_file[W_dstM] <= W_valM;
    end

end

always @(*) begin
    stat <= W_stat;

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