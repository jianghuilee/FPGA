module top_dds
(   
	input 			sys_clk		,
	input 			sys_rst_n	,	
	input   		fre_adjust	,
	input   		pha_adjust	,
	input [1:0]		mode_key  	,
							
	output cs				,	//片选
	output series_dac_out	,	//串行数据送给ADC芯片	
	output dac_clk			,//工作时钟Ssys_clk	
	output dac_work_status	//工作状态	

);

wire [1:0]wave_sel;
key_ctrl key_ctrl_inst
(
	.sys_clk	(sys_clk	),
	.sys_rst_n	(sys_rst_n	),	
	.fre_adjust	(fre_adjust),
	.pha_adjust	(pha_adjust),
	.mode_key  ( mode_key  ), 
	
	.wave_sel 	(wave_sel)
);

wire start_flag;
wire [9:0]	dac_data;
dds_ctrl dds_ctrl_nst
(
	.sys_clk	(sys_clk	),
	.sys_rst_n	(sys_rst_n	),
	.fre_adjust	(fre_adjust	),
	.pha_adjust	(pha_adjust	),
	.wave_sel	(wave_sel	),
	
	.start_flag	(start_flag	),
	.dac_data	(dac_data	)
);

tlv5618 tlv5618_inst
(
	.sys_clk			(sys_clk	),		
	.sys_rst_n			(sys_rst_n),
	.parallel_dac_data({6'd100000,dac_data})	,//并行数据输入端
	.start_flag		(start_flag		)	,			//开始标志位

	.set_Done		(set_Done		)	,			//完成标志位							
	.cs				(cs				)	,	//片选
	.series_dac_out	(series_dac_out )	,	//串行数据送给ADC芯片	
	.dac_clk		(dac_clk		)	,//工作时钟Ssys_clk	
	.dac_work_status(dac_work_status)		//工作状态	
							
);
endmodule