`timescale 1ns/1ns
                
module vid_2to1_multiplexer_tb();

//时钟周期参数定义					        
    parameter		CLOCK_CYCLE = 20; 

    reg              port_sel;//端口选择 
//第一个通道    
    reg              pclk0   ;
    reg 	         VS0     ; 
    reg              HS0     ;
    reg              DE0     ;	 
    reg	[23:0]       dout0_0 ;
    reg	[23:0]	     dout0_1 ;
//第二个通道 
    reg              pclk1   ; 
    reg 	         VS1     ; 
    reg              HS1     ;
    reg              DE1     ;	 
    reg	[23:0]       dout1_0 ;
    reg	[23:0]	     dout1_1 ;

//输出通道 
    wire            pclk ;	 
    wire            VS   ;
    wire            HS   ;
    wire            DE   ;
    wire     [23:0] dout0;
    wire     [23:0] dout1;
                                         

vid_2to1_multiplexer  vid_2to1_multiplexer_inst
(
/*    input   [1:0]      */.port_sel(port_sel), 
/*    input              */.pclk0   (pclk0   ), //第一个通道    
/*    input 	         */.VS0     (VS0     ),
/*    input              */.HS0     (HS0     ),
/*    input              */.DE0     (DE0     ),	 
/*    input	[23:0]       */.dout0_0 (dout0_0 ),
/*    input	[23:0]	     */.dout0_1 (dout0_1 ),
/*    input              */.pclk1   (pclk1   ), //第二个通道 
/*    input 	         */.VS1     (VS1     ), 
/*    input              */.HS1     (HS1     ),
/*    input              */.DE1     (DE1     ),	 
/*    input	[23:0]       */.dout1_0 (dout1_0 ),
/*    input	[23:0]	     */.dout1_1 (dout1_1 ),
/*    output   reg       */.pclk    (pclk    ), //输出通道  
/*    output   reg       */.VS      (VS      ),
/*    output   reg       */.HS      (HS      ),
/*    output   reg       */.DE      (DE      ),
/*    output  reg  [23:0]*/.dout0   (dout0   ),
/*    output  reg  [23:0]*/.dout1   (dout1   )
);	
//产生时钟							       	
                                                   
//产生激励							       	
initial  begin	
    port_sel= 2'b00;
    pclk0   = 0;
    VS0     = 0;
    HS0     = 0;
    DE0     = 0;
    dout0_0 = 0;
    dout0_1 = 0;
    pclk1   = 0;
    VS1     = 0;
    HS1     = 0;
    DE1     = 0;
    dout1_0 = 0;
    dout1_1 = 0;
    #(CLOCK_CYCLE*2);
    repeat(6)
    begin
        port_sel= port_sel + 1'b1;
        pclk0   = $random;
        VS0     = $random;
        HS0     = $random;
        DE0     = $random;
        dout0_0 = $random;
        dout0_1 = $random;
        pclk1   = $random;
        VS1     = $random;
        HS1     = $random;
        DE1     = $random;
        dout1_0 = $random;
        dout1_1 = $random;
        #(CLOCK_CYCLE*2);	 
    end	
		            						
    $stop;                                                                                          
                                                   
end 									       	
endmodule 									       	
