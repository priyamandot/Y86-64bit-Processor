`include "./Memory/memory.v"
`include "./Pc_update/pc_update.v"
`include "./Fetch/fetch.v"
`include "./Execute/execute.v"
`include "./Decode_WriteBack/decode_writeBack.v"

module seq; 

//inputs
reg clk;
reg [63:0] PC;

//outputs
//fetch
wire imem_error;
wire [7:0] Byte_0;
wire [71:0] Byte_1_9;
wire [3:0] icode, ifun;
wire instr_valid, need_regids, need_valC;
wire [3:0] rA, rB;
wire [63:0] valC, valP;

//decode_writeback
wire [3:0] dstE;
wire [3:0] dstM;
wire [3:0] srcA;
wire [3:0] srcB;
wire [63:0] valA;
wire [63:0] valB;
wire [63:0] rax;
wire [63:0] rcx;
wire [63:0] rdx;
wire [63:0] rbx;
wire [63:0] rsp;
wire [63:0] rbp;
wire [63:0] rsi;
wire [63:0] rdi;
wire [63:0] r8;
wire [63:0] r9;
wire [63:0] r10;
wire [63:0] r11;
wire [63:0] r12;
wire [63:0] r13;
wire [63:0] r14;

//execute
wire [63:0] valE;
wire Cnd;
wire ZF;
wire SF;
wire OF;
wire [1:0] alu_fn;

//memory
wire [63:0] mem_addr, mem_data;
wire mem_read, mem_write;
wire [2:0] stat;
wire [63:0] valM;
wire memoryError;


//pc_update
wire [63:0] updated_pc;

fetch fet(clk,PC,halt,imem_error,icode,ifun,instr_valid,need_regids,need_valC,rA,rB,valC,valP);

execute exe(icode,ifun,valA,valB,valC,valE,Cnd,ZF,SF,OF,alu_fn);

decode_writeBack dwb(clk, icode, ifun, rA, rB, Cnd, valE, valM, dstE, dstM, srcA, srcB, valA, valB, rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9, r10, r11, r12, r13, r14);

memory mem(clk,icode,valE,valA,valB,valP,mem_addr,mem_data,mem_read,mem_write,imem_error,instr_valid,memoryError,stat,valM);

pc_update pcu(clk,icode,PC,valC,Cnd,valM,valP,updated_pc); 

initial begin 
    clk = 1'b1;
    PC = 0;
end

always @(posedge(clk)) begin 
    PC = updated_pc;
    // $display("valE = %d",$signed(valE));
    
end

always #10 clk = ~clk;

always @(negedge(clk)) begin 
    if(stat != 1)begin 
    #2;
    $finish;
    end
end

initial begin 
    $dumpfile("seq.vcd");
    $dumpvars(0,seq);
    // $monitor("%t\n",$time);
    $monitor("imem_error=%d | PC=%d | icode=%b | ifun=%b | need_valc=%b | need_registers = %b | rA=%b  | rB=%b | valC=%h | valP=%d \n",imem_error,PC,icode,ifun,need_valC, need_regids, rA,rB,valC,valP);
    // $monitor("srcA=%h | srcB=%h | dstE=%h | dstM=%h | valA=%h | valB=%h | rax=%h , rcx=%h, rdx=%h, rbx=%h, rsp=%h, rbp=%h, rsi=%h, rdi=%h, r8=%h, r9=%h, r10=%h, r11=%h, r12=%h, r13=%h, r14=%h", srcA, srcB, dstE, dstM, valA, valB, rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9, r10, r11, r12, r13, r14);
//$monitor("valE = %d, Cnd = %b, ZF = %b, SF = %b, OF = %b, alu_fn = %b",valE, Cnd, ZF, SF, OF, alu_fn);
    // $monitor("mem_read=%b | mem_write=%b | stat=%d | valM=%h | memoryError=%d", mem_read, mem_write, stat, valM, memoryError); 
    // $monitor("updated_pc = %d",updated_pc);
    #10;
     #10;
     #10;
     #10;
     #10;
     #10;
     #10;
     #10;
     #10;
     #10;
     #1000;
     $finish;           
end

endmodule

