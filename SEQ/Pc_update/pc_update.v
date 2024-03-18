module pc_update(clk,icode,PC,valC,Cnd,valM,valP,updated_pc); 
input clk;
input [3:0] icode;
input [63:0] valC,valP,valM;
input [63:0]PC;
input Cnd;

output reg [63:0] updated_pc;


always @(*) begin 
if(icode == 4'h8) begin
updated_pc = valC;
end


else if(icode == 4'h7) begin
    if(Cnd ==1) begin
    updated_pc = valC;

    end
    else begin
    updated_pc = valP;
   
    end
end 

else if(icode == 4'h9) begin
updated_pc = valM;

end
else begin
updated_pc = valP;

end

end

endmodule

