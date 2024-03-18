module W_register(clk,m_stat,M_icode,M_valE,m_valM, M_dstE, M_dstM,W_stall, W_stat,W_icode, W_valE, W_valM,W_dstE,W_dstM,m_Cnd,W_Cnd); 

input clk;
input [2:0] m_stat;
input [3:0] M_icode;
input [63:0] M_valE, m_valM;
input [3:0] M_dstE, M_dstM;
input W_stall,m_Cnd;

output reg [2:0] W_stat;
output reg [3:0] W_icode;
output reg [63:0] W_valE, W_valM;
output reg [3:0] W_dstE, W_dstM;
output reg W_Cnd;

// initial begin 
//     W_stat = 1;
// end

always @(posedge clk)begin
    // if (m_stat == 1'hx)
    // W_stat = 1'b1;
    if(W_stall == 1'b0)begin
        W_stat <= m_stat;
        W_icode <= M_icode;
        W_valE <= M_valE;
        W_valM <= m_valM;
        W_dstE <= M_dstE; 
        W_dstM <= M_dstM;
        W_Cnd <= m_Cnd;

    end
end

endmodule