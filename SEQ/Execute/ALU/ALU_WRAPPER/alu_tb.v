module alu_tb;
  // Inputs
reg [63:0] X, Y;
reg [1:0] Control;

  // Outputs
wire [63:0] Result;
wire Overflow,Overflow_flag,Sign_flag,Zero_flag;


  // Instantiate the ALU
alu_64bit uut (
    .X(X),
    .Y(Y),
    .Control(Control),
    .Result(Result),
    .Overflow(Overflow),
    .Overflow_flag(Overflow_flag),
    .Sign_flag(Sign_flag),
    .Zero_flag(Zero_flag)
);

  // Stimulus
  initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0,alu_tb);
    // Testcase 1: Addition
    X = 2000;
    Y = 60;
    Control = 2'b00; // Addition
    #10; 
    $display("X:%b",X);
    $display("Y:%b",Y);
    $display("X in decimal:%d",$signed(X));
    $display("Y in decimal:%d",$signed(Y));
    $display("Testcase 1 - Control = 0");
    $display("Result in decimal: %d", $signed(Result));
    $display("Result: %b", Result);
    $display("Overflow:%b",Overflow);
    $display("ZF:%b",Zero_flag);
    $display("SF:%b",Sign_flag);
    $display("OF:%b",Overflow_flag);

    X = 3;
    Y = -4;
    Control = 2'b00; // Addition
    #10; 
    $display("Testcase 2 - Control = 0");
    $display("X:%b",X);
    $display("Y:%b",Y);
    $display("X in decimal:%d",$signed(X));
    $display("Y in decimal:%d",$signed(Y));
    $display("Result in decimal: %d", $signed(Result));
    $display("Result: %b", Result);
    $display("Overflow:%b",Overflow);
    $display("ZF:%b",Zero_flag);
    $display("SF:%b",Sign_flag);
    $display("OF:%b",Overflow_flag);

    // Testcase 2: Subtraction
    X = 1000;
    Y = 500;
    Control = 2'b01; // Subtraction
    #10; 
    $display("Testcase 3 - Control = 1");
    $display("X:%b",X);
    $display("Y:%b",Y);
    $display("X in decimal:%d",$signed(X));
    $display("Y in decimal:%d",$signed(Y));
    $display("Result in decimal: %d", $signed(Result));
    $display("Result: %b", Result);
    $display("Overflow:%b",Overflow);
    $display("ZF:%b",Zero_flag);
    $display("SF:%b",Sign_flag);
    $display("OF:%b",Overflow_flag);

    X = 64'b1100110011001100110011001100110011001100110011001100110011001100;
    Y = 64'b1100110011001100110011001100110011001100110011001100110011001100;
    Control = 2'b01; // Subtraction
    #10; 
    $display("Testcase 4 - Control = 1");
    $display("X:%b",X);
    $display("Y:%b",Y);
    $display("X in decimal:%d",$signed(X));
    $display("Y in decimal:%d",$signed(Y));
    $display("Result in decimal: %d", $signed(Result));
    $display("Result: %b", Result);
    $display("Overflow:%b",Overflow);
    $display("ZF:%b",Zero_flag);
    $display("SF:%b",Sign_flag);
    $display("OF:%b",Overflow_flag);

    X = 10;
    Y = 70;
    Control = 2'b01; // Subtraction
    #10; 
    $display("Testcase 5 - Control = 1");
    $display("X:%b",X);
    $display("Y:%b",Y);
    $display("X in decimal:%d",$signed(X));
    $display("Y in decimal:%d",$signed(Y));
    $display("Result in decimal: %d", $signed(Result));
    $display("Result: %b", Result);
    $display("Overflow:%b",Overflow);
    $display("ZF:%b",Zero_flag);
    $display("SF:%b",Sign_flag);
    $display("OF:%b",Overflow_flag);

    // Testcase 3: AND
    X = 64'b1100110011001100110011001100110011001100110011001100110011001100;
    Y = 64'b1010101010101010101010101010101010101010101010101010101010101010;
    Control = 2'b10; // AND
    #10; 
    $display("Testcase 6 - Control = 2");
    $display("X:%b",X);
    $display("Y:%b",Y);
    $display("X in decimal:%d",$signed(X));
    $display("Y in decimal:%d",$signed(Y));
    $display("Result in decimal: %d", $signed(Result));
    $display("Result: %b", Result);
    $display("Overflow:%b",Overflow);
    $display("ZF:%b",Zero_flag);
    $display("SF:%b",Sign_flag);
    $display("OF:%b",Overflow_flag);


    // Testcase 4: XOR
    X = 64'b1100110011001100110011001100110011001100110011001100110011001100;
    Y = 64'b1010101010101010101010101010101010101010101010101010101010101010;
    Control = 2'b11; // XOR
    #10; 
    $display("Testcase 7 - Control = 3");
    $display("X:%b",X);
    $display("Y:%b",Y);
    $display("X in decimal:%d",$signed(X));
    $display("Y in decimal:%d",$signed(Y));
    $display("Result in decimal: %d", $signed(Result));
    $display("Result: %b", Result);
    $display("Overflow:%b",Overflow);
    $display("ZF:%b",Zero_flag);
    $display("SF:%b",Sign_flag);
    $display("OF:%b",Overflow_flag);


    
end

endmodule
