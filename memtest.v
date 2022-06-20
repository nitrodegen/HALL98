  
`include "cpu.v"
`timescale 1ns/1ps

module test();
  
  reg [31:0] mov1 = 32'b00000000000000000000000001000101;
  reg [31:0] add= 32'b00000000000000000000000001000110;
  reg [31:0] sub = 32'b00000000000000000000000001000111;
  reg [31:0] mul =  32'b00000000000000000000000001001000;
  reg [31:0] ldr = 32'b00000000000000000000000001001001;    
  reg [31:0] str = 32'b00000000000000000000000001001010;
  
  reg iclock = 1'b1;
  reg [31:0] opcode =  0;
  integer re = 2;
  integer n = 25;
  reg flag = 3'b0;
 
  hall98 UUT(
     .iclock(iclock),
      .opcode(opcode),
      .re(re),
     .n(n),
     .flag(flag)
  );
    integer runs = 0; 
   always #20 iclock <=!iclock;
    initial begin 
    //MOV H , 0x5
    opcode = mov1;
    re = 1;
    n = 15;  
    //MOV  A , 0x5
    #2000;

    opcode = str;
    re = 1;
    n = 0;
    
    #2000;
    opcode = ldr;
    re = 2;
    n = 0;
    
    #200;
    flag = 3'b1;
    end
 endmodule 
