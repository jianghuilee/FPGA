`timescale  1ns/1ns
module  tb_beep();

reg     sys_clk     ;   //时钟
reg     sys_rst_n   ;   //复位



//对时钟，复位信号赋初值
initial
    begin
        sys_clk     =   1'b1;
        sys_rst_n   <=  1'b0;
        #100
        sys_rst_n   <=  1'b1;
    end

//产生时钟信号
always #10 sys_clk =   ~sys_clk;

beep
#(
    .TIME_500MS(25'd24999),   //0.5s计数值
    .DO        (18'd190  ),   //"哆"音调分频计数值（频率262）
    .RE        (18'd170  ),   //"来"音调分频计数值（频率294）
    .MI        (18'd151  ),   //"咪"音调分频计数值（频率330）
    .FA        (18'd143  ),   //"发"音调分频计数值（频率349）
    .SO        (18'd127  ),   //"梭"音调分频计数值（频率392）
    .LA        (18'd113  ),   //"拉"音调分频计数值（频率440）
    .XI        (18'd101  )    //"西"音调分频计数值（频率494）
)
beep_inst
(
    .sys_clk     (sys_clk   ),   //系统时钟,频率50MHz
    .sys_rst_n   (sys_rst_n ),   //系统复位，低有效

    .beep        (beep      )    //输出蜂鸣器控制信号
);

endmodule
