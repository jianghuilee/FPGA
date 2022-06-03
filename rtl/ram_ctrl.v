module ram_ctrl
#(
parameter  CNT_MAX1=24'd9_999_999
)
(
input  wire		sys_clk		,
input  wire		sys_rst_n	,
input  wire 	wr_flag		,
input  wire 	rd_flag		,

output reg 	wr_en		,
output reg[7:0]addr		,
output reg[7:0]wr_data	,
output reg 	rd_en		

);
reg [23:0]	cnt_200ms;
//200ms读时间
always@(posedge sys_clk or negedge sys_rst_n)
	if(!sys_rst_n)
		cnt_200ms<=1'b0;
	else if(wr_en==1'b1)
		cnt_200ms<=1'b0;
	else if(cnt_200ms==CNT_MAX1)
		cnt_200ms<=1'b0;
	else if(rd_en==1'b1)
		cnt_200ms<=cnt_200ms+1'b1;
	else 	
		cnt_200ms<=cnt_200ms;
			
//Rd_EN
always@(posedge sys_clk or negedge sys_rst_n)
	if(!sys_rst_n)
		rd_en<=1'b0;
	//要写的时候(优先)	
	else 
		begin 
		if(wr_en==1'b1)	
			rd_en<=1'b0;
		else if(rd_flag	==1'b0)
			rd_en<=1'b1;	
		end
//WR_EN
always@(posedge sys_clk or negedge sys_rst_n)
	if(!sys_rst_n)
		wr_en<=1'b0;
	else		
		begin	
		if(wr_en==1'b1 && addr==8'd255)				 
			wr_en<=1'b0;
		//写完了
		if(wr_flag==1'b0)
			wr_en<=1'b1;
		end
				
//addr
always@(posedge sys_clk or negedge sys_rst_n)
	if(!sys_rst_n)
		addr<=8'd0;
	else	
		begin 
		if(wr_en==1'b1)	
			begin 
				if(addr==8'd255)
					addr<=8'd0;
				else 
					addr<=addr+1'b1;
			end		
		else //wr_en==1'b0
			begin
				if(rd_en==1'b1)
				  begin 
					if(wr_flag==1'b0)
						addr<=8'd0;
					if(addr==8'd255)
						addr<=8'd0;
					else if(cnt_200ms==CNT_MAX1-1)
						addr<=addr+1'b1;
					else if(addr<8'd255 && rd_flag==1'b0)
						addr<=8'd0;
				  end
				else 			
					    addr<=8'd0;
			end	
		end	
always@(*)
	if(wr_en==1'b1)
		wr_data<=addr; 			
endmodule