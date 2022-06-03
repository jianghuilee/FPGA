`timescale 1ns/1ns
module tb_tlv5618();

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





reg [15:0]parallel_dac_data;


wire  et_Done		  	;
wire  cs				;
wire  eries_dac_out	  	;
wire  ac_clk			;
wire  dac_work_status 	;

tlv5618 tlv5618_inst
(
	.sys_clk					(sys_clk	),
	.sys_rst_n					(sys_rst_n),
	.parallel_dac_data	(parallel_dac_data),	//并行数据输入端
	.start_flag					(start_flag)	,			//开始标志位
	
	.et_Done					( et_Done		 )   ,						//完成标志位							
	.cs							( cs			),	//片选
	.eries_dac_out				( eries_dac_out	 ),	//串行数据送给ADC芯片	
	.ac_clk						( ac_clk		),//工作时钟Ssys_clk	
	.dac_work_status			( dac_work_status)	//工作状态	
							
);



endmodule