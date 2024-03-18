module memory(clk, M_icode, M_stat, M_valE, M_dstE, M_dstM, M_valA, m_stat, m_icode, m_valE, m_valM,m_dstE, m_dstM,mem_read, mem_write, mem_addr, dmem_error,M_Cnd,m_Cnd);

input clk,M_Cnd;
input [3:0] M_icode;
input [2:0] M_stat;
input [63:0] M_valE, M_valA;
input [3:0] M_dstE, M_dstM;

output reg[2:0] m_stat;
output reg [3:0] m_icode;
output reg [63:0] m_valE, m_valM;
output reg [3:0] m_dstE, m_dstM;
output reg dmem_error,m_Cnd;
output reg mem_read,mem_write;
output reg [63:0] mem_addr;

reg [63:0] mem_block[0:2000]; //reg declares a variable to store data,
//declares an array of registers named mem_block, which are 64 bits wide
// reg [63:0] mem_addr,mem_data;
integer i;
initial begin
    for (i = 0; i < 2001; i = i + 1) begin 
        mem_block[i] = 64'd0;
    end
   
end

always@(*) begin 
    dmem_error = 0;
    mem_read = 0;
    mem_write= 0;
    if (M_icode == 4'h5 || M_icode == 4'hB || M_icode == 4'h9) begin 
        mem_read = 1'b1;
    end
    if (M_icode == 4'h4|| M_icode == 4'hA || M_icode == 4'h8) begin 
        mem_write = 1'b1;
    end

      //update mem_addr to read/write to memory
    if(M_icode == 4'h4 || M_icode == 4'hA || M_icode == 4'h8 || M_icode == 4'h5) begin 
        mem_addr = M_valE;
    end
    else if (M_icode == 4'hB || M_icode == 4'h9) begin 
        mem_addr = M_valA;
    end
    

     //read or write to memory and generate dmem_error
    if ((mem_write && mem_read) || mem_addr < 64'd0 || mem_addr > 64'd2000)
    begin 
        dmem_error = 1;
    end
    else if(mem_write)
    begin 
        mem_block[mem_addr] = M_valA;
    end
    else
    begin 
        m_valM = mem_block[mem_addr];
    end
end
always@(*) begin
    if(dmem_error == 1'b1)
    m_stat <= 3'd2; //invalid address
    // else if(M_stat == 1'hx)
    // m_stat = 1;
    else
    m_stat <= M_stat;


end

always@(*) begin
    m_icode <= M_icode;
    m_dstE <= M_dstE;
    m_dstM <= M_dstM;
    m_valE <= M_valE;
    m_Cnd <= M_Cnd;
end
endmodule