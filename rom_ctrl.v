module rom_ctrl
#
(
parameter  CNT_MAX =24'd9_999_999
)
(
input wire 		sys_clk   , 
input wire 		sys_rst_n ,
input wire 		key1      ,
input wire      key2      ,

output reg [7:0] addr	  
);

reg			 [23:0] cnt_200ms  ;
reg 		         key1_en   ;
reg 		         key2_en   ;

always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n ==1'b0)
	    cnt_200ms <=24'd0;
	else if (cnt_200ms ==CNT_MAX || key1_en==1'b1 || key2_en==1'b1)
		cnt_200ms <=24'd0;
	else 
        cnt_200ms<= cnt_200ms+1'b1;
		
		 
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n ==1'b0)
		key1_en<=1'b0;
    else if(key2 ==1'b1)
		key1_en<=1'b0;
	else if (key1 ==1'b1)
      	key1_en<=~key1_en;
	else 
		key1_en<=key1_en;
		
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n ==1'b0)
		key2_en<=1'b0;
    else if(key1 ==1'b1)
		key2_en<=1'b0;
	else if (key2 ==1'b1)
      	key2_en<=~key2_en;
	else 
		key2_en<=key2_en;
				
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n ==1'b0)
		addr <=8'd0;
	else 
     begin 
            
        if(addr ==8'd255 && cnt_200ms==CNT_MAX)	
	    	addr <=8'd0;
	    if(key1_en==1'b1)
	    	addr <= 8'd192;
	    if(key2_en==1'b1)	
	    	addr <=8'd162;
	    if(cnt_200ms==CNT_MAX)
	    	addr <=addr+1;
     end    
		
endmodule				