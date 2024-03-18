`timescale 1ns/1ps


module tb_add;

    
    // Inputs
    reg [63:0] A;
    reg [63:0] B;
   
    // Output
    wire [63:0] Sum;
    wire carry_overflow;

    // Instantiate the AND gate module
    adder_64bit uut (
        .A(A),
        .B(B),
        .Sum(Sum),
        .carry_overflow(carry_overflow)
    );

    // Initial block to apply test vectors
    initial begin

        $dumpfile("adder.vcd");
        $dumpvars(0,tb_add);
        // Test vector 1
        A = 64'b1100110011001100110011001100110011001100110011001100110011001100;
        B = 64'b1010101010101010101010101010101010101010101010101010101010101010;

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

        A =2;
        B = -47;

        // Display input values
        $display("Test Vector 3:");
        $display("A = %b", A);
        $display("B = %b", B);

        // Wait for some time
        #10;
        $display("Sum in decimal = %d", $signed(Sum));
        $display("Sum in binary = %b", (Sum));
        $display("Overflow = %b", carry_overflow);


        
        $finish;
    end

endmodule
