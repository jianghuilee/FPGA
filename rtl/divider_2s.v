module divider_2s
(
input wire 	sys_clk,


output reg clk_2s


);

integer cnt_2s=0;
initial clk_2s <=1'b0;


always@(posedge   sys_clk)
	begin
	cnt_2s <=cnt_2s +1;
	// if(clk_1_9s==49999990)	
		// begin
		// clk_1_9s <=0;
		// clk_1_9s <=~clk_1_9s;	
		// end
	if(cnt_2s==49999999)
		begin 
		cnt_2s <=0;
		clk_2s <=~clk_2s;		
		end		
	end	
	
	
endmodule 	