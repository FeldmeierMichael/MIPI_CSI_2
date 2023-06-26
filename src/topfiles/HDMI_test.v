`default_nettype none   //do not allow undeclared wires

module HDMI_test (
    input  wire sys_clk,
    output wire[2:0] led,
    output wire[3:0] TMDS_p,
    output wire[3:0] TMDS_n,
	output wire SDA,SCL, HPD
    
    );	
    wire[3:0] TMDS;

    wire clk_high,clk_low,pll_fb;
    wire[20:0] read_addr;

     HDMI_Transciever HDMI(.clk_low(clk_low),.clk_high(clk_high),.reset(1'b0),.red(rgb_v),.green(rgb_v),.blue(rgb_v),.TMDSd(TMDS),.addr(read_addr));

    OBUFDS  TMDS0(.I(TMDS[0]),.O(TMDS_p[0]),.OB(TMDS_n[0]));
    OBUFDS  TMDS1(.I(TMDS[1]),.O(TMDS_p[1]),.OB(TMDS_n[1]));
    OBUFDS  TMDS2(.I(TMDS[2]),.O(TMDS_p[2]),.OB(TMDS_n[2]));
    OBUFDS  TMDS3(.I(TMDS[3]),.O(TMDS_p[3]),.OB(TMDS_n[3]));	
    
    PLLE2_BASE  #(
                .BANDWIDTH("OPTIMIZED"),    // OPTIMIZED, HIGH, LOW
                .CLKFBOUT_MULT(10),    // Multiply value for all CLKOUT (2-64)
                .CLKFBOUT_PHASE(0.0),    // Phase offset in degrees of CLKFB, (-360-360)
                .CLKIN1_PERIOD(10.0),    // Input clock period in ns to ps resolution
                // CLKOUT0_DIVIDE - CLKOUT5_DIVIDE: divide amount for each CLKOUT(1-128)
                .CLKOUT0_DIVIDE(40),    // 25 MHz
                .CLKOUT1_DIVIDE(8),    // 125 MHz
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
   
    wire[31:0] ramdata;
    reg[7:0] counter;
    reg[31:0] color_w;
    reg[7:0] rgb_v;

    dpram_dualclock DPR(.addr_b(read_addr[18:2]),
	.we_b(0),.clk_b(clk_low),.data_out(ramdata));

    assign rgb_v= ramdata[7:0];

    /*always @(posedge clk_low) begin		
		if(counter>=3)begin
			counter<=0;
			color_w<=ramdata;
		end else begin
			counter<=counter+1;
			color_w<={8'h00,color_w[31:8]};			
		end
		rgb_v<=color_w[7:0];		
	end*/
    
endmodule


module dpram_dualclock
	(
		input [31:0] data_a, data_b,
		input [16:0] addr_a,input [16:0] addr_b,input[1:0]bank,
		input we_a, we_b, clk, clk_b,
		output reg [31:0] data_out
	);
		reg [31:0] ram[511:0];	
		//initial $readmemh("testimage.mem",ram);	

		// Port A 
		always @ (posedge clk)
		begin		
			if(we_a)begin
				ram[addr_a] <= data_a;
			end		
		end 
		// Port B 
		always @ (posedge clk_b)
            begin
                data_out<=ram[addr_b];		
            end
		
endmodule
