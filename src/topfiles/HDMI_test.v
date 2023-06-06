`default_nettype none   //do not allow undeclared wires
/*
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
        .CLKOUT1_DIVIDE(4),    // 125 MHz
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
*/


// (c) fpga4fun.com & KNJN LLC 2013-2023

////////////////////////////////////////////////////////////////////////
module HDMI_test (
    input  wire sys_clk,
    output wire[2:0] led,
    output wire[3:0] TMDS_p,
    output wire[3:0] TMDS_n,
	output wire SDA,SCL,HPD
    );

////////////////////////////////////////////////////////////////////////
wire[2:0] TMDSn;
wire[2:0] TMDSp;
wire TMDSp_clock, TMDSn_clock;

assign TMDS_p[0]=TMDSp[0];
assign TMDS_p[1]=TMDSp[1];
assign TMDS_p[2]=TMDSp[2];
assign TMDS_p[3]=TMDSp_clock;

assign TMDS_n[0]=TMDSn[0];
assign TMDS_n[1]=TMDSn[1];
assign TMDS_n[2]=TMDSn[2];
assign TMDS_n[3]=TMDSn_clock;

reg [9:0] CounterX=0, CounterY=0;
reg hSync, vSync, DrawArea;
wire pll_fb,pixclk;
always @(posedge pixclk) DrawArea <= (CounterX<640) && (CounterY<480);

always @(posedge pixclk) CounterX <= (CounterX==799) ? 0 : CounterX+1;
always @(posedge pixclk) if(CounterX==799) CounterY <= (CounterY==524) ? 0 : CounterY+1;

always @(posedge pixclk) hSync <= (CounterX>=656) && (CounterX<752);
always @(posedge pixclk) vSync <= (CounterY>=490) && (CounterY<492);

////////////////
wire [7:0] W = {8{CounterX[7:0]==CounterY[7:0]}};
wire [7:0] A = {8{CounterX[7:5]==3'h2 && CounterY[7:5]==3'h2}};
reg [7:0] red, green, blue;
always @(posedge pixclk) red <= ({CounterX[5:0] & {6{CounterY[4:3]==~CounterX[4:3]}}, 2'b00} | W) & ~A;
always @(posedge pixclk) green <= (CounterX[7:0] & {8{CounterY[6]}} | W) & ~A;
always @(posedge pixclk) blue <= CounterY[7:0] | W | A;

////////////////////////////////////////////////////////////////////////
wire [9:0] TMDS_red, TMDS_green, TMDS_blue;
TMDS_encoder encode_R(.clk(pixclk), .VD(red  ), .CD(2'b00)        , .VDE(DrawArea), .TMDS(TMDS_red));
TMDS_encoder encode_G(.clk(pixclk), .VD(green), .CD(2'b00)        , .VDE(DrawArea), .TMDS(TMDS_green));
TMDS_encoder encode_B(.clk(pixclk), .VD(blue ), .CD({vSync,hSync}), .VDE(DrawArea), .TMDS(TMDS_blue));

////////////////////////////////////////////////////////////////////////
wire clk_TMDS;  // 25MHz x 10 = 250MHz
////////////////////////////////////////////////////////////////////////
reg [3:0] TMDS_mod10=0;  // modulus 10 counter
reg [9:0] TMDS_shift_red=0, TMDS_shift_green=0, TMDS_shift_blue=0;
reg TMDS_shift_load=0;
always @(posedge clk_TMDS) TMDS_shift_load <= (TMDS_mod10==4'd9);

always @(posedge clk_TMDS)
begin
	TMDS_shift_red   <= TMDS_shift_load ? TMDS_red   : TMDS_shift_red  [9:1];
	TMDS_shift_green <= TMDS_shift_load ? TMDS_green : TMDS_shift_green[9:1];
	TMDS_shift_blue  <= TMDS_shift_load ? TMDS_blue  : TMDS_shift_blue [9:1];	
	TMDS_mod10 <= (TMDS_mod10==4'd9) ? 4'd0 : TMDS_mod10+4'd1;
end

OBUFDS OBUFDS_red  (.I(TMDS_shift_red  [0]), .O(TMDSp[2]), .OB(TMDSn[2]));
OBUFDS OBUFDS_green(.I(!TMDS_shift_green[0]), .O(TMDSp[1]), .OB(TMDSn[1]));
OBUFDS OBUFDS_blue (.I(!TMDS_shift_blue [0]), .O(TMDSp[0]), .OB(TMDSn[0]));
OBUFDS OBUFDS_clock(.I(pixclk), .O(TMDSp_clock), .OB(TMDSn_clock));


PLLE2_BASE    #(
        .BANDWIDTH("OPTIMIZED"),    // OPTIMIZED, HIGH, LOW
        .CLKFBOUT_MULT(10),    // Multiply value for all CLKOUT (2-64)
        .CLKFBOUT_PHASE(0.0),    // Phase offset in degrees of CLKFB, (-360-360)
        .CLKIN1_PERIOD(10.0),    // Input clock period in ns to ps resolution
        // CLKOUT0_DIVIDE - CLKOUT5_DIVIDE: divide amount for each CLKOUT(1-128)
        .CLKOUT0_DIVIDE(40),    // 25 MHz
        .CLKOUT1_DIVIDE(4),    // 250 MHz
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
        .CLKOUT0(pixclk),
        .CLKOUT1(clk_TMDS),        
        .CLKFBOUT(pll_fb), // 1-bit output, feedback clock        .
        .CLKIN1(sys_clk),
        .PWRDWN(1'b0),
        .RST(1'b0),
        .CLKFBIN(pll_fb)    // 1-bit input, feedback clock
    );

endmodule


////////////////////////////////////////////////////////////////////////
module TMDS_encoder(
			input clk,
			input [7:0] VD,  // video data (red, green or blue)
			input [1:0] CD,  // control data
			input VDE,  // video data enable, to choose between CD (when VDE=0) and VD (when VDE=1)
			output reg [9:0] TMDS = 0
		);

	wire [3:0] Nb1s = VD[0] + VD[1] + VD[2] + VD[3] + VD[4] + VD[5] + VD[6] + VD[7];
	wire XNOR = (Nb1s>4'd4) || (Nb1s==4'd4 && VD[0]==1'b0);
	wire [8:0] q_m = {~XNOR, q_m[6:0] ^ VD[7:1] ^ {7{XNOR}}, VD[0]};

	reg [3:0] balance_acc = 0;
	wire [3:0] balance = q_m[0] + q_m[1] + q_m[2] + q_m[3] + q_m[4] + q_m[5] + q_m[6] + q_m[7] - 4'd4;
	wire balance_sign_eq = (balance[3] == balance_acc[3]);
	wire invert_q_m = (balance==0 || balance_acc==0) ? ~q_m[8] : balance_sign_eq;
	wire [3:0] balance_acc_inc = balance - ({q_m[8] ^ ~balance_sign_eq} & ~(balance==0 || balance_acc==0));
	wire [3:0] balance_acc_new = invert_q_m ? balance_acc-balance_acc_inc : balance_acc+balance_acc_inc;
	wire [9:0] TMDS_data = {invert_q_m, q_m[8], q_m[7:0] ^ {8{invert_q_m}}};
	wire [9:0] TMDS_code = CD[1] ? (CD[0] ? 10'b1010101011 : 10'b0101010100) : (CD[0] ? 10'b0010101011 : 10'b1101010100);

	always @(posedge clk) TMDS <= VDE ? TMDS_data : TMDS_code;
	always @(posedge clk) balance_acc <= VDE ? balance_acc_new : 4'h0;
endmodule


////////////////////////////////////////////////////////////////////////