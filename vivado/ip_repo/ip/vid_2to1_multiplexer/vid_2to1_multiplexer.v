`timescale 1ns / 1ns
`define UD #1

module vid_2to1_multiplexer
(
    input                port_sel,
    
    input                pclk0   ,
    input 	        	 VS0     , 
    input                HS0     ,
    input                DE0     ,	 
    input	[23:0]       dout0_0 ,
    input	[23:0]	     dout0_1 ,

    input                pclk1   , 
    input 	        	 VS1     , 
    input                HS1     ,
    input                DE1     ,	 
    input	[23:0]       dout1_0 ,
    input	[23:0]	     dout1_1 ,
 
    output              pclk     ,	 
    output              VS       ,
    output              HS       ,
    output              DE       ,
    output  [23:0]      dout0    ,
    output  [23:0]      dout1 
);

wire    pclk_i;
assign  pclk_i = port_sel ?  pclk1   : pclk0   ;
assign  VS     = port_sel ?  VS1     : VS0     ;
assign  HS     = port_sel ?  HS1     : HS0     ;
assign  DE     = port_sel ?  DE1     : DE0     ;
assign  dout0  = port_sel ?  dout1_0 : dout0_0 ;
assign  dout1  = port_sel ?  dout1_1 : dout0_1 ;

BUFG bg_pclk
(
    .I          (pclk_i), 
    .O          (pclk)
) ;

endmodule
