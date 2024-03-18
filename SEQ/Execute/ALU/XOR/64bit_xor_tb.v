`timescale 1ns/1ps


module tb_xor_gate;

    
    // Inputs
    reg [63:0] A;
    reg [63:0] B;

    // Output
    wire [63:0] Y;

    // Instantiate the AND gate module
    xor_64bit uut (
        .A(A),
        .B(B),
        .Y(Y)
    );

    // Initial block to apply test vectors
    initial begin
        $dumpfile("xor.vcd");
        $dumpvars(0,tb_xor_gate);
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
        $display("Y = %b", Y);

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
        $display("Y = %b", Y);

        
        $finish;
    end

endmodule
