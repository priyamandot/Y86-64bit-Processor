module tb_decode_writeBack;

    // Inputs
    reg clk;
    reg [3:0] icode;
    reg [3:0] ifun;
    reg [3:0] rA;
    reg [3:0] rB;
    reg Cnd;
    reg [63:0] valE;
    reg [63:0] valM;
    
    // Outputs
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

    // Instantiate the decode_writeBack module
    decode_writeBack DUT(
        .clk(clk),
        .icode(icode),
        .ifun(ifun),
        .rA(rA),
        .rB(rB),
        .Cnd(Cnd),
        .valE(valE),
        .valM(valM),
        .dstE(dstE),
        .dstM(dstM),
        .srcA(srcA),
        .srcB(srcB),
        .valA(valA),
        .valB(valB),
        .rax(rax),
        .rcx(rcx),
        .rdx(rdx),
        .rbx(rbx),
        .rsp(rsp),
        .rbp(rbp),
        .rsi(rsi),
        .rdi(rdi),
        .r8(r8),
        .r9(r9),
        .r10(r10),
        .r11(r11),
        .r12(r12),
        .r13(r13),
        .r14(r14)
    );
   initial begin
    clk = 1'b0;
        #10;
        // irmovq
        icode = 4'h3;
        ifun  = 4'h0;
        rA = 4'h0;
        rB = 4'h3;
        valE = 64'd525;
        valM = 64'd300;
        #20;

        // moved 64'd525 to register rbx;

        icode = 4'h3;
        ifun  = 4'h0;
        rA = 4'h3;
        rB = 4'h0;
        valE = 64'd300;
        valM = 64'd300;
        #20;

        // moved 64'd300 to register rax;
        icode = 4'h6;
        ifun  = 4'h2;
        rA = 4'h3;
        rB = 4'h0;
        valE = 64'd251;
        valM = 64'd300;
        #20;

        icode = 4'h6;
        ifun  = 4'h2;
        rA = 4'h3;
        rB = 4'h0;
        valE = 64'd252;
        valM = 64'd300;
        #20;
        
        icode = 4'h6;
        ifun  = 4'h2;
        rA = 4'h3;
        rB = 4'h0;
        valE = 64'd253;
        valM = 64'd300;
        #20;

        //check memory to reg
        icode = 4'h5;
        ifun  = 4'h2;
        rA = 4'h0;
        rB = 4'h3;
        valE = 64'd999;
        valM = 64'd999;
       
        #20;
        icode = 4'h6;
        ifun  = 4'h2;
        rA = 4'h0;
        rB = 4'h3;
        valE = 64'd253;
        valM = 64'd300;
        
        #20 $finish;
        
   end
   always #10 clk = ~clk;
    

     // Monitor output
    initial begin
        $monitor("%t, srcA=%h, srcB=%h, dstE=%h, dstM=%h, valA=%h, valB=%h, rax=%h, rcx=%h, rdx=%h, rbx=%h, rsp=%h, rbp=%h, rsi=%h, rdi=%h, r8=%h, r9=%h, r10=%h, r11=%h, r12=%h, r13=%h, r14=%h", 
                 $time, srcA, srcB, dstE, dstM, valA, valB, rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9, r10, r11, r12, r13, r14);
        $dumpfile("tb_decode_writeBack.vcd");
        $dumpvars(0,tb_decode_writeBack);
    end

endmodule
