module pcie_irq_deal #
	(
        
	)
	(
		input  clk,
		input  rst_n,
		// Users to add ports here
        input   	user_irq_req_i,
        input   	xdma_irq_ack_i,
        output reg 	xdma_irq_req_o
	);
	
	
reg      user_irq_req_i_r0 ;    //打拍
reg      user_irq_req_i_r1 ;
reg      user_irq_req_i_r2 ;
wire     user_irq_req_i_pedge;


reg      xdma_irq_ack_i_r0 ;    //打拍
reg      xdma_irq_ack_i_r1 ;
reg      xdma_irq_ack_i_r2 ;
wire     xdma_irq_ack_i_pedge;
//*****************************************************
//**                    main code
//*****************************************************



always @(posedge clk) begin
    if(!rst_n) begin
         user_irq_req_i_r0 <= 1'b0;
         user_irq_req_i_r1 <= 1'b0;
         user_irq_req_i_r2 <= 1'b0;
    end
    else begin
         user_irq_req_i_r0 <= user_irq_req_i   ;
         user_irq_req_i_r1 <= user_irq_req_i_r0;
         user_irq_req_i_r2 <= user_irq_req_i_r1;
    end
end

assign user_irq_req_i_pedge = user_irq_req_i_r1 && ~user_irq_req_i_r2;

always @(posedge clk) begin
    if(!rst_n) begin
         xdma_irq_ack_i_r0 <= 1'b0;
         xdma_irq_ack_i_r1 <= 1'b0;
         xdma_irq_ack_i_r2 <= 1'b0;
    end
    else begin
         xdma_irq_ack_i_r0 <= xdma_irq_ack_i   ;
         xdma_irq_ack_i_r1 <= xdma_irq_ack_i_r0;
         xdma_irq_ack_i_r2 <= xdma_irq_ack_i_r1;
    end
end	


assign xdma_irq_ack_i_pedge = xdma_irq_ack_i_r1 && ~xdma_irq_ack_i_r2;
	
always @(posedge clk) begin
	if (!rst_n)
	begin
		xdma_irq_req_o <= 1'b0;
	end 
	else if (xdma_irq_ack_i_pedge)
	begin
		xdma_irq_req_o <= 1'b0;
	end 
	else if (user_irq_req_i_pedge)
	begin
		xdma_irq_req_o <= 1'b1;
	end 
	else 
	begin
		xdma_irq_req_o <= xdma_irq_req_o;
	end 
end


endmodule
