module ram_top
(
input  	sys_clk		,
input  	sys_rst_n	,
input  	wr_flag		,
input  	rd_flag		,

output  [3:0]led_bit ,
output  [7:0]led_out
);

wire wr_en	         ;
wire [7:0]addr	     ;
wire [7:0]wr_data    ;
wire rd_en	         ;

ram_ctrl 
#(
.CNT_MAX1(24'd9_999_999)
)
ram_ctrl_inst
(
.sys_clk	(sys_clk	)	,
.sys_rst_n	(sys_rst_n	),
.wr_flag	(wr_flag	)	,
.rd_flag	(rd_flag	)	,

.wr_en		(wr_en	),
.addr		(addr	),
.wr_data	(wr_data)	,
.rd_en		(rd_en	)

);

wire [7:0] dataout;

ram_8x256_one	ram_8x256_one_inst 
(
	.aclr ( ~sys_rst_n ),
	.address ( addr ),
	.clock (sys_clk ),
	.data ( wr_data ),
	.rden ( rd_en ),
	.wren ( wr_en ),
	
	.q ( dataout )
	);
	
wire [15:0] bcd_out;
	
 binary_bcd  binary_bcd_inst
(
.data     (dataout) ,

. bcd_out (bcd_out)
);


smg_dynamic
#(
.CNT_SCAN_MAX(16'd49_999)
)
smg_dynamic_inst
(
.sys_clk	(sys_clk)    ,
.sys_rst_n  (sys_rst_n)  ,
.databcd	(bcd_out),

.led_bit 	(led_bit),
.led_out    (led_out)
);

endmodule 