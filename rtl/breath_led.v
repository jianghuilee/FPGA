module breath_led
(
input wire sys_clk,

output reg	led
);
 
reg led_mode;
wire clk_1s  ;
wire clk_1ms ;
wire clk_1us ;

integer cntus=0;//每1ms计数1000次，即每1us计数一次
integer flag=0;//控制脉宽的增减
initial led<=1'b1;
initial led_mode<=1'b0;


divider divider_inst
(
.sys_clk	(sys_clk),

.clk_1s		(clk_1s	),
.clk_1ms	(clk_1ms),
.clk_1us    (clk_1us)
);
always@(posedge clk_1us)
 begin	
		if(cntus==2000)
			cntus<=0;
		else 	
		cntus<=cntus+1;	
 end	
 
always@(posedge clk_1ms)
	begin 			
		if(flag==2000)
			flag<=0;
		else 	
		flag<=flag+1;	
	end 


always@(posedge clk_1s)		
	led_mode=~led_mode;
	
		
always@(posedge sys_clk)
begin 
	case(led_mode)
	1'b0:begin 
		if(cntus<=flag)
			led<=1'b1;
		else led<=1'b0;		
	  end		
	1'b1:begin
		if(flag<=cntus)
			led<=1'b0;
		else led<=1'b1;				
	  end	
	endcase
end
endmodule 