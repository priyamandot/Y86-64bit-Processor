module control(clk,W_stat,m_stat,M_icode,e_Cnd,E_dstM,E_icode,d_srcA,d_srcB,D_icode,W_stall,M_bubble,set_cc,E_bubble,D_bubble,D_stall,F_stall);

input clk;
input [2:0] W_stat,m_stat;
input [3:0] M_icode,E_icode,D_icode;
input e_Cnd;
input [3:0] E_dstM,d_srcA,d_srcB;

output reg W_stall, M_bubble, set_cc, E_bubble, D_bubble, D_stall, F_stall;
initial 
    begin
        F_stall <= 1'b0;
        D_stall <= 1'b0; 
        D_bubble <= 1'b0;
        E_bubble <= 1'b0;
        M_bubble <= 1'b0;
        W_stall <= 1'b0; 
        set_cc <= 1'b0;
    end

always @(*)begin 

    //fstall = 1 for load/use hazard and ret ins
    if((E_icode == 4'h5 || E_icode == 4'hB) &&(E_dstM == d_srcA || E_dstM == d_srcB) || (D_icode == 4'h9 || E_icode == 4'h9 ||M_icode == 4'h9))
    F_stall = 1'b1;
    else
    F_stall = 1'b0;

    //dstall = 1 for load/use
    if((E_icode == 4'h5 || E_icode == 4'hB) &&(E_dstM == d_srcA || E_dstM == d_srcB))
    D_stall= 1'b1;
    else
    D_stall = 1'b0;

    //dbubble = 1 for mispredicted branch, ret but not load use
    if (((E_icode == 4'h7) && !e_Cnd) || (!((E_icode == 4'h5 || E_icode == 4'hb) && (E_dstM == d_srcA || E_dstM == d_srcB)) && (D_icode == 4'h9 || E_icode == 4'h9 || M_icode == 4'h9)))
    D_bubble =1'b1;
    else
    D_bubble = 1'b0;

    //ebubble = 1 if mispredicted or load use hazard
    if (((E_icode == 4'h7) && !e_Cnd) || ((E_icode == 4'h5 || E_icode == 4'hb) && (E_dstM == d_srcA || E_dstM == d_srcB)))
    E_bubble =1'b1;
    else
    E_bubble = 1'b0;   

    //set cc = 1 if m_stat and W_stat = 1
    if(E_icode == 4'h6 && !(m_stat==3'd2 || m_stat == 3'd3 || m_stat==3'd4) && !(W_stat==3'd2 || W_stat == 3'd3 || W_stat==3'd4))
    set_cc = 1'b1;
    else 
    set_cc=1'b0;

    //Mbubble = 1 if m_stat or W_stat not 1
    if(m_stat != 3'd1 || W_stat != 3'd1 )
    M_bubble = 1'b1;
    else 
    M_bubble=1'b0;

    //Wstall = 1 if wstat not 1
    if(W_stat != 3'd1)
    W_stall = 1'b1;
    else
    W_stall=1'b0;


end
endmodule