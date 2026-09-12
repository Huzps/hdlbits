module top_module (
    input c,
    input d,
    output [3:0] mux_in
); 
    mux2to1 mux0 ( .a(c), .b(d), .sel(c), .out(mux_in[0]) );
    mux2to1 mux1 ( .a(1'b0), .b(1'b0), .sel(1'b1), .out(mux_in[1]) );
    mux2to1 mux2 ( .a(c), .b(d), .sel(d), .out(mux_in[3]) );
    mux2to1 mux3 ( .a(1'b0), .b(1'b1), .sel(d), .out(mux_in[2]) );
endmodule

module mux2to1 (
    input a,
    input b,
    input sel,
    output out
);
    assign out = sel ? a : b;
endmodule