`timescale 1ns/1ps
module axis_passthrough_monitor
#
(
    parameter AXIS_WIDTH = 32'd48,
    parameter TUSER_WIDTH = 32'd1,
    parameter TDEST_WIDTH = 32'd1,
    parameter TKEEP_WIDTH = 32'd1,
    parameter TSTRB_WIDTH = 32'd1,
    parameter TID_WIDTH = 32'd1,
    parameter FREQ_HZ = 32'd100000000, 
    // Parameters of Axi Slave Bus Interface S_AXI_LITE
    parameter integer C_S_AXI_LITE_DATA_WIDTH	= 32,
    parameter integer C_S_AXI_LITE_ADDR_WIDTH	= 7
)
(
    aclk,
    aresetn,
    //
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tdata,
    s_axis_tlast,
    s_axis_tuser,
    s_axis_tdest,
    s_axis_tkeep,
    s_axis_tstrb,
    s_axis_tid,
    //
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tdata,
    m_axis_tlast,
    m_axis_tuser,
    m_axis_tdest,
    m_axis_tkeep,
    m_axis_tstrb,
    m_axis_tid,
    // Ports of Axi Slave Bus Interface S_AXI
    s_axi_lite_aclk,
    s_axi_lite_aresetn,
    s_axi_lite_awaddr,
    s_axi_lite_awprot,
    s_axi_lite_awvalid,
    s_axi_lite_awready,
    s_axi_lite_wdata,
    s_axi_lite_wstrb,
    s_axi_lite_wvalid,
    s_axi_lite_wready,
    s_axi_lite_bresp,
    s_axi_lite_bvalid,
    s_axi_lite_bready,
    s_axi_lite_araddr,
    s_axi_lite_arprot,
    s_axi_lite_arvalid,
    s_axi_lite_arready,
    s_axi_lite_rdata,
    s_axi_lite_rresp,
    s_axi_lite_rvalid,
    s_axi_lite_rready
);

input aclk;
input aresetn;
//
(* DONT_TOUCH = "yes", s="true",keep="true" *)(* mark_debug="true" *)input                          s_axis_tvalid ;
(* DONT_TOUCH = "yes", s="true",keep="true" *)(* mark_debug="true" *)output                         s_axis_tready ;
(* DONT_TOUCH = "yes", s="true",keep="true" *)(* mark_debug="true" *)input  [AXIS_WIDTH   -1 : 0 ]  s_axis_tdata  ;
(* DONT_TOUCH = "yes", s="true",keep="true" *)(* mark_debug="true" *)input                          s_axis_tlast  ;
(* DONT_TOUCH = "yes", s="true",keep="true" *)(* mark_debug="true" *)input  [TUSER_WIDTH  -1 : 0 ]  s_axis_tuser  ;
(* DONT_TOUCH = "yes", s="true",keep="true" *)(* mark_debug="true" *)input  [TDEST_WIDTH  -1 : 0 ]  s_axis_tdest  ;
(* DONT_TOUCH = "yes", s="true",keep="true" *)(* mark_debug="true" *)input  [TKEEP_WIDTH  -1 : 0 ]  s_axis_tkeep  ;
(* DONT_TOUCH = "yes", s="true",keep="true" *)(* mark_debug="true" *)input  [TSTRB_WIDTH  -1 : 0 ]  s_axis_tstrb  ;
(* DONT_TOUCH = "yes", s="true",keep="true" *)(* mark_debug="true" *)input  [TID_WIDTH    -1 : 0 ]  s_axis_tid    ;
//
(* DONT_TOUCH = "yes", s="true",keep="true" *)output                         m_axis_tvalid ;
(* DONT_TOUCH = "yes", s="true",keep="true" *)input                          m_axis_tready ;
(* DONT_TOUCH = "yes", s="true",keep="true" *)output  [AXIS_WIDTH   -1 : 0 ] m_axis_tdata  ;
(* DONT_TOUCH = "yes", s="true",keep="true" *)output                         m_axis_tlast  ;
(* DONT_TOUCH = "yes", s="true",keep="true" *)output  [TUSER_WIDTH  -1 : 0 ] m_axis_tuser  ;
(* DONT_TOUCH = "yes", s="true",keep="true" *)output  [TDEST_WIDTH  -1 : 0 ] m_axis_tdest  ;
(* DONT_TOUCH = "yes", s="true",keep="true" *)output  [TKEEP_WIDTH  -1 : 0 ] m_axis_tkeep  ;
(* DONT_TOUCH = "yes", s="true",keep="true" *)output  [TSTRB_WIDTH  -1 : 0 ] m_axis_tstrb  ;
(* DONT_TOUCH = "yes", s="true",keep="true" *)output  [TID_WIDTH    -1 : 0 ] m_axis_tid    ;

// Ports of Axi Slave Bus Interface S_AXI
input                                        s_axi_lite_aclk      ;
input                                        s_axi_lite_aresetn   ;
input   [C_S_AXI_LITE_ADDR_WIDTH-1 : 0]      s_axi_lite_awaddr    ;
input   [2 : 0]                              s_axi_lite_awprot    ;
input                                        s_axi_lite_awvalid   ;
output                                       s_axi_lite_awready   ;
input   [C_S_AXI_LITE_DATA_WIDTH-1 : 0]      s_axi_lite_wdata     ;
input   [(C_S_AXI_LITE_DATA_WIDTH/8)-1 : 0]  s_axi_lite_wstrb     ;
input                                        s_axi_lite_wvalid    ;
output                                       s_axi_lite_wready    ;
output  [1 : 0]                              s_axi_lite_bresp     ;
output                                       s_axi_lite_bvalid    ;
input                                        s_axi_lite_bready    ;
input   [C_S_AXI_LITE_ADDR_WIDTH-1 : 0]      s_axi_lite_araddr    ;
input   [2 : 0]                              s_axi_lite_arprot    ;
input                                        s_axi_lite_arvalid   ;
output                                       s_axi_lite_arready   ;
output  [C_S_AXI_LITE_DATA_WIDTH-1 : 0]      s_axi_lite_rdata     ;
output  [1 : 0]                              s_axi_lite_rresp     ;
output                                       s_axi_lite_rvalid    ;
input                                        s_axi_lite_rready    ;


wire                                         s_axi_lite_aclk      ;
wire                                         s_axi_lite_aresetn   ;
wire    [C_S_AXI_LITE_ADDR_WIDTH-1 : 0]      s_axi_lite_awaddr    ;
wire    [2 : 0]                              s_axi_lite_awprot    ;
wire                                         s_axi_lite_awvalid   ;
wire                                         s_axi_lite_awready   ;
wire    [C_S_AXI_LITE_DATA_WIDTH-1 : 0]      s_axi_lite_wdata     ;
wire    [(C_S_AXI_LITE_DATA_WIDTH/8)-1 : 0]  s_axi_lite_wstrb     ;
wire                                         s_axi_lite_wvalid    ;
wire                                         s_axi_lite_wready    ;
wire    [1 : 0]                              s_axi_lite_bresp     ;
wire                                         s_axi_lite_bvalid    ;
wire                                         s_axi_lite_bready    ;
wire    [C_S_AXI_LITE_ADDR_WIDTH-1 : 0]      s_axi_lite_araddr    ;
wire    [2 : 0]                              s_axi_lite_arprot    ;
wire                                         s_axi_lite_arvalid   ;
wire                                         s_axi_lite_arready   ;
wire    [C_S_AXI_LITE_DATA_WIDTH-1 : 0]      s_axi_lite_rdata     ;
wire    [1 : 0]                              s_axi_lite_rresp     ;
wire                                         s_axi_lite_rvalid    ;
wire                                         s_axi_lite_rready    ;


//
assign m_axis_tvalid = s_axis_tvalid ;
assign s_axis_tready = m_axis_tready ;
assign m_axis_tdata  = s_axis_tdata  ;
assign m_axis_tuser  = s_axis_tuser  ;
assign m_axis_tlast  = s_axis_tlast  ;
assign m_axis_tdest  = s_axis_tdest  ;
assign m_axis_tkeep  = s_axis_tkeep  ;
assign m_axis_tstrb  = s_axis_tstrb  ;
assign m_axis_tid    = s_axis_tid    ;

reg [31:0] freq_sec_cnt;
reg freq_sec_flag;
always@(posedge aclk)
begin
    if(!aresetn)
    begin
        freq_sec_cnt <= 32'd0;
        freq_sec_flag <= 1'b0;
    end
    else
    begin
        if(freq_sec_cnt < FREQ_HZ)
        begin
            freq_sec_cnt <= freq_sec_cnt + 1'b1;
            freq_sec_flag <= 1'b0;
        end
        else
        begin
            freq_sec_cnt <= 32'd0;
            freq_sec_flag <= 1'b1;
        end
    end
end

reg [31:0] fps;
(* DONT_TOUCH = "yes", s="true",keep="true" *) (*MARK_DEBUG="TRUE"*)reg [31:0] fps_cnt;
(* DONT_TOUCH = "yes", s="true",keep="true" *) (*MARK_DEBUG="TRUE"*)reg [31:0] fcnt;
wire frame_end;
reg [TUSER_WIDTH-1:0] m_axis_tuser_r;
reg stream_invalid;
always@(posedge aclk)
begin
    m_axis_tuser_r <= m_axis_tuser;
end
assign frame_end = ~m_axis_tuser_r[0]&m_axis_tuser[0];
always@(posedge aclk)
begin
    if(!aresetn)
    begin
        fps <= 32'd0;
        fps_cnt <= 32'd0;
        fcnt <= 32'd0;
        stream_invalid <= 1'b0;
    end
    else
    begin
        if(freq_sec_flag)
        begin
            if(fps_cnt<32'd3)
            begin
                stream_invalid <= 1'b1;
                fcnt <= 32'd0;
            end
            else
            begin
                stream_invalid <= 1'b0;
            end
            fps <= fps_cnt;
            fps_cnt <= 32'd0;
        end
        else
        begin
            if(frame_end)
            begin
               fps_cnt <= fps_cnt +1'b1; 
               fcnt <= fcnt + 1'b1;
            end
        end
    end
end


//
reg [15:0] col;
(* DONT_TOUCH = "yes", s="true",keep="true" *) (*MARK_DEBUG="TRUE"*)reg [15:0] col_cnt;
always@(posedge aclk)
begin
    if(!aresetn)
    begin
        col <= 16'b0;
        col_cnt <= 16'b0;
    end
    else
    begin
        if((s_axis_tvalid ==1'b1) && (s_axis_tlast==1'b1) && (m_axis_tready ==1'b1)) 
        begin
            col <= col_cnt + 1'b1;
            col_cnt <= 16'b0;
        end
        else if((s_axis_tvalid ==1'b1) && (m_axis_tready==1'b1))
        begin
            col_cnt <= col_cnt + 1'b1;
        end
    end
end

reg [15:0] line;
(* DONT_TOUCH = "yes", s="true",keep="true" *) (*MARK_DEBUG="TRUE"*)reg [15:0] line_cnt;
always@(posedge aclk)
begin
    if(!aresetn)
    begin
        line <= 16'b0;
        line_cnt <= 16'b0;
    end
    else
    begin
        if((s_axis_tvalid ==1'b1) && (s_axis_tlast==1'b1) && (m_axis_tready ==1'b1))
        begin
            line_cnt <= line_cnt+1;
        end
        else if((s_axis_tvalid ==1'b1) && (m_axis_tready==1'b1) && (m_axis_tuser[0]==1'b1))
        begin
            line <= line_cnt;
            line_cnt <= 16'b0;    
        end
    end
end
////////////////

// Instantiation of Axi Bus Interface S_AXI_LITE
	S_AXI_LITE_REG_v1_0 # ( 
		.C_S_AXI_LITE_DATA_WIDTH(C_S_AXI_LITE_DATA_WIDTH),
		.C_S_AXI_LITE_ADDR_WIDTH(C_S_AXI_LITE_ADDR_WIDTH)
	) AXI_LITE_REG_v1_0_S_AXI_LITE_inst (
	    .col(stream_invalid ? 32'b0 : col),
        .line(stream_invalid ? 32'b0 : line),
        .fps(stream_invalid ? 32'b0 : fps),
		.S_AXI_ACLK(s_axi_lite_aclk),
		.S_AXI_ARESETN(s_axi_lite_aresetn),
		.S_AXI_AWADDR(s_axi_lite_awaddr),
		.S_AXI_AWPROT(s_axi_lite_awprot),
		.S_AXI_AWVALID(s_axi_lite_awvalid),
		.S_AXI_AWREADY(s_axi_lite_awready),
		.S_AXI_WDATA(s_axi_lite_wdata),
		.S_AXI_WSTRB(s_axi_lite_wstrb),
		.S_AXI_WVALID(s_axi_lite_wvalid),
		.S_AXI_WREADY(s_axi_lite_wready),
		.S_AXI_BRESP(s_axi_lite_bresp),
		.S_AXI_BVALID(s_axi_lite_bvalid),
		.S_AXI_BREADY(s_axi_lite_bready),
		.S_AXI_ARADDR(s_axi_lite_araddr),
		.S_AXI_ARPROT(s_axi_lite_arprot),
		.S_AXI_ARVALID(s_axi_lite_arvalid),
		.S_AXI_ARREADY(s_axi_lite_arready),
		.S_AXI_RDATA(s_axi_lite_rdata),
		.S_AXI_RRESP(s_axi_lite_rresp),
		.S_AXI_RVALID(s_axi_lite_rvalid),
		.S_AXI_RREADY(s_axi_lite_rready)
	);
endmodule
