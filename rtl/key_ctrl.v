module key_ctrl
(
	input wire			sys_clk		,
	input wire			sys_rst_n	,	
	input wire  		fre_adjust,
	input wire  		pha_adjust,
	input wire [1:0]	mode_key  ,
	
	output reg [1:0]	wave_sel 	
);

always@(posedge sys_clk or negedge sys_rst_n)
	if(!sys_rst_n)
		wave_sel<=4'b0001;
	else 
		begin
		case(mode_key)
		2'b00:wave_sel<=2'b00;
		2'b01:wave_sel<=2'b01;
		2'b10:wave_sel<=2'b10;
		2'b11:wave_sel<=2'b11;
		default:wave_sel<=wave_sel;
		endcase
		end
	
endmodule 