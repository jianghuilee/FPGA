`timescale 1ns/1ns
module tb_breath_led();
reg sys_clk;
initial 
	begin
	sys_clk<=0;
	
	end
	
wire led;	
always#10	sys_clk<=~sys_clk;
 breath_led breath_led_inst
(
. sys_clk( sys_clk),

. led(led)
);

endmodule