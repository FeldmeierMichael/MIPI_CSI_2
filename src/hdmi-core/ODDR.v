module ODDR(input D1,D2,C,CE,R, output reg Q);
    always @(posedge C or negedge C) begin
        Q<=C?D1:D2;
    end
endmodule