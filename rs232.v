module rs232(
	input	wire	sys_clk	,	//系统时钟 50MHz
	input	wire	sys_rst_n	,	//全局复位

	input	wire	rx	,	//串口接收数据
	output	wire	tx	
);		//串口发送数据

//********************************************************************//
 //****************** Parameter and Internal Signal *******************//
 //********************************************************************// 12
	//parameter define
	parameter	UART_BPS	=	14'd9600;	//比特率
	parameter	CLK_FREQ	=	26'd50_000_000; //时钟频率 16
	//wire define
	wire	[7:0]	po_data;
	wire	po_flag ;
 //********************************************************************//
 //*************************** Instantiation **************************//
 //********************************************************************// 24

 //
 uart_rx  #(

	.UART_BPS	(UART_BPS),	//串口波特率
	.CLK_FREQ	(CLK_FREQ)	//时钟频率 30 
	)uart_rx_inst
  (
	.sys_clk	(sys_clk	), //input	sys_clk
	.sys_rst_n (sys_rst_n ), //input	sys_rst_n
	.rx	(rx	), //input	rx 36
	.po_data	(po_data	), //output	[7:0]	po_data
	.po_flag	(po_flag	)	//output	po_flag 39 
	);


 //
 uart_tx  #(
 

	.UART_BPS	(UART_BPS),	//串口波特率
	.CLK_FREQ	(CLK_FREQ)	//时钟频率 46 
	)
 uart_tx_inst  
 (
	.sys_clk	(sys_clk	), //input	sys_clk
	.sys_rst_n (sys_rst_n ), //input	sys_rst_n
	.pi_data	(po_data	), //input	[7:0]	pi_data
	.pi_flag	(po_flag	), //input	pi_flag 53
	.tx	(tx	)	//output	tx 55 
	);

 endmodule
