/*module HDMI_Transciever
		#(parameter
		h_pixel=640,				  
		h_front_porch=16,		
		h_back_porch=48,		
		h_tot_pixel=800,				  
		v_pixel=480,				  
		v_front_porch=10,		
		v_back_porch=33,		
		v_tot_pixel=525)
		(input clk_low,input clk_high,input reset,input[7:0] red,input[7:0] green,input[7:0] blue,output[20:0] addr,
		output[3:0] TMDSd);
	////////////////////////////////////////////////////////////////////////
		
	////////////////////////////////////////////////////////////////////////
	reg [10:0] CounterX=0, CounterY=0;
	reg hSync=0, vSync=0;
	reg[1:0]  DrawArea=0;
	reg[20:0] addr_r;

	assign addr=addr_r;
		
	always @(posedge clk_low) DrawArea <=(reset==1)? 0 :( (CounterX<h_pixel) && (CounterY<v_pixel));
	always @(posedge clk_low)begin
		if(reset==1)begin
			CounterX<=0;
			addr_r=0;
		end else begin			
		if(CounterX==h_tot_pixel-1)begin
			CounterX <=0;			
		end else begin
			CounterX <=CounterX+1;		
			addr_r=(DrawArea==1)?addr_r+1:addr_r;			
		end
		vSync <= ((CounterY>=v_pixel+v_front_porch) && (CounterY<v_tot_pixel-v_back_porch)&&(CounterX<h_tot_pixel-2))||((CounterY==v_pixel+v_front_porch-1)&& (CounterX>=h_tot_pixel-2));
		if(CounterX==h_tot_pixel-1)begin			
			CounterY <= (CounterY==v_tot_pixel-1) ? 0 : CounterY+1;	
			addr_r = (CounterY==v_tot_pixel-1) ? 0 : addr_r;	
			
		end
		end		
		end	
	
	
	always @(posedge clk_low) hSync <=(reset==1)? 0 : ((CounterX>=h_pixel+h_front_porch) && (CounterX<h_tot_pixel-h_back_porch));		
		////////////////////////////////////////////////////////////////////////
	wire [9:0] TMDS_red, TMDS_green, TMDS_blue;	
	wire TMDS_r,TMDS_b,TMDS_g;
	////////////////////////////////////////////////////////////////////////
	reg [3:0] TMDS_mod10;  // modulus 10 counter
	reg [9:0] TMDS_shift_red, TMDS_shift_green, TMDS_shift_blue;
	reg TMDS_shift_load;
	always @(posedge clk_high) TMDS_shift_load <= (reset==1)? 0 : (TMDS_mod10==4'd4);
	always @(posedge clk_high)
	begin
		if(reset==1) begin
			TMDS_shift_red<=0;
			TMDS_shift_green<=0;
			TMDS_shift_blue<=0;
			TMDS_mod10<=0;	
		end
		else begin
		TMDS_shift_red   <= TMDS_shift_load ? TMDS_red   : TMDS_shift_red  [9:2];
		TMDS_shift_green <= TMDS_shift_load ? TMDS_green : TMDS_shift_green[9:2];
		TMDS_shift_blue  <= TMDS_shift_load ? TMDS_blue  : TMDS_shift_blue [9:2];	
		TMDS_mod10 <= (TMDS_mod10==4'd4) ? 4'd0 : TMDS_mod10+4'd1;
	end
	end

	ODDR ddr_r(.D1(TMDS_shift_red[0]),.D2(TMDS_shift_red[1]),.C(clk_high),.Q(TMDS_r),.CE(1'b1),.R(1'b0));
	ODDR ddr_g(.D1(TMDS_shift_green[0]),.D2(TMDS_shift_green[1]),.C(clk_high),.Q(TMDS_g),.CE(1'b1),.R(1'b0));
	ODDR ddr_b(.D1(TMDS_shift_blue[0]),.D2(TMDS_shift_blue[1]),.C(clk_high),.Q(TMDS_b),.CE(1'b1),.R(1'b0));
	

	assign TMDSd[2]=TMDS_r;
	assign TMDSd[1]=TMDS_g;
	assign TMDSd[0]=TMDS_b;
	assign TMDSd[3]=clk_low;

	
	TMDS_Encoder encoder0 (.clklow(clk_low),.reset(reset),.state(DrawArea),.pix_data(blue),.H_VSync_Ctr({vSync,hSync}),.q_out(TMDS_blue));
	TMDS_Encoder encoder1 (.clklow(clk_low),.reset(reset),.state(DrawArea),.pix_data(green),.H_VSync_Ctr(2'b0),.q_out(TMDS_green));
	TMDS_Encoder encoder2 (.clklow(clk_low),.reset(reset),.state(DrawArea),.pix_data(red),.H_VSync_Ctr(2'b0),.q_out(TMDS_red));	
		
endmodule
*/

module HDMI_Transciever
		#(parameter
		h_pixel=640,				  
		h_front_porch=16,		
		h_back_porch=48,		
		h_tot_pixel=800,				  
		v_pixel=480,				  
		v_front_porch=10,		
		v_back_porch=33,		
		v_tot_pixel=525)
		(input clk_low,input clk_high,/*,input reset,*/input[7:0] red,input[7:0] green,input[7:0] blue,output[25:0] cntX,output[25:0]cntY,
						output[3:0] TMDSd);
	////////////////////////////////////////////////////////////////////////
		
	////////////////////////////////////////////////////////////////////////
		reg [9:0] CounterX, CounterY;
		reg hSync, vSync;
		reg[25:0] adress;
		reg[1:0]  DrawArea;
		always @(posedge clk_low) adress<=(CounterY==v_tot_pixel-1) ? 0 : adress+1;	
		
		assign cntX=CounterX;
		assign cntY=CounterY;
		
		always @(posedge clk_low) DrawArea <= (CounterX<h_pixel) && (CounterY<v_pixel);
		always @(posedge clk_low) CounterX <= (CounterX==h_tot_pixel-1) ? 0 : CounterX+1;
		always @(posedge clk_low)begin 
			vSync <= ((CounterY>=v_pixel+v_front_porch) && (CounterY<v_tot_pixel-v_back_porch)&&(CounterX<h_tot_pixel-2))||((CounterY==v_pixel+v_front_porch-1)&& (CounterX>=h_tot_pixel-2));
			if(CounterX==h_tot_pixel-1)begin			
				CounterY <= (CounterY==v_tot_pixel-1) ? 0 : CounterY+1;			
			end				
		end
		always @(posedge clk_low) hSync <= (CounterX>=h_pixel+h_front_porch) && (CounterX<h_tot_pixel-h_back_porch);		
		////////////////////////////////////////////////////////////////////////
		wire [9:0] TMDS_red, TMDS_green, TMDS_blue;	
		////////////////////////////////////////////////////////////////////////
		reg [3:0] TMDS_mod10=0;  // modulus 10 counter
		reg [9:0] TMDS_shift_red=0, TMDS_shift_green=0, TMDS_shift_blue=0;
		reg TMDS_shift_load=0;
		always @(posedge clk_high) TMDS_shift_load <= (TMDS_mod10==4'd9);
		always @(posedge clk_high)
		begin
			TMDS_shift_red   <= TMDS_shift_load ? TMDS_red   : TMDS_shift_red  [9:1];
			TMDS_shift_green <= TMDS_shift_load ? TMDS_green : TMDS_shift_green[9:1];
			TMDS_shift_blue  <= TMDS_shift_load ? TMDS_blue  : TMDS_shift_blue [9:1];	
			TMDS_mod10 <= (TMDS_mod10==4'd9) ? 4'd0 : TMDS_mod10+4'd1;
		end

		assign TMDSd[2]=TMDS_shift_red[0];
		assign TMDSd[1]=TMDS_shift_green[0];
		assign TMDSd[0]=TMDS_shift_blue [0];
		assign TMDSd[3]=clk_low;
		
	
		//TMDS_Encoder encoder0 (.clklow(clk_low),.clkhigh(clk_high),.reset(reset),.state(DrawArea),.pix_data(blue),.H_VSync_Ctr({vSync,hSync}),.q_out(TMDS_blue));
		//TMDS_Encoder encoder1 (.clklow(clk_low),.clkhigh(clk_high),.reset(reset),.state(DrawArea),.pix_data(green),.H_VSync_Ctr(2'b0),.q_out(TMDS_green));
		//TMDS_Encoder encoder2 (.clklow(clk_low),.clkhigh(clk_high),.reset(reset),.state(DrawArea),.pix_data(red),.H_VSync_Ctr(2'b0),.q_out(TMDS_red));	

		TMDS_Encoder encoder0 (.clklow(clk_low),.reset(reset),.state(DrawArea),.pix_data(blue),.H_VSync_Ctr({vSync,hSync}),.q_out(TMDS_blue));
		TMDS_Encoder encoder1 (.clklow(clk_low),.reset(reset),.state(DrawArea),.pix_data(green),.H_VSync_Ctr(2'b0),.q_out(TMDS_green));
		TMDS_Encoder encoder2 (.clklow(clk_low),.reset(reset),.state(DrawArea),.pix_data(red),.H_VSync_Ctr(2'b0),.q_out(TMDS_red));	
		
endmodule
