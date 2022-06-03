module fifo
(
  input wire       sys_clk  ,
  input wire [7:0] pi_date  ,
  input wire       rd_req   ,
  input wire       wr_req   ,
  
  output wire      empty    ,
  output wire      full     ,
  output wire[7:0] po_date  , 
  output wire[7:0] usew    
);
 
scfifo_8x256	scfifo_8x256_inst (
	.clock ( sys_clk ),
	.data  ( pi_date ),
	.rdreq ( rd_req  ),
	.wrreq ( wr_req  ),
    
	.empty (empty    ),
	.full  (full     ),
	.q     (po_date  ),
	.usedw (usew     )
	);
 
 
 
 
 endmodule