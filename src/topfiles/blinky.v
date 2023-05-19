`default_nettype none   //do not allow undeclared wires

module blinky (
    input  wire sys_clk,
    output wire[2:0] led
    );

    reg [24:0] r_count = 0;

    always @(posedge(sys_clk)) r_count <= r_count + 1;

    assign led[0] = r_count[24];
    assign led[1] = r_count[23];
    assign led[2] = r_count[22];   

endmodule
