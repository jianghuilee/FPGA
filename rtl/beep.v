module beep
(
input 	     sys_clk	,
input  key		,

output reg beep 	
);

integer mi_cnt =0;


reg mi_flag=0;

integer cnt_1s=0;
reg ring_time_flag;
initial ring_time_flag=0;

always@(posedge sys_clk)
	begin 

	    mi_cnt = mi_cnt  +1;
		if(mi_cnt==151_515 )
			mi_cnt=0;
			if(mi_cnt==151_514)
				mi_flag=~mi_flag;
			else 	
				mi_flag=mi_flag;	
	end
always@(posedge sys_clk)  
    begin 
		if(key)
			begin
				cnt_1s<=cnt_1s+1;
				if((cnt_1s<=12000000 )&& (cnt_1s>=1))
					begin
						ring_time_flag<=1;
						if(ring_time_flag)
							beep<=mi_flag;
						else 
							beep<=0;
					end
				else 	ring_time_flag<=0;
			end	
		else 
			begin
				cnt_1s<=0;
				beep<=0;
				ring_time_flag<=0;
			end	
			
	end
		
       
       
endmodule 