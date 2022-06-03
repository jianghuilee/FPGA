module rom_top
#
(
parameter  CNT_MAX =24'd9_999_999
)
(
input wire 		sys_clk   , 
input wire 		sys_rst_n ,
input wire 		key1      ,
input wire      key2      ,


output   [3:0]  led_bit   ,
output   [7:0]  led_out

);

wire        [7:0] addr;
wire        [7:0] data;




rom_ctrl 
#
(
. CNT_MAX (24'd9_999_999)
)
rom_ctrl_inst
(
.sys_clk  (sys_clk), 
.sys_rst_n(sys_rst_n),
.key1     (key1),
.key2     (key2),

. addr	(addr) 
);



rom_8x256	rom_8x256_inst 
(
	.address ( addr ),
	.clock ( sys_clk ),
	.q ( data )
	);
    

wire [15:0]bcd_out;
binary_bcd binary_bcd_inst
( 

. data     (data),

. bcd_out  (bcd_out)            
);    


smg_dynamic
#(
.CNT_SCAN_MAX (16'd49_999   )
)
smg_dynamic_inst
(
.sys_clk	 (sys_clk	),
.sys_rst_n   (sys_rst_n),
.databcd       (bcd_out),
             
.led_bit     (led_bit),
.led_out     (led_out)
);
 
endmodule 
