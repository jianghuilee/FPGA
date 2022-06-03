module watch
(
input wire sys_clk,
input wire sys_rst_n,

output reg [3:0]led_bit,
output reg [7:0]led_out,

);

reg [7:0]led_tmp;
integer scan=0;
integer cnt=0;
integer csel=0;
integer cseh=0;
integer cminl=0;
integer cminh=0;
reg cnt_1s;
reg [3:0]flag;


initial cnt_1s=1'b0;


always@(posedge sys_clk or negedge sys_rst_n)
  begin 
   if (sys_rst_n==1'b0) 
    begin 
    cnt<=0;  
    end
   else 
    begin 
      cnt=cnt+1;
      if(cnt==25000000)
       begin 
       cnt=0;
       cnt_1s<=~cnt_1s;
       end
    end     
    
  end  

always@(posedge cnt_1s or negedge sys_rst_n)   
  begin  
    if(!sys_rst_n)
       begin 
       csel<=0;
       cseh<=0;
       cminl<=0;
       cminh<=0;
       end
    else 
        begin 
          csel<=csel+1;
          if(csel==9)
             begin 
              cseh<=cseh+1;
              csel<=0;
             end
          if((cseh==5)&&(csel==9))
            begin 
             cseh<=0;
             csel<=0;
             cminl<=cminl+1;
            end 
          if((cminl==9)&&(cseh==5)&&(csel==9))
            begin
             cseh<=0;
             csel<=0;
             cminl<=0;
             cminh<=cminh+1;
             end  
          if((csel==4)&&(cseh==2))    
             ring=1'b0;
          else ring=1'b1;             
        end     
  end
always@(posedge sys_clk or negedge sys_rst_n)
    begin
     if (sys_rst_n==1'b0) 
        begin 
        flag=4'b1111;
        end
     else 
        begin   
            scan=scan+1;
          if(scan<2000)  
            flag=4'b1110;
          else if((scan>2000)&&(scan<=4000))
            flag=4'b1101;
          else if((scan>4000)&&(scan<=6000))
            flag=4'b1011;
          else if((scan>6000)&&(scan<=8000))  
            flag=4'b0111;
          else if(scan>=9000)
           scan<=0;        
        end 
end    
always@(*)
 begin
    case(flag)
    4'b1110:begin
              led_bit<=flag;
              case(csel)
              0: led_out<=8'b11000000;  
              1: led_out<=8'b11111001;
              2: led_out<=8'b10100100;
              3: led_out<=8'b10110000;
              4: led_out<=8'b10011001;
              5: led_out<=8'b10010010;  
              6: led_out<=8'b10000010; 
              7: led_out<=8'b11111000;
              8: led_out<=8'b10000000;
              9: led_out<=8'b10010000;
              endcase
            end
    4'b1101:begin
              led_bit<=flag;
              case(cseh)
              0: led_out<=8'b11000000;  
              1: led_out<=8'b11111001;
              2: led_out<=8'b10100100;
              3: led_out<=8'b10110000;
              4: led_out<=8'b10011001;
              5: led_out<=8'b10010010; 
              endcase
            end        
    4'b1011:begin 
              led_bit<=flag;
              case(cminl)
              0: led_out<=8'b01000000;  
              1: led_out<=8'b01111001;
              2: led_out<=8'b00100100;
              3: led_out<=8'b00110000;
              4: led_out<=8'b00011001;
              5: led_out<=8'b00010010;  
              6: led_out<=8'b00000010; 
              7: led_out<=8'b01111000;
              8: led_out<=8'b00000000;
              9: led_out<=8'b00010000;
              endcase
            end
    4'b0111:begin
              led_bit<=flag;
              case(cminh)
              0: led_out<=8'b11000000;  
              1: led_out<=8'b11111001;
              2: led_out<=8'b10100100;
              3: led_out<=8'b10110000;
              4: led_out<=8'b10011001;
              5: led_out<=8'b10010010;  
              6: led_out<=8'b10000010; 
              7: led_out<=8'b11111000;
              8: led_out<=8'b10000000;
              9: led_out<=8'b10010000;
              endcase
            end 
    endcase
  end 
endmodule