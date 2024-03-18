module f_reg(clk,F_stall,f_PC,predPC,F_predPC);
input clk;
input F_stall;
input[63:0]predPC,f_PC;
output reg [63:0]F_predPC;
always@(posedge clk)begin
  if(F_stall==1)begin
    F_predPC =f_PC;
  end
  else begin
    F_predPC = predPC;
  end
end
endmodule