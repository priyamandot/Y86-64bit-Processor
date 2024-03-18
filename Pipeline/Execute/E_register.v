module e_reg(clk,E_bubble,D_icode,D_ifun,D_valC,d_valA,d_valB,d_dstE,d_dstM,d_srcA,d_srcB,D_stat,E_stat,E_icode,E_ifun,E_valC,E_valA,E_valB,E_dstE,E_dstM,M_icode,e_Cnd);
input clk,E_bubble,e_Cnd;
input [2:0] D_stat;
input [3:0] D_icode,D_ifun,d_dstE,d_dstM,d_srcA,d_srcB,M_icode;
input [63:0] D_valC,d_valA,d_valB;

output reg [2:0]E_stat;
output reg [3:0]E_icode,E_ifun;
output reg [63:0]E_valC,E_valB,E_valA;
output reg[3:0]  E_dstE ,E_dstM;

// initial begin 
//     E_stat = 3'd1;
// end
always@(posedge(clk))begin
    
    
    if(E_bubble == 1)begin
        E_icode<=4'h1;
        E_ifun<=4'h0;
        E_dstE<=4'hF;
        E_dstM<=4'hF;
    end
    else begin // not bubble
    if(M_icode==7 && e_Cnd==0 && D_stat!=1)
                E_stat <=4'h1;
    else begin
        E_stat <= D_stat ;
    end
        E_icode<=D_icode;
        E_ifun<=D_ifun;
        E_dstE<=d_dstE;
        E_dstM<=d_dstM;
        E_valA <= d_valA ;
        E_valB <=d_valB ;
        E_valC <= D_valC ;
    

        
    end
end


endmodule