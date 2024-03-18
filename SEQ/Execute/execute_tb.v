`timescale 1ns / 1ps

module execute_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns
    
    // Inputs
    reg [3:0] icode;
    reg [3:0] ifun;
    reg [63:0] valA;
    reg [63:0] valB;
    reg [63:0] valC;
    
    // Outputs
    wire [63:0] valE;
    wire Cnd;
    wire ZF;
    wire SF;
    wire OF;
    wire [1:0] alu_fn;

    // Instantiate the execute module
    execute elixir (
        .icode(icode),
        .ifun(ifun),
        .valA(valA),
        .valB(valB),
        .valC(valC),
        .valE(valE),
        .Cnd(Cnd),
        .ZF(ZF),
        .SF(SF),
        .OF(OF),
        .alu_fn(alu_fn)
    );

    // Clock generation
    reg clk = 0;
    always @(*) begin;
    #10 clk=~clk;
    // Test stimulus
    #10
        // Initialize inputs
        icode = 4'b0110; // Example value, change as needed
        ifun = 4'b0001; // Example value, change as needed
        valA = 10; // Example value, change as needed
        valB = -15; // Example value, change as needed
        valC = 64'h0000000000000000; // Example value, change as needed
        #10 clk=~clk;
         #10 clk=~clk;
          #10 clk=~clk;
        // Apply inputs
        #10;
        $display("Test case 1:");
        $display("clk =%b ,Input: icode = %b, ifun = %b, valA = %d, valB = %d, valC = %h", clk,icode, ifun, valA, valB, valC);
        #10;
        $display("Output: valE = %d, Cnd = %b, ZF = %b, SF = %b, OF = %b, alu_fn = %b", $signed(valE), Cnd, ZF, SF, OF, alu_fn);
        
        // Change inputs to see different outputs
        icode = 4'b0110; // Example value, change as needed
        ifun = 4'b0010; // Example value, change as needed
        valA = 64'b00011000; // Example value, change as needed
        valB = 64'b00011000; // Example value, change as needed
        valC = 64'h1111111111111111; // Example value, change as needed
       #10 clk=~clk;
        #10 clk=~clk;
        #10 clk=~clk;
        // Apply inputs
        #10;
        $display("Test case 2:");
        $display("clk =%b,Input: icode = %b, ifun = %b, valA = %b, valB = %b, valC = %h", clk,icode, ifun, valA, valB, valC);
        #10;
        $display("Output: valE = %b, Cnd = %b, ZF = %b, SF = %b, OF = %b, alu_fn = %h", valE, Cnd, ZF, SF, OF, alu_fn);

        // Add more test cases as needed
        icode = 4'b0111; // Example value, change as needed
        ifun = 4'b0001; // Example value, change as needed
        valA = 0; // Example value, change as needed
        valB = 0; // Example value, change as needed
        valC = 0; // Example value, change as needed
        #10 clk=~clk;
         #10 clk=~clk;
          #10 clk=~clk;
        // Apply inputs
        #10;
        $display("Test case 3:");
        $display("clk =%b,Input: icode = %b, ifun = %b, valA = %d, valB = %d, valC = %h",clk, icode, ifun, valA, valB, valC);
        #10;
        $display("Output: valE = %d, Cnd = %b, ZF = %b, SF = %b, OF = %b, alu_fn = %h", $signed(valE), Cnd, ZF, SF, OF, alu_fn);
        

        // End simulation
        #10;
        $finish;
    end
    
    // Clock generation
    // always #((CLK_PERIOD)/2) begin
    //     #1 clk = ~clk;
    // end
    
endmodule
