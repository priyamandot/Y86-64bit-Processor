`timescale 1ns / 1ps

module fetch_tb;

  // Parameters
  parameter MEM_DEPTH = 1024;

  // Signals
  reg clk;
  reg [63:0] PC;
  
  wire halt;
 wire imem_error;
  
 wire [3:0] icode, ifun;
  wire instr_valid, need_regids, need_valC;
  wire [3:0] rA, rB;
  wire [63:0] valC;
  wire[63:0] valP;

  // Instantiate the module under test
  fetch fet(
    .clk(clk),
    .PC(PC),
  
    
     .halt(halt),
    .imem_error(imem_error),
    .icode(icode),
    .ifun(ifun),
    .instr_valid(instr_valid),
    .need_regids(need_regids),
    .need_valC(need_valC),
    .rA(rA),
    .rB(rB),
    .valC(valC),
    .valP(valP)
  );


  // Initialize inputs
    initial begin 
    clk=1;
    
    PC=64'd0;
    #10clk=~clk;

    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
  
    
    $finish;
   
    
  end 
  
  always @(*) begin
    if(instr_valid==0)begin
      $display("Invalid instruction");
      $finish;
    end
  end
  initial begin
		$monitor("clk=%d  PC=%d imem need_valc=%b icode=%h ifun=%h rA=%h rB=%h,valC=%h,valP=%d\n",clk,PC,need_valC,icode,ifun,rA,rB,valC,valP);
    // always @(*) begin
    // if(imem_error==1)begin
    //   $display("Invalid memory address");
    //   $finish;
    // end
  end
endmodule


