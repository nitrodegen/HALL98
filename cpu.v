module hall98(iclock,flag ,sw1,sw2,re,n,instr);
  input iclock;
  input sw1;
  input sw2;
  input[31:0] re;
  input  flag ;
  input [31:0] n;
  output instr;
  
  reg [31:0] H=0;//1
  reg [31:0] A=0;//2
  reg [31:0] L =0;//3
  reg [31:0] N = 0;//4
  reg [16:0] P = 0; 
  reg[2:0] mov = 2'b10;
  reg [2:0]add = 2'b01;
  reg [2:0]sub = 2'b11;
  reg [2:0]mul = 2'b00;
  parameter herz =25000/100*1;
  reg [7:0] currinst=0;
  integer curreg = 0;
  integer val= 0;
  integer res=0;
   //flag is 0? we are moving numbers, flag is 1? we are moving regs!
  
  always @ (posedge iclock)
  begin
    if(flag != 3'b1)
    begin 
       
    if({sw1,sw2} == sub)
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

    if({sw1,sw2} == mul)
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
      
    if({sw1,sw2} == add)
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
      
    if({sw1,sw2} == mov)
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

      $display("REGS: H:%b  A:%b L:%b N:%b IP:%b  INPUT:  %b %b %b",H,A,L,N,P,re,n,flag);
     
  end

endmodule

