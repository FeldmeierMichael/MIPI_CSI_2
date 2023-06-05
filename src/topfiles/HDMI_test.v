`default_nettype none   //do not allow undeclared wires

module HDMI_test (
    input  wire sys_clk,
    output wire[2:0] led,
    output wire[3:0] TMDS_p,
    output wire[3:0] TMDS_n
    );

    wire[3:0] TMDS;
    reg [24:0] r_count = 0;

    always @(posedge(sys_clk)) r_count <= r_count + 1;

    assign led[0] = r_count[24];
    assign led[1] = r_count[23];
    assign led[2] = r_count[22]; 



    wire clk_high,clk_low,pll_fb;

     HDMI_Transciever HDMI(.clk_low(clk_low),.clk_high(clk_high),.reset(1'b0),.red(8'h00),.green(8'h00),.blue(8'h00),.TMDSd(TMDS));

    OBUFDS TMDS0(.I(TMDS[0]),.O(TMDS_p[0]),.OB(TMDS_n[0]));
    OBUFDS TMDS1(.I(TMDS[1]),.O(TMDS_p[1]),.OB(TMDS_n[1]));
    OBUFDS TMDS2(.I(TMDS[2]),.O(TMDS_p[2]),.OB(TMDS_n[2]));
    OBUFDS TMDS3(.I(TMDS[3]),.O(TMDS_p[3]),.OB(TMDS_n[3]));
    
     PLLE2_BASE #(
        .CLKFBOUT_MULT(5'd5),
        .CLKIN1_PERIOD(10.0),
        .CLKOUT0_DIVIDE(5'd4),
        .CLKOUT0_PHASE(1'd0),
        .CLKOUT1_DIVIDE(4'd20),
        .CLKOUT1_PHASE(1'd0),     
        .DIVCLK_DIVIDE(1'd1),
        .REF_JITTER1(0.01),
        .STARTUP_WAIT("FALSE")
    ) PLLE2_BASE (
        .CLKFBIN(pll_fb),
        .CLKIN1(sys_clk),        
        .CLKFBOUT(pll_fb),
        .CLKOUT0(clk_high),
        .CLKOUT1(clk_low)       
    );
    /*
    PLLE2_ADV #(
	.CLKFBOUT_MULT(5'd16),
	.CLKIN1_PERIOD(10.0),
	.CLKOUT0_DIVIDE(5'd16),
	.CLKOUT0_PHASE(1'd0),
	.CLKOUT1_DIVIDE(4'd8),
	.CLKOUT1_PHASE(1'd0),
	.CLKOUT2_DIVIDE(3'd4),
	.CLKOUT2_PHASE(1'd0),
	.CLKOUT3_DIVIDE(3'd4),
	.CLKOUT3_PHASE(7'd90),
	.CLKOUT4_DIVIDE(4'd8),
	.CLKOUT4_PHASE(1'd0),
	.DIVCLK_DIVIDE(1'd1),
	.REF_JITTER1(0.01),
	.STARTUP_WAIT("FALSE")
) PLLE2_ADV (
	.CLKFBIN(pll_fb),
	.CLKIN1(sys_clk),	
	.RST(0),
	.CLKFBOUT(pll_fb),
	.CLKOUT0(clk_low),
	.CLKOUT1(clk_high)	
);

PLLE2_ADV #(
	.CLKFBOUT_MULT(4'd8),
	.CLKIN1_PERIOD(5.0),
	.CLKOUT0_DIVIDE(5'd20),
	.CLKOUT0_PHASE(1'd0),
	.CLKOUT1_DIVIDE(3'd5),
	.CLKOUT1_PHASE(1'd0),
	.CLKOUT2_DIVIDE(4'd8),
	.CLKOUT2_PHASE(1'd0),
	.DIVCLK_DIVIDE(1'd1),
	.REF_JITTER1(0.01),
	.STARTUP_WAIT("FALSE")
) PLLE2_ADV (
	.CLKFBIN(pll_fb),
	.CLKIN1(sys_clk),
	.PWRDWN(1'b0),
	.RST(1'b0),
	.CLKFBOUT(pll_fb),
	.CLKOUT0(clk_high),
	.CLKOUT1(clk_low)	
);
*/
endmodule
