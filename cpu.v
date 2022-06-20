module hall98(iclock,flag ,opcode , re,n,instr);
  input iclock;
  input[31:0] opcode;
  input[31:0] re;
  input flag ;
  input [31:0] n;
  output instr;
  
  reg [0:15999] stack[31:0]; //16KB stack  
  reg [31:0] H=0;
  reg [31:0] A=0;//2
  reg [31:0] L =0;//3
  reg [31:0] N = 0;//4
  reg [16:0] P = 0; 
  reg [31:0] mov = 32'b00000000000000000000000001000101;
  reg [31:0] add = 32'b00000000000000000000000001000110;
  reg [31:0] sub = 32'b00000000000000000000000001000111;
  reg [31:0] mul = 32'b00000000000000000000000001001000;
  reg [31:0] ldr = 32'b00000000000000000000000001001001;
  reg [31:0] str = 32'b00000000000000000000000001001010;

  parameter herz =25000/100*1;
  reg [7:0] currinst=0;
  integer curreg = 0;
  integer val= 0;
  integer res=0;
   //flag is 0? we are moving numbers, flag is 1? we are moving regs!
  //LDR -> load stuff from register into number of memory on stack;

  always @ (posedge iclock)
  begin
    if(flag != 3'b1)
    begin 
   if(opcode  == sub)
      begin
      case(n)
              1:
               begin
                  curreg=H;
               end
               2:
               begin
                  curreg=A;
               end
               3:
               begin
                  curreg=L;
               end
               4:
               begin
                  curreg=N;
               end
      
      endcase
      case(re)
              1:
               begin
                  val=H;
               end
               2:
               begin
                  val=A;
               end
               3:
               begin
                  val=L;
               end
               4:
               begin
                  val=N;
               end
      
      endcase

      res = val-curreg;

      case(re)
              1:
               begin
                  H=res;
               end
               2:
               begin
                  A=res;
               end
               3:
               begin
                  L=res;
               end
               4:
               begin
                  N=res;
               end
      endcase

     
      end
    if(opcode == str)
    begin
        // LDR SYNTAX : LDR R0,ADDR 
            //re -> register value 
      // n->  address on the stack
       case(re)
              1:
               begin
                  curreg=H;
               end
               2:
               begin
                  curreg=A;
               end
               3:
               begin
                  curreg=L;
               end
               4:
               begin
                  curreg=N;
               end
      endcase
      
      stack[n] = curreg; 
 
    end
    if(opcode == ldr)
      begin
        // STR SYNTAX : LDR R0,ADDR 
            //re -> register value 
      // n->  address on the stack

      //load value from stackaddr and put into re
       curreg = stack[n];
       case(re)
              1:
               begin
                  H=curreg;
               end
               2:
               begin
                  A=curreg;
               end
               3:
               begin
                  L=curreg;
               end
               4:
               begin
                  N=curreg;
               end
      endcase
   end
    if(opcode  == mul)
      begin
      case(n)
              1:
               begin
                  curreg=H;
               end
               2:
               begin
                  curreg=A;
               end
               3:
               begin
                  curreg=L;
               end
               4:
               begin
                  curreg=N;
               end
      endcase
      case(re)
              1:
               begin
                  val=H;
               end
               2:
               begin
                  val=A;
               end
               3:
               begin
                  val=L;
               end
               4:
               begin
                  val=N;
               end
      endcase

      res = curreg*val;
      case(re)
              1:
               begin
                  H=res;
               end
               2:
               begin
                  A=res;
               end
               3:
               begin
                  L=res;
               end
               4:
               begin
                  N=res;
               end
      endcase

     
      end
      
    if(opcode == add)
      begin
      case(n)
               1:
               begin
                  curreg=H;
               end
               2:
               begin
                  curreg=A;
               end
               3:
               begin
                  curreg=L;
               end
               4:
               begin
                  curreg=N;
               end
      endcase
      case(re)
              1:
               begin
                  val=H;
               end
               2:
               begin
                  val=A;
               end
               3:
               begin
                  val=L;
               end
               4:
               begin
                  val=N;
               end
      endcase

      res = curreg+val;
      case(re)
              1:
               begin
                  H=res;
               end
               2:
               begin
                  A=res;
               end
               3:
               begin
                  L=res;
               end
               4:
               begin
                  N=res;
               end
      endcase
      end
      
    if(opcode == mov)
    begin
         
        if(flag == 0)
        begin
            case(re) 
                
               1:
               begin
                  H=n;
               end
               2:
               begin
                  A=n;
               end
               3:
               begin
                  L=n;
               end
               4:
               begin
                  N=n;
               end
             
            endcase
        end
        
        else 
        begin
           begin
            case(n) 
                
               1:
               begin
                  curreg = H;
               end
               2:
               begin
                  curreg = H;
               end
               3:
               begin
                  curreg = H;
               end
               4:
               begin
                  curreg = H;
               end
               default:
                  curreg=H;

            endcase
          
        end
         begin
            case(re) 
               1:
               begin
                  H=curreg;
               end
               2:
               begin
                  A=curreg;
               end
               3:
               begin
                  L=curreg;
               end
               4:
               begin
                  N=curreg;
               end
               
            endcase
        end
          
        end   
    end
    P = P+1;
    end
 
  end 
  always @ (*)
  begin
     
      $display("H:%b  A:%b L:%b N:%b IP:%d  INPUT:  RE:%d N:%d FLAG:%d OPCODE: %d",H,A,L,N,P,re,n,flag,opcode);
      //$display("OCPODE :%b",opcode); 
  end

endmodule

