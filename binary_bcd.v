module  binary_bcd
(
 input [7:0] data       ,

 output  [15:0] bcd_out
);
reg [3:0] num_3 ;
reg [3:0] num_2 ;
reg [3:0] num_1 ;
reg [3:0] num_0 ;

integer i;
 
always@(data) //将162的二进制码转换成BCD码，并将个位数、十位数、百位数保存至num_0、num_1、num_2
	begin 
        num_3=4'd0;
        num_2=4'd0;
		num_1=4'd0;
		num_0=4'd0;
 
		for(i=7;i>=0;i=i-1)   //162的二进制码是1010 0010，总共8位，所以循环位数是8
			begin	
                if(num_3>=5)
					num_3=num_3+3;
                if(num_2>=5)
					num_2=num_2+3;
				if(num_1>=5)
					num_1=num_1+3;
				if(num_0>=5)
					num_0=num_0+3;
                num_3 = num_3<<1;
				num_3[0] = num_2[3];   
                
				num_2 = num_2<<1;
				num_2[0] = num_1[3];
 
                num_1 = num_1<<1;
				num_1[0] = num_0[3];
 
				num_0 = num_0<<1;
				num_0[0]= data[i];
			end		
     end     
assign  bcd_out={num_3,num_2,num_1,num_0};
endmodule