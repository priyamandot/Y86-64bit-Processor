module M_register(clk, E_stat, E_icode, e_dstE, E_dstM, E_valA, e_valE, e_Cnd, M_bubble, M_stat, M_icode, M_Cnd, M_valE, M_valA, M_dstE, M_dstM);

input clk;
input [2:0] E_stat;
input [3:0] E_icode;
input [3:0] e_dstE, E_dstM;
input [63:0] E_valA, e_valE;
input e_Cnd, M_bubble;

output reg [2:0] M_stat;
output reg [3:0] M_icode;
output reg [3:0] M_dstE, M_dstM;
output reg [63:0] M_valA, M_valE;
output reg M_Cnd;

// initial begin 
//     M_stat = 1;
// end
always@(posedge clk)
    begin
        if(M_bubble == 1'b0)begin
            M_icode <= E_icode;
            M_dstE <= e_dstE;
            M_dstM <= E_dstM;
             M_valA <= E_valA;
        M_valE <= e_valE;
        M_Cnd <= e_Cnd;
        M_stat <= E_stat;
        end
        else//add a nop with icode = 1 and setting dstE and dstM to none
        begin
            M_icode <= 4'b1;
            M_dstE <= 4'hF;
            M_dstM <= 4'hF;

        end
         
    end
    

endmodule