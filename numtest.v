  
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
    re = 2;
    n = 15;  
    //MOV  A , 0x5
    #10;
    opcode =mov1;
    re = 3;
    n = 5;
    //ADD H,A 
  
  #200;
    opcode =  add;
    re = 2;
    n= 3;
    
   #200;
    // SUB  H,A 
    opcode = sub; 
    re = 2;
    n = 3;
    
    #200;
    //MUL H,A
    opcode = mul;  
    re = 2;
    n = 3;
    #200;
    //exit 
    
    flag = 3'b1;
    end
 endmodule 
