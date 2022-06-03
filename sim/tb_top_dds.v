`timescale 1ns/1ns
module tb_top_dds();

reg			sys_clk		;
reg			sys_rst_n   ;
reg  		fre_adjust  ;
reg  		pha_adjust  ;
reg [1:0]	mode_key	;

wire set_Done			;
wire cs				    ;
wire series_dac_out     ;
wire dac_clk			;
wire dac_work_status    ;
	
initial 
	begin 
		sys_clk<=1'b1;
		sys_rst_n<=1'b0;
		mode_key<=2'b00;
		fre_adjust<=1'b0;
		pha_adjust<=1'b0;
		#200
		sys_rst_n<=1'b1;		
	//频率步进测试	
		mode_key<=2'b11;	
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
		mode_key<=2'b10;
		#2000000;
		mode_key<=2'b01;
		#2000000;
		mode_key<=2'b00;
		#2000000;
		mode_key<=2'b11;
	end

always #1 sys_clk= ~sys_clk;	
top_dds top_dds_inst
(   
	.	sys_clk				(	sys_clk		),
	.	sys_rst_n			(	sys_rst_n	),	
	.  fre_adjust			(  fre_adjust	),
	.  pha_adjust			(  pha_adjust	),
	.  mode_key  			( mode_key  )	 ,  
	 
								
	. cs					( cs			),	//片选
	. series_dac_out		( series_dac_out),	//串行数据送给ADC芯片	
	. dac_clk				( dac_clk		),//工作时钟Ssys_clk	
	. dac_work_status		( dac_work_status)//工作状态	

);


endmodule 

