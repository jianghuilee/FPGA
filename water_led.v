module water_led
#(parameter CNT_MAX=25'd24_999_999)
(
input wire sys_clk50mhz,
input wire sys_rst_n,
output reg [5:0]led_out
);
reg[24:0] cnt;
reg cnt_flag;

always@(posedge sys_clk50mhz or negedge sys_rst_n)
 begin   
     if(sys_rst_n==1'b0)
      cnt<=25'd0;
     else if (cnt==CNT_MAX) 
      cnt<=25'd0;
     else
      cnt<=cnt+25'd1;
 end 
always@(posedge sys_clk50mhz or negedge sys_rst_n)
 begin 
      if(sys_rst_n==1'b0)
      cnt_flag<=1'd0;
      else if (cnt==(CNT_MAX-25'd1) )
      cnt_flag<=1'd1;
      else 
      cnt_flag<=1'b0;
 end 
always@(posedge sys_clk50mhz or negedge sys_rst_n)
   begin 
        if(sys_rst_n==1'b0)
         led_out<=6'b111110;
        else if ((led_out<=6'b000001)&&(cnt_flag==1'b1))
         led_out<=6'b111110;
        else if(cnt_flag==1'b1)
         led_out<=led_out<<1;  
        else 
         led_out<=led_out;
   end
endmodule   