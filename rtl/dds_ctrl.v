module dds_ctrl
(
	input wire 			sys_clk,
	input wire 			sys_rst_n,
	input wire  		fre_adjust,
	input wire  		pha_adjust,
	input wire [1:0]	wave_sel,
	
	output reg 		start_flag,
	output wire [9:0]	dac_data		
);

parameter FRE_CNT_MAX=999;
parameter PHA_CNT_MAX=8;
parameter FRE_STEP=8580;
parameter PHA_STEP=1024;
integer 		fre_cnt=0;//(测试)100hz步进 100~10_000 (99)
integer			pha_cnt=0;//pi/8步进 0~7pi/8	  (8)
reg 	[31:0]	F_WORD;//控制频率，2^32*（需要频率）/50mhz
reg 	[31:0]	P_WORD;//控制相位，（需要相位）*2^14/(2*pi)
initial   F_WORD=32'd8580; //（初值100）
initial   P_WORD=32'd0;//（初相位0）


reg 	[31:0]	fre_add;
reg 	[11:0]	rom_addr_reg;
reg 	[13:0]	rom_addr;
always@(posedge fre_adjust or negedge sys_rst_n)
	if(!sys_rst_n)
		begin
			fre_cnt<=0;
		end
	else	
		begin				
			fre_cnt<=fre_cnt+1;
			if(fre_cnt==FRE_CNT_MAX)
				begin
				fre_cnt<=0;	
				end
			else 
				F_WORD<=fre_cnt*FRE_STEP;
		end
always@(posedge pha_adjust or negedge sys_rst_n)
	if(!sys_rst_n)
		begin
			pha_cnt<=0;
		end
	else	
		begin			
			pha_cnt<=pha_cnt+1;
			if(pha_cnt==PHA_CNT_MAX)
				begin
				pha_cnt<=0;		
				end
			else	
				P_WORD<=pha_cnt*PHA_STEP;
		end


always@(posedge sys_clk or negedge sys_rst_n)
 if(!sys_rst_n)
	fre_add<=32'd0; 
 else
	begin
	fre_add<=fre_add+F_WORD+1'b1; 
	end	
	
always@(posedge sys_clk or negedge sys_rst_n)
 if(!sys_rst_n)	
	begin
		rom_addr_reg	<= 12'd0;
	
	end
 else 
	begin
	rom_addr_reg<=fre_add[31:20]+P_WORD; 
	end
reg [13:0] be_rom_addr	;	
always@(posedge sys_clk or negedge sys_rst_n)
 if(!sys_rst_n)
	begin
		be_rom_addr=14'd0; 
	end 
 else 
	begin
		be_rom_addr=rom_addr_reg;
		case(wave_sel) 
		2'b11:rom_addr<=rom_addr_reg;
		2'b10:rom_addr<=rom_addr_reg+14'd4096;
		2'b01:rom_addr<=rom_addr_reg+14'd8192;
		2'b00:rom_addr<=rom_addr_reg+14'd12288;
		default:rom_addr<=rom_addr_reg;
		endcase
		
	end
	
always@(posedge sys_clk or negedge sys_rst_n)
	if(!sys_rst_n)
		start_flag<=1'b0;
	else	
		begin
			if(be_rom_addr==rom_addr)
			start_flag<=1'b0;
			else 
			start_flag<=1'b1;	
		end

rom_wave	rom_wave_inst (
	.address ( rom_addr ),
	.clock ( sys_clk ),
	.q ( dac_data )
	);
endmodule 