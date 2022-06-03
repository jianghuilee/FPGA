module  leaft
#(
parameter CNT_SCAN_MAX= 20'd249_999
)
(
input wire sys_clk			,//50mhz时钟输入信号
input wire [3:0]floor_input	,//楼层选择输入信号
output reg [3:0]led_bit 	,//段选信号
output reg [7:0]led_out 	,//位选信号
output  beep
);
wire clk_2s;				 //分频后得到的2秒时钟信号
reg [19:0]cnt_scan;  		 //
initial  cnt_scan<=20'd0;    
integer cnt_bitcount=0;      	 //0~3 对应4个数码管选择标志位

reg [7:0]need_open_flag;    	 //8存储8层楼呼梯\选梯状态的寄存器
initial  need_open_flag<=8'd0;   

reg [3:0]floor_now; 		 //当前楼层层数寄存器
initial floor_now=4'd1;

reg move_direction;		     //楼层行进的方向,1向上，0向下
initial move_direction=1;
reg open_flag;
initial open_flag=0;
wire ring_flag;       

reg wait_flag; //检测电梯是在无人的等待还是忙状态
initial wait_flag=1;
//显示时间|扫描时间生成
always@(posedge sys_clk )
	begin            
        cnt_scan<=cnt_scan+20'd1;           
            if(cnt_scan==CNT_SCAN_MAX)
                begin
                cnt_scan<=20'd0;   
                end  
            if(cnt_scan==CNT_SCAN_MAX-1)       
                cnt_bitcount<=cnt_bitcount+1;   
            if(cnt_bitcount ==4 ) 
                cnt_bitcount<=0;            
	end	

integer cnt_2s=0;	
//确定是否到达呼叫的某一层数，重新允许呼梯、开门、并且把本层的呼梯标志拉低
//读取呼梯信号到呼梯状态寄存器
assign ring_flag= (open_flag&&(~wait_flag));
always@(posedge sys_clk )
	begin
	//表示没有人呼梯不动,触发等待状态
		if((need_open_flag[7:1]==7'd0)&&(floor_now==4'd1))
			begin
				wait_flag<=1;
			end		
		else 	wait_flag<=0;
	end
//电梯运作
always@(posedge clk_2s)	
	begin
	//处于忙碌状态才可以消除呼梯和选递信号，否则需要一直等待呼梯	
	if(wait_flag==0)   
	  begin		
			//选梯和呼梯过程	
			if(open_flag==1) //2s内允许呼梯状态下检测到了呼梯信号将对应的标志位拉高
			  begin
				case(floor_input)			
				4'd1:begin				
						need_open_flag[0]<=1;
						
					 end
				4'd2:begin
						need_open_flag[1]<=1;
						
					 end
				4'd3:begin
						need_open_flag[2]<=1;
					
					 end
				4'd4:begin
						need_open_flag[3]<=1;
						
					 end
				4'd5:begin
						need_open_flag[4]<=1;
					
					 end
				4'd6:begin
						need_open_flag[5]<=1;
						
					 end
				4'd7:begin
						need_open_flag[6]<=1;
					
					 end
				4'd8:begin
						need_open_flag[7]<=1;
					
					 end
				default:need_open_flag<=need_open_flag;
				endcase	
			  end	
	   end	
	//处于等待状态需要无限等待呼梯，直到有人呼梯改变工作状态  
	else
	  begin
				case(floor_input)			
				4'd1:begin				
						need_open_flag[0]<=1;
						
					 end
				4'd2:begin
						need_open_flag[1]<=1;
					
					 end
				4'd3:begin
						need_open_flag[2]<=1;
						
					 end
				4'd4:begin
						need_open_flag[3]<=1;
		
					 end
				4'd5:begin
						need_open_flag[4]<=1;

					 end
				4'd6:begin
						need_open_flag[5]<=1;

					 end
				4'd7:begin
						need_open_flag[6]<=1;

					 end
				4'd8:begin
						need_open_flag[7]<=1;

					 end
				default:need_open_flag<=need_open_flag;
				endcase	
	   end
	//有人呼梯开始运转,处于忙状态才运转电梯	
		if(~wait_flag)
			begin	
				if(move_direction==1)
					begin
						floor_now=floor_now+4'b1;	
						if(floor_now==4'd9)
							begin
							move_direction<=0;
							end
					end	
				else 	
					begin
						floor_now=floor_now-4'b1;	
						if(floor_now==4'd0)
							begin
							move_direction<=1;
							end
					end		
			end		
	
		//到达的楼层消除其需要开门标志，表示到达过了
		case(floor_now)
		4'd0:begin
				need_open_flag<=0;
				open_flag=0;
				floor_now<=4'd1;
			end
			
		4'd1:
			begin
				if(wait_flag==1)
					open_flag=0;
				else if(move_direction==0)
					open_flag=1;
			end	
		4'd2:begin
				if(need_open_flag[1]==1)				
					begin
						open_flag=1;
						need_open_flag[1]<=0;
					end
				else 	open_flag=0;
			end
		4'd3:begin
				if(need_open_flag[2]==1)				
					begin
						open_flag=1;
						need_open_flag[2]<=0;
						
					end
				else 	open_flag=0;	
			end
		4'd4:begin
				if(need_open_flag[3]==1)				
					begin
						open_flag=1;
						need_open_flag[3]<=0;	
					end	
						
				else 	open_flag=0;
			end
		4'd5:begin
				if(need_open_flag[4]==1)				
					begin
						open_flag=1;
						need_open_flag[4]<=0;	
					end
				else 	open_flag=0;
			end
		4'd6:begin
				if(need_open_flag[5]==1)				
					begin
						open_flag=1;
						need_open_flag[5]<=0;
						
					end
				else 	open_flag=0;
			end
		4'd7:begin
				if(need_open_flag[6]==1)				
					begin
						open_flag=1;
						need_open_flag[6]=0;
					end
				else 	open_flag=0;	
			end
		4'd8:begin
				if(need_open_flag[7]==1)				
					begin
						open_flag=1;
						need_open_flag[7]=0;
						
					end
				else 	open_flag=0;
			end	
		4'd9:begin	
				need_open_flag[7]=0;
				open_flag=0;
				floor_now<=4'd8;
			end	
		default:
				begin
				open_flag=0;
				end
		endcase		
				
	end	
 //段扫描+位显示
 //向上显示 UCH楼层数表示在上升的过程中并且可以选择层数
 //向下显示 DCH楼层数表示在下降的过程中并且可以选择层数
 //开门呼梯 [-]楼层数开门过程可以被呼梯
 //等待状态  【_】1表示在第一层等待
always@(*)  
    begin 
        case(cnt_bitcount)   
            3: 
                begin
                    led_bit<=4'b0111; 
					case(wait_flag)  
						0://不处于等待状态
						begin
							case(open_flag)	
								1:  //允许呼梯状态，开门状态显示【
									led_out<=8'b11000110;
									
								0:	//运行中显示运行的方向
								begin 
									if(move_direction==1 )
										led_out<=8'b11000001; //u
									else 
										led_out<=8'b10100001; //d
								end		
								default:
									led_out<=8'b11000110;
							endcase
						end	
						1://处于等待状态
						 begin									
									led_out<=8'b11000110;															
						 
						 end
					endcase	
                end
            2: 
                begin				
                    led_bit<=4'b1011;   
					case(wait_flag)  						
						0://不处于等待状态
							begin
								case(open_flag)	
									1:  //到达
										led_out<=8'b10111111;															
									0:	
									begin
										if(move_direction==1)
									    //允许中显示方向up_p | dn_n
										led_out<=8'b10001100;	
										else	
										led_out<=8'b11001000;	
									end	
									default:
											led_out<=8'b10111111;						
								endcase
							end
						1://处于等待状态
							begin									
									led_out<=8'b11110110;																			 
							end	
					endcase	 
                end
            1: 
                begin
                    led_bit<=4'b1101; 
					case(wait_flag)  						
						0://不处于等待状态
						 begin
								case(open_flag)	
									1:  //到达 ]
										led_out<=8'b11110000;															
									0:	//运行中显示 -
									begin
										led_out<=8'b10111111;
									end	
									default:
											led_out<=8'b10111111;						
								endcase
							
						 end		
						1://处于等待状态
						 begin									
									led_out<=8'b11110000;																			 
						 end	
					endcase			
                end
           
            0: 
                begin
                    led_bit<=4'b1110;   
					//最后一位显示楼层
						case(floor_now)
						4'd0: led_out<=8'b11111001;
						4'd1: led_out<=8'b11111001;
						4'd2: led_out<=8'b10100100;
						4'd3: led_out<=8'b10110000;
						4'd4: led_out<=8'b10011001;
						4'd5: led_out<=8'b10010010;  
						4'd6: led_out<=8'b10000010; 
						4'd7: led_out<=8'b11111000;
						4'd8: led_out<=8'b10000000;   
						4'd9: led_out<=8'b10000000; 		
						default led_out<=8'b11111111; 	
						endcase	
                end
			default led_bit<=4'b1111;   
        endcase        
    end  
	
divider_2s divider_2s_inst
(
.sys_clk(sys_clk),


.clk_2s (clk_2s)
);



beep beep_inst
(
.  sys_clk(sys_clk),
. key	  (ring_flag),

.beep 	  (beep)
);
endmodule