`timescale 1ns/1ps


module tb_sub;

    
    // Inputs
    reg [63:0] A;
    reg [63:0] B;
   
    // Output
    wire [63:0] Sum;
    wire carry_overflow;

    // Instantiate the AND gate module
    subtractor_64bit uut (
        .A(A),
        .B(B),
        .Sum(Sum),
        .carry_overflow(carry_overflow)
    );

    // Initial block to apply test vectors
    initial begin
        // Test vector 1
        $dumpfile("sub.vcd");
        $dumpvars(0,tb_sub);
        A = 9;
        B = 10;

        // Display input values
        $display("Test Vector 1:");
        $display("A = %b", A);
        $display("B = %b", B);

        // Wait for some time
        #10;

        // Display output value
        $display("Sum in decimal = %d", $signed(Sum));
        $display("Sum in binary = %b", (Sum));
        $display("Overflow = %b", carry_overflow);


        // Test vector 2
        A = 64'b1111000011110000111100001111000011110000111100001111000011110000;
        B = 64'b0000111100001111000011110000111100001111000011110000111100001111;

        // Display input values
        $display("Test Vector 2:");
        $display("A = %b", A);
        $display("B = %b", B);

        // Wait for some time
        #10;

        // Display output value
        $display("Sum in decimal = %d", $signed(Sum));
        $display("Sum in binary = %b", (Sum));
        $display("Overflow = %b", carry_overflow);

        A=100;
        B=50;

        $display("Test Vector 3:");
        $display("A = %b", A);
        $display("B = %b", B);

        // Wait for some time
        #10;

        // Display output value
        $display("Sum in decimal = %d", $signed(Sum));
        $display("Sum in binary = %b", (Sum));
        $display("Overflow = %b", carry_overflow);

        A=50;
        B=100;

        $display("Test Vector 4:");
        $display("A = %b", A);
        $display("B = %b", B);

        // Wait for some time
        #10;

        // Display output value
        $display("Sum in decimal = %d", $signed(Sum));
        $display("Sum in binary = %b", (Sum));
        $display("Overflow = %b", carry_overflow);


        
        $finish;
    end

endmodule
