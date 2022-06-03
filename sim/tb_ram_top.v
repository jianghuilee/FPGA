`timescale 1ns/1ns
module tb_ram_top();

reg sys_clk		;
reg sys_rst_n	;
reg wr_flag		;
reg rd_flag		;

initial 
	begin 
	sys_clk		<=1'b1;
	sys_rst_n	<=1'b0;
	wr_flag		<=1'b0;
    rd_flag		<=1'b0;
	#20 
	sys_rst_n	<=1'b1;
	#1000
//read	
	rd_flag		<=1'b1;
	#20
	rd_flag		<=1'b0;
	#60_000
//write
	wr_flag		<=1'b1;
	#20
	wr_flag		<=1'b0;
	#6000
//read	
	rd_flag		<=1'b1;
	#20
	rd_flag		<=1'b0;
	#60_000	
//read	
	rd_flag		<=1'b1;
	#20
	rd_flag		<=1'b0;
	
    end
always #10 sys_clk=~sys_clk;	

wire [3:0]led_bit   ;
wire [7:0]led_out   ;

ram_top ram_top_inst
(
.sys_clk	(sys_clk	),
.sys_rst_n	(sys_rst_n	),
.wr_flag	(wr_flag	),
.rd_flag	(rd_flag	),

.led_bit 	(led_bit 	),
.led_out	(led_out	)
);

endmodule 
