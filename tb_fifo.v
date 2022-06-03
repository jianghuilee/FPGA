`timescale 1ns/1ns 
module tb_fifo();

reg     sys_clk   ;
reg     sys_rst_n ;
reg[7:0]pi_date   ;
reg     rd_req    ;
reg     wr_req    ; 
reg[1:0]cnt       ;

wire empty         ;
wire full          ;
wire [7:0]po_date  ; 
wire usew          ;

initial 
   begin 
    sys_clk=1'b1;
    sys_rst_n=1'b0;
    #20
    sys_rst_n=1'b1; 
   end
   
always #10 sys_clk=~sys_clk;

always@(posedge sys_clk or negedge sys_rst_n)
   if(!sys_rst_n)
     begin 
      cnt<=2'd0;
     end
   else if(cnt==2'd3)
     begin 
      cnt<=2'd0;
     end     
   else 
      cnt<=cnt+1'd1;
      
always@(posedge sys_clk or negedge sys_rst_n)
   if(!sys_rst_n)
     begin 
      wr_req<=1'b0;
     end      
   else if(cnt==2'd0 && rd_req==1'b0) 
      wr_req<=1'b1;
   else 
      wr_req<=1'b0;

always@(posedge sys_clk or negedge sys_rst_n)
   if(!sys_rst_n)
     pi_date<=8'd0;
   else if(pi_date==8'd255 && wr_req==1'b1 )
     pi_date<=8'd0;
   else if(wr_req==1'b1) 
     pi_date<=pi_date+1'b1;

always@(posedge sys_clk or negedge sys_rst_n)
   if(!sys_rst_n)    
     rd_req<=1'b0;
   else if(full==1'b1 )  
     rd_req<=1'b1;
   else if(empty==1'b1) 
     rd_req<=1'b0; 
    
fifo fifo_inst
(
  .      sys_clk(sys_clk),
  .      pi_date(pi_date),
  .      rd_req (rd_req ),
  .      wr_req (wr_req ),
       
  .      empty  (empty  ),
  .      full   (full   ),
  .      po_date(po_date), 
  .      usew   (usew   )
);




endmodule