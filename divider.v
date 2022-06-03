module divider
(
input wire 	sys_clk,

output reg clk_1s,
output reg clk_1ms,
output reg clk_1us
);


integer cnt_1s=0;//24999999
integer cnt_1ms=0;//24999
integer cnt_1us=0;//24
initial clk_1s <=1'b0;
initial clk_1ms<=1'b0;
initial clk_1us<=1'b0;
always@(negedge   sys_clk)
	begin
	cnt_1ms<=cnt_1ms+1;
	cnt_1s <=cnt_1s +1;
	cnt_1us<=cnt_1us+1;
	if(cnt_1s==25000000)		
		cnt_1s <=0;
	if(cnt_1s==24999999)	
		clk_1s <=~clk_1s;		
	if(cnt_1ms==25000)	 
		cnt_1ms <=0;
	if(cnt_1ms==24999)	
		clk_1ms <=~clk_1ms;		
	if(cnt_1us==25)
		cnt_1us <=0;	
	if(cnt_1us==24)
	clk_1us <=~clk_1us;
				
	end
endmodule 	

