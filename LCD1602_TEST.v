module LCD1602_TEST(clk,rst,LCD_E,LCD_RW,LCD_RS,LCD_DATA);  
input clk;                
input rst;                
output LCD_E;           
output LCD_RS;            
output LCD_RW;            
output [7:0] LCD_DATA;   
wire LCD_E;  
reg [8:0] count;  
reg clk_div1;        
reg clk_div2;        
reg [7:0] count1;    
reg clk_buf;  
//******************  

//******************  
always @(posedge clk or negedge rst)  
begin  
    if(!rst)    //rst=0  
        count<=0;  
    else  
        begin  
            if(count<250)        //2500  
                begin  
                    clk_div1<=0;  
                    count<=count+1'b1;  
                end  
            else if(count>=500-1)        //5000  
                count<=0;  
            else  
                begin  
                    clk_div1<=1;  
                    count<=count+1'b1;  
                end               
        end  
end  
always @(posedge clk_div1 or negedge rst)  
begin  
    if(!rst)  
        clk_div2<=0;  
    else  
        clk_div2<=~clk_div2;  
end  
always @(posedge clk_div2 or negedge rst)     
begin  
    if(!rst)    //rst=0  
        begin  
            count1<=0;  
            clk_buf<=0;      //  
        end  
    else  
        begin  
            if(count1<125)       //2500  
                begin  
                    clk_buf<=0;  
                    count1<=count1+1'b1;  
                end  
            else if(count1>=250-1)       //5000  
                count1<=0;  
            else  
                begin  
                    clk_buf<=1;  
                    count1<=count1+1'b1;  
                end               
        end  
end  
assign LCD_E=clk_buf;  
  
//**********************  
 
//**********************  
reg [4:0] state;        
reg [5:0] address;     
reg [7:0] LCD_DATA;  
reg LCD_RW,LCD_RS;  
parameter     
        IDLE             = 4'd0,       
        CLEAR            = 4'd1,  
        SET_FUNCTION     = 4'd2,       
        SWITCH_MODE      = 4'd3,     
        SET_MODE         = 4'd4,      
        SET_DDRAM1       = 4'd5,      
        WRITE_RAM1       = 4'd6,     
        SET_DDRAM2       = 4'd7,      
        WRITE_RAM2       = 4'd8,     
        SHIFT            = 4'd9,    
        STOP             = 4'd10;  
              
reg [7:0] Data_First [15:0];  
reg [7:0] Data_Second [15:0];  
initial  
    begin  
        Data_First[0] =  8'h41;  
        Data_First[1] =  "e";  
        Data_First[2] =  "l";  
        Data_First[3] =  "l";  
        Data_First[4] =  "o";  
        Data_First[5] =  "!";  
        Data_First[6] =  " ";  
        Data_First[7] =  "M";  
        Data_First[8] =  "y";  
        Data_First[9] =  " ";  
        Data_First[10]=  "D";  
        Data_First[11]=  "r";  
        Data_First[12]=  "e";  
        Data_First[13]=  "a";  
        Data_First[14]=  "m";  
        Data_First[15]=  "!";  
          
        Data_Second[0] =   "L";  
        Data_Second[1] =   "C";  
        Data_Second[2] =   "D";  
        Data_Second[3] =   "1";  
        Data_Second[4] =   "6";  
        Data_Second[5] =   "0";  
        Data_Second[6] =   "2";  
        Data_Second[7] =   " ";  
        Data_Second[8] =   "T";  
        Data_Second[9] =   "e";  
        Data_Second[10]=   "s";  
        Data_Second[11]=   "T";  
        Data_Second[12]=   " ";  
        Data_Second[13]=   "O";  
        Data_Second[14]=   "K";  
        Data_Second[15]=   " ";  
  
//      Data_First[0] =  "a";  
//      Data_First[1] =  "b";  
//      Data_First[2] =  "c";  
//      Data_First[3] =  "d";  
//      Data_First[4] =  "e";  
//      Data_First[5] =  "f";  
//      Data_First[6] =  "g";  
//      Data_First[7] =  "h";  
//      Data_First[8] =  "i";  
//      Data_First[9] =  "j";  
//      Data_First[10]=  "k";  
//      Data_First[11]=  "l";  
//      Data_First[12]=  "n";  
//      Data_First[13]=  "m";  
//      Data_First[14]=  "o";  
//      Data_First[15]=  "p";  
//        
//      Data_Second[0] =   "Q";  
//      Data_Second[1] =   "W";  
//      Data_Second[2] =   "E";  
//      Data_Second[3] =   "R";  
//      Data_Second[4] =   "T";  
//      Data_Second[5] =   "Y";  
//      Data_Second[6] =   "U";  
//      Data_Second[7] =   "A";  
//      Data_Second[8] =   "S";  
//      Data_Second[9] =   "D";  
//      Data_Second[10]=   "F";  
//      Data_Second[11]=   "G";  
//      Data_Second[12]=   "Z";  
//      Data_Second[13]=   "X";  
//      Data_Second[14]=   "C";  
//      Data_Second[15]=   "V";  
    end  
//----------  
always @(posedge clk_buf or negedge rst)        // clk_div1 clk_buf  
begin  
    if(!rst)  
        begin  
            state<=IDLE;  
            address<=6'd0;  
            LCD_DATA<=8'b0000_0000;  
            LCD_RS<=0;  
            LCD_RW<=0;  
        end  
    else  
        begin  
            case(state)  
                IDLE:      
                            begin  
                                LCD_DATA<=8'bzzzz_zzzz;      //8'bzzzz_zzzz  
                                state<=CLEAR;  
                            end  
                CLEAR:        
                                begin  
                                    LCD_RS<=0;  
                                    LCD_RW<=0;  
                                    LCD_DATA<=8'b0000_0001;  //??  
                                    state<=SET_FUNCTION;                           
                                end  
                SET_FUNCTION:        
                                begin  
                                    LCD_RS<=0;  
                                    LCD_RW<=0;  
                                    LCD_DATA<=8'b0011_1100;      //38h  
                       
                                    state<=SWITCH_MODE;        
                                end  
                SWITCH_MODE:
                                begin  
                                    LCD_RS<=0;  
                                    LCD_RW<=0;  
                                    LCD_DATA<=8'b0000_1111;      //0Fh  
                          
                                    state<=SET_MODE;  
                                end  
                SET_MODE:          
                                begin  
                                    LCD_RS<=0;  
                                    LCD_RW<=0;  
                                    LCD_DATA<=8'b0000_0110;  //06h  
                                   
                                    state<=SHIFT;   
                                end               
                SHIFT:         
                                begin  
                                    LCD_RS<=0;  
                                    LCD_RW<=0;  
                                    LCD_DATA<=8'b0001_0100;    
                              
                                    state<=SET_DDRAM1;   
                                end  
                SET_DDRAM1:     
                                begin    
                                    LCD_RS<=0;  
                                    LCD_RW<=0;  
                              
                //-----????????????-----   
                //  1   2  3  4   5   6   7  8  9  10  11  12  13  14  15  16  
                // 00  01 02  03  04  05 06 07 08  09  0A  0B  0C  0D  0E  0F   ???  
                                    LCD_DATA<=8'h80+8'd0; //????1???   
                                      
                                    address<=6'd0;  
                                    state<=WRITE_RAM1;   
//                                  Data_First_Buf<=Data_First;    
                                end  
                WRITE_RAM1:     
                                begin  
                                    if(address<=15)            
                                        begin  
                                            LCD_RS<=1;  
                                            LCD_RW<=0;  
                                            LCD_DATA<=Data_First[address];  
//                                          Data_First_Buf<=(Data_First_Buf<<8);   //
                                            address<=address+1'b1;  
                                            state<=WRITE_RAM1;  
                                        end  
                                    else  
                                        begin  
                                            LCD_RS<=0;  
                                            LCD_RW<=0;  
                                            LCD_DATA<=8'h80+address;  
                                            state<=SET_DDRAM2;  
                                        end  
                                end  
                SET_DDRAM2:    
                                begin    
                                    LCD_RS<=0;  
                                    LCD_RW<=0;  
                              
                //-----???2????????-----   
                //  1   2  3  4   5   6   7  8  9  10  11  12  13  14  15  16  
                // 40  41 42  43  44  45 46 47 48  49  4A  4B  4C  4D  4E  4F     
                                    LCD_DATA<=8'hC0+8'd0; 
                              
                                    state<=WRITE_RAM2;   
//                                  Data_Second_Buf<=Data_Second;    
                                    address<=6'd0;  
                                end  
                WRITE_RAM2:      
                            begin  
                                if(address<=15)          
                                        begin  
                                            LCD_RS<=1;  
                                            LCD_RW<=0;  
                                            LCD_DATA<=Data_Second[address];  
//                                          Data_Second_Buf<=(Data_Second_Buf<<8);   
                                            address<=address+1'b1;  
                                            state<=WRITE_RAM2;  
                                        end  
                                    else  
                                        begin  
                                            LCD_RS<=0;  
                                            LCD_RW<=0;  
                                            LCD_DATA<=8'hC0+address;  
                                            state<=STOP;  
                                        end  
                            end  
                STOP:         
                            begin  
                                            state<=STOP;  
                                            address<=6'd0;  
                                            LCD_RW<=1;  
                            end  
                default:  
                            state<=CLEAR;  
            endcase               
        end  
end  
      
endmodule 

