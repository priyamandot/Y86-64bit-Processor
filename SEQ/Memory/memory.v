

module memory(clk,icode,valE,valA,valB,valP,mem_addr,mem_data,mem_read,mem_write,imem_error,instr_valid,memoryError,stat,valM); 
input clk;
input [3:0] icode;
input [63:0] valE, valA, valP,valB;
input instr_valid,imem_error;

output reg [63:0] mem_addr,mem_data;
output reg memoryError;
output reg mem_read,mem_write;
output reg [2:0] stat;
output reg [63:0] valM;
 
reg [63:0] mem_block[0:1023]; //reg declares a variable to store data,
//declares an array of registers named mem_block, which are 64 bits wide
// reg [63:0] mem_addr,mem_data;
integer i;
initial begin
    for (i = 0; i < 1024; i = i + 1) begin 
        mem_block[i] = 64'd0;
    end
end

always@(*) begin //runs whenever there is a change
    memoryError = 0;
    //update mem_read and mem_write control signals
    mem_read = 0;
    mem_write = 0;
    if (icode == 4'h5 || icode == 4'hB || icode == 4'h9) begin 
        mem_read = 1'b1;
    end
    if (icode == 4'h4|| icode == 4'hA || icode == 4'h8) begin 
        mem_write = 1'b1;
    end

    //update mem_addr to read/write to memory
    if(icode == 4'h4 || icode == 4'hA || icode == 4'h8 || icode == 4'h5) begin 
        mem_addr = valE;
    end
    else if (icode == 4'hB || icode == 4'h9) begin 
        mem_addr = valA;
    end
    else begin 
        mem_addr= 64'hx;
    end

    //update mem_data to be written
    if(icode == 4'h4 || icode == 4'hA) begin 
        mem_data = valA;
    end
    else if (icode == 4'h8) begin 
        mem_data = valP;
    end
    else begin 
        mem_data = 64'hx;
    end


    //read or write to memory and generate memoryError
    if ((mem_write && mem_read) || mem_addr < 64'd0 || mem_addr > 64'd1023)
    begin 
        memoryError = 1;
    end
    else if(mem_write)
    begin 
        valM = 64'hx;
        mem_block[mem_addr] = mem_data;
    end
    else
    begin 
        valM = mem_block[mem_addr];
    end



end


always @(*) begin
        //update stat
    if(memoryError || imem_error) begin
    stat = 3'd2;
    end
    else if(!instr_valid) begin
    stat = 3'd3;//instr_valid
    end
    else if(icode == 4'h0) begin
    stat = 3'd4; 
    end
    else begin
    stat = 3'd1;
    end
end



endmodule

