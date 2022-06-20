  
`include "cpu.v"
`timescale 1ns/1ps

module test();

  reg iclock = 1'b1;
  reg sw1=1'b1;
  reg sw2=1'b0;
  integer re = 1;
  integer n = 25;
  reg flag = 3'b0;
  
  hall98 UUT(
     .iclock(iclock),
     .sw1(sw1),
     .sw2(sw2),
     .re(re),
     .n(n),
     .flag(flag)
  );
    integer runs = 0; 
   always #20 iclock <=!iclock;
    initial begin 
    //MOV H , 0x5
    sw1 = 1'b1;
    sw2 = 1'b0;
    re = 1;
    n = 15;  
    //MOV  A , 0x5
    #10;
    sw1 = 1'b1;
    sw2 = 1'b0;
    re = 2;
    n = 5;
    //ADD H,A 
  
  #200;
    sw1 = 1'b0;
    sw2 = 1'b1;
    re = 1;
    n = 2;
    
   #200;
    // SUB  H,A 
    sw1 = 1'b1;
    sw2 = 1'b1;
    re = 1;
    n = 2;
    
    #200;
    //MUL H,A
    sw1 = 1'b0;
    sw2 = 1'b0;
    re = 1;
    n = 2;
    
    
    

  #200;

    //exit 
    
    flag = 3'b1;
    end
 endmodule 
