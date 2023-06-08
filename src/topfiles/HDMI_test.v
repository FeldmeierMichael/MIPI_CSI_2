`default_nettype none   //do not allow undeclared wires

module HDMI_test (
    input  wire sys_clk,
    output wire[2:0] led,
    output wire[3:0] TMDS_p,
    output wire[3:0] TMDS_n,
	output wire SDA,SCL,HPD
    );	
    wire[3:0] TMDS;



    wire clk_high,clk_high2,clk_low,clk_low2,pll_fb;

     HDMI_Transciever HDMI(.clk_low(clk_low),.clk_high(clk_high),.reset(1'b0),.red(8'h00),.green(8'hff),.blue(8'h00),.TMDSd(TMDS));

    OBUFDS  TMDS0(.I(TMDS[0]),.O(TMDS_p[0]),.OB(TMDS_n[0]));
    OBUFDS  TMDS1(.I(TMDS[1]),.O(TMDS_p[1]),.OB(TMDS_n[1]));
    OBUFDS  TMDS2(.I(TMDS[2]),.O(TMDS_p[2]),.OB(TMDS_n[2]));
    OBUFDS  TMDS3(.I(TMDS[3]),.O(TMDS_p[3]),.OB(TMDS_n[3]));

	
    
    PLLE2_BASE    #(
        .BANDWIDTH("OPTIMIZED"),    // OPTIMIZED, HIGH, LOW
        .CLKFBOUT_MULT(10),    // Multiply value for all CLKOUT (2-64)
        .CLKFBOUT_PHASE(0.0),    // Phase offset in degrees of CLKFB, (-360-360)
        .CLKIN1_PERIOD(10.0),    // Input clock period in ns to ps resolution
        // CLKOUT0_DIVIDE - CLKOUT5_DIVIDE: divide amount for each CLKOUT(1-128)
        .CLKOUT0_DIVIDE(40),    // 25 MHz
        .CLKOUT1_DIVIDE(8),    // 250 MHz
        .CLKOUT2_DIVIDE(8),    // 100 MHz
        .CLKOUT3_DIVIDE(16),    //  50 MHz
        .CLKOUT4_DIVIDE(32),    //  25 MHz
        .CLKOUT5_DIVIDE(16),
        // CLKOUT0_DUTY_CYCLE -- Duty cycle for each CLKOUT
        .CLKOUT0_DUTY_CYCLE(0.5),
        .CLKOUT1_DUTY_CYCLE(0.5),
        .CLKOUT2_DUTY_CYCLE(0.5),
        .CLKOUT3_DUTY_CYCLE(0.5),
        .CLKOUT4_DUTY_CYCLE(0.5),
        .CLKOUT5_DUTY_CYCLE(0.5),
        // CLKOUT0_PHASE -- phase offset for each CLKOUT
        .CLKOUT0_PHASE(0.0),
        .CLKOUT1_PHASE(90.0),
        .CLKOUT2_PHASE(0.0),
        .CLKOUT3_PHASE(0.0),
        .CLKOUT4_PHASE(0.0),
        .CLKOUT5_PHASE(0.0),
        .DIVCLK_DIVIDE(1),    // Master division value , (1-56)
        .REF_JITTER1(0.0),    // Reference input jitter in UI (0.000-0.999)
        .STARTUP_WAIT("FALSE")    // Delayu DONE until PLL Locks, ("TRUE"/"FALSE")
    ) genclock(
        // Clock outputs: 1-bit (each) output
        .CLKOUT0(clk_low),
        .CLKOUT1(clk_high),        
        .CLKFBOUT(pll_fb), // 1-bit output, feedback clock        .
        .CLKIN1(sys_clk),
        .PWRDWN(1'b0),
        .RST(1'b0),
        .CLKFBIN(pll_fb)    // 1-bit input, feedback clock
    );

endmodule
