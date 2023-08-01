
	
	module psram
		#(
		parameter
		x8_x16=8'd16,				  
		latency=8'd7
		)
		(
		input ram_clk,			
		input reset,
		input[15:0] data_in,
		output[15:0] data_out,
		input[31:0] addr_in,
		input[1:0] cntr, //2'd0=Sync Read, 2'd1=Sync Write, 2'd2=Linear Burst Read, 2'd3=Linear Burst Write,
		//to RAM
		inout[15:0] ADQ,
		inout[1:0] DQM,
		output CE,CLK
		);

		


		
	 	
	
	
endmodule