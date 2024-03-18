module D_register(clk, f_stat, f_icode, f_ifun, f_rA, f_rB, f_valC, f_valP,imem_error,instr_valid, D_stat, D_stall, D_bubble, D_icode, D_ifun,D_rA,D_rB,D_valC,D_valP); 

input clk,imem_error, instr_valid, D_bubble, D_stall;
input [3:0] f_rA, f_rB, f_icode,f_ifun;
input [63:0] f_valC, f_valP;
input [2:0] f_stat;

output reg [3:0] D_rA, D_rB, D_icode, D_ifun;
output reg [63:0] D_valC, D_valP;
output reg [2:0] D_stat;

initial begin 
    D_stat = 3'd1;
end
always @(posedge(clk)) begin 
    if (D_stall == 1'b0) //not a stall so update values otherwise previous values stay
    begin 
       
        if (D_bubble == 1'b0) begin 
            D_icode <= f_icode; 
            D_ifun <= f_ifun;
            D_rA <= f_rA;
            D_rB <= f_rB;
            D_valC <= f_valC;
            D_valP <= f_valP;
            D_stat <= f_stat;
           
        // // aok = 1, imem= 2, invalid_instr = 2, halt = 4
        // if (imem_error == 1'b1)
        // D_stat <= 3'd2;
        // else if (instr_valid == 1'b0)
        // D_stat <= 3'd3;
        // else if (f_icode == 4'h0)
        // D_stat <= 3'd4;
        // else
        // D_stat <= 3'd1;
        end
        else begin //D_bubble = 1 implies a dynamic nop- encoded as 10
            D_icode <= 4'h1;
            D_ifun <= 4'h0; 
            D_rA <= 4'hF;
            D_rB <= 4'hF;           
        end
    end
end
endmodule