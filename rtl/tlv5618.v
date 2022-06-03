module tlv5618(
	input sys_clk,		
	input sys_rst_n,
	input [15:0] parallel_dac_data,//并行数据输入端
	input start_flag,			//开始标志位
	
	output reg set_Done,			//完成标志位							
	output reg cs				,	//片选
	output reg series_dac_out	,	//串行数据送给ADC芯片	
	output reg dac_clk			,//工作时钟Ssys_clk	
	output dac_work_status	//工作状态	
							
);
assign dac_work_status = cs;
reg sys_clkd2;					//二分频时钟
reg [5:0] sys_clkd2_GEN_CNT;	//Ssys_clk生成序列机计数器


reg [15:0] r_DAC_DATA;			//数据寄存器
reg [3:0] DIV_CNT;				//分频计数器
reg en;							//转换使能信号
wire trans_done; 				//转换序列完成标志信号


always@(posedge sys_clk or negedge sys_rst_n)
	if(!sys_rst_n)
		en <= 1'b0;
	else if(!start_flag)
		en <= 1'b1;
	else if(trans_done)
		en <= 1'b0;	//转换完成后将使能关闭
	else
		en <= en;
		
	//分频计数器
always@(posedge sys_clk or negedge sys_rst_n)
if(!sys_rst_n)
	DIV_CNT <= 4'd0;
else if(en)
	begin
		if(DIV_CNT == 1'b1)	//前面设置了分频系数为2，这里计数器能够容纳2拍时钟脉冲
			DIV_CNT <= 4'd0;
		else 
			DIV_CNT <= DIV_CNT + 1'b1;
	end
else
	DIV_CNT <= 4'd0;
	
//二分频
always@(posedge sys_clk or negedge sys_rst_n)
	if(!sys_rst_n)
		sys_clkd2 <= 1'b0;
	else if(en && (DIV_CNT ==1'b1))
		sys_clkd2 <= 1'b1;
	else
		sys_clkd2 <= 1'b0;	
		
//生成序列计数器，sys_clkd2
	always@(posedge sys_clk or negedge sys_rst_n)
	if(!sys_rst_n)
		sys_clkd2_GEN_CNT <= 6'd0;
	else if(sys_clkd2 && en)begin	//在高脉冲期间，累计拍数
		if(sys_clkd2_GEN_CNT == 6'd32)
			sys_clkd2_GEN_CNT <= 6'd0;
		else
			sys_clkd2_GEN_CNT <= sys_clkd2_GEN_CNT + 1'd1;
		end
	else
		sys_clkd2_GEN_CNT <= sys_clkd2_GEN_CNT;		
		
			always@(posedge sys_clk or negedge sys_rst_n)
	if(!sys_rst_n)
		r_DAC_DATA <= 16'd0;
	else if(!start_flag)	//收到开始发送命令时，寄存DAC_DATA值
		r_DAC_DATA <= parallel_dac_data;
	else
		r_DAC_DATA <= r_DAC_DATA;
				
	//依次将数据移出到DAC芯片
	always@(posedge sys_clk or negedge sys_rst_n)
	if(!sys_rst_n)begin
		series_dac_out <= 1'b1;
		dac_clk <= 1'b0;
		cs <= 1'b1;
		end
	else begin
		cs <= 1'b0;
		case(sys_clkd2_GEN_CNT)
			0:
				begin	//高脉冲期间内，计数为0时了，打开片选使能，给予时钟上升沿，将最高位数据送给ADC芯片
					series_dac_out <= 1'b1;
					dac_clk <= 1'b1;
				end
		
			1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31:
				begin
					dac_clk <= 1'b0;	//时钟低电平
				end
			
			2:  begin series_dac_out <= 1'b0; dac_clk <= 1'b1; end
			4:  begin series_dac_out <= 1'b0; dac_clk <= 1'b1; end
			6:  begin series_dac_out <= 1'b0; dac_clk <= 1'b1; end
			8:  begin series_dac_out <= 1'b1; dac_clk <= 1'b1; end			
			10: begin series_dac_out <= 1'b1; dac_clk <= 1'b1; end
			12: begin series_dac_out <= r_DAC_DATA[9];  dac_clk <= 1'b1; end
			14: begin series_dac_out <= r_DAC_DATA[8];  dac_clk <= 1'b1; end
			16: begin series_dac_out <= r_DAC_DATA[7];  dac_clk <= 1'b1; end	
			18: begin series_dac_out <= r_DAC_DATA[6];  dac_clk <= 1'b1; end
			20: begin series_dac_out <= r_DAC_DATA[5];  dac_clk <= 1'b1; end				
			22: begin series_dac_out <= r_DAC_DATA[4];  dac_clk <= 1'b1; end
			24: begin series_dac_out <= r_DAC_DATA[3];  dac_clk <= 1'b1; end
			26: begin series_dac_out <= r_DAC_DATA[2];  dac_clk <= 1'b1; end
			28: begin series_dac_out <= r_DAC_DATA[1];  dac_clk <= 1'b1; end			
			30: begin series_dac_out <= r_DAC_DATA[0];  dac_clk <= 1'b1; end
            
			default:;
		endcase
	end
	
	//assign trans_done = (sys_clkd2_GEN_CNT == 33) && sys_clkd2; 转换完成
	
	// always@(posedge sys_clk or negedge sys_rst_n)
	// if(!sys_rst_n)
		// set_Done <= 1'b0;
	// else if(trans_done)
		// set_Done <= 1'b1;
	// else
		// set_Done <= 1'b0;
endmodule

		