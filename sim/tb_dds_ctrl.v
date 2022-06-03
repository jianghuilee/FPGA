`timescale 1ns/1ns
module tb_dds_ctrl();

reg sys_clk;
reg sys_rst_n;
reg [1:0]wave_sel;
reg fre_adjust  ;
reg pha_adjust  ;
initial 
	begin 
		sys_clk<=1'b1;
		sys_rst_n<=1'b0;
		wave_sel<=2'b00;
		fre_adjust<=1'b0;
		pha_adjust<=1'b0;
		#200
		sys_rst_n<=1'b1;		
	//频率步进测试	
		wave_sel<=2'b00;	
		//fre_adjust<=1'b1;
		//pha_adjust<=1'b1;
		// fre_adjust<=1'b0;
		//pha_adjust<=1'b0;
		#2000000;
		//// fre_adjust<=1'b1;
		//pha_adjust<=1'b1;
		//#10
		//// fre_adjust<=1'b0;
		//pha_adjust<=1'b0;
		//#2000000;
		//// fre_adjust<=1'b1;
		//pha_adjust<=1'b1;
		//#10
		//// fre_adjust<=1'b0;
		//pha_adjust<=1'b0;
		//#2000000;
		//// fre_adjust<=1'b1;
		//pha_adjust<=1'b1;
		//#10
		//// fre_adjust<=1'b0;
		//pha_adjust<=1'b0;
		//#2000000;
		//// fre_adjust<=1'b1;
		//pha_adjust<=1'b1;
		//#10
		//// fre_adjust<=1'b0;
		//pha_adjust<=1'b0;
		//#2000000;
		//// fre_adjust<=1'b1;
		//pha_adjust<=1'b1;
		//#10
		//// fre_adjust<=1'b0;
		//pha_adjust<=1'b0;
		//#2000000;
		//// fre_adjust<=1'b1;
		//pha_adjust<=1'b1;
		//#10
		//// fre_adjust<=1'b0;
		//pha_adjust<=1'b0;
		//#2000000;
		//// fre_adjust<=1'b1;
		//pha_adjust<=1'b1;
		//#10
		//// fre_adjust<=1'b1;
		//pha_adjust<=1'b1;
		//#2000000;
		//// fre_adjust<=1'b1;
		//pha_adjust<=1'b1;
		//#10
		//// fre_adjust<=1'b1;
		//pha_adjust<=1'b1;
		//#2000000;
		//// fre_adjust<=1'b1;
		//pha_adjust<=1'b1;
		//#10
		//// fre_adjust<=1'b1;
		//pha_adjust<=1'b1;	
		wave_sel<=2'b01;
		#2000000;
		wave_sel<=2'b10;
		#2000000;
		wave_sel<=2'b11;
		#2000000;
		wave_sel<=2'b00;
	end
always #1 sys_clk= ~sys_clk;

wire start_flag;
wire [9:0]dac_data_out;
dds_ctrl  dds_ctrl_inst
(
	.sys_clk	(sys_clk	),
	.sys_rst_n	(sys_rst_n	),
	.wave_sel	(wave_sel	),
	.fre_adjust	(fre_adjust) ,
	.pha_adjust	(pha_adjust) ,
	
	. 	start_flag(start_flag),
	.dac_data	(dac_data_out	)
	

);






endmodule 