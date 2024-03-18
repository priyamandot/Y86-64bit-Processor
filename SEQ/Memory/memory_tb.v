module tb_memory;


    // Inputs
    reg clk;
    reg [3:0] icode;
    reg [63:0] valE, valA, valP, valB;
    reg instr_valid, imem_error;

    // Outputs
    wire [63:0] mem_addr, mem_data;
    wire mem_read, mem_write;
    wire [2:0] stat;
    wire [63:0] valM;
    wire memoryError;


    // Instantiate the memory module
    memory mystic(
        .clk(clk),
        .icode(icode),
        .valE(valE),
        .valA(valA),
        .valB(valB),
        .valP(valP),
        .mem_addr(mem_addr),
        .mem_data(mem_data),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .imem_error(imem_error),
        .instr_valid(instr_valid),
        .memoryError(memoryError),
        .stat(stat),
        .valM(valM)
    );

   
    initial begin
        clk = 1'b0;
        // Provide inputs here
        // For example:
        #20;
        icode = 4'h5; 
        valE = 64'h1234; 
        valA = 64'h5678; 
        valP = 64'hABCD;
        valB = 64'h12; 
        instr_valid = 0;
        imem_error = 0; 

        #10
        $finish;
    end

    // always #10 clk = ~clk;
    initial begin
        $dumpfile("tb_memory.vcd");
        $dumpvars(0,tb_memory);
        $monitor("%t, mem_read=%b, mem_write=%b, stat=%b, valM=%h, memoryError=%d", $time, mem_read, mem_write, stat, valM, memoryError);
    end



endmodule
