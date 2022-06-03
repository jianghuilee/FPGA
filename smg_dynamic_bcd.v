module smg_dynamic_bcd
(
input  sys_clk	    ,
input  sys_rst_n    ,
input  key1         ,
input  key2         ,
output  [3:0]led_bit,
output  [7:0]led_out
);

rom_ctrl
#
(
. CNT_MAX (24'd9_999_999)
)
rom_ctrl_inst
(
sys_clk   (sys_clk  ), 
sys_rst_n (sys_rst_n),
key1      (key1     ),
key2      (key2     ),

.addr	  (addr)
);
wire [7:0]addr;

rom_8x256	rom_8x256_inst 
(
	.address ( addr ),
	.clock ( sys_clk ),
	.q ( q_sig )
	);
    
binary_bcd binary_bcd_inst
(
. data    (q_sig) ,

. bcd_out (bcd_out)
);
wire [11:0] bcd_out;
smg_dynamic
#(
.CNT_SCAN_MAX(20'd49_999)
)
smg_dynamic_inst
(
.   sys_clk	  (sys_clk)  ,
.   sys_rst_n (sys_rst_n)  ,
.databcd      (bcd_out)  ,
 
.led_bit      (led_bit)  ,
.led_out      (led_out)  
);

endmodule