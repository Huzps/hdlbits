/*
Exams/2014_q4b

Consider the n-bit shift register circuit shown below:

(Fig Not Provided)

Write a top-level Verilog module (named top_module) for the shift register, assuming that n = 4. Instantiate four copies of your MUXDFF subcircuit in your top-level module. Assume that you are going to implement the circuit on the DE2 board.

 - Connect the R inputs to the SW switches,
 - clk to KEY[0],
 - E to KEY[1],
 - L to KEY[2], and
 - w to KEY[3].
 - Connect the outputs to the red lights LEDR[3:0].

 (Reuse your MUXDFF from exams/2014_q4a.)
*/

module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
    localparam N = 4;

    wire [3:0] muxdff_r, muxdff_q, muxdff_w;
    assign muxdff_r = SW;
    assign LEDR = muxdff_q;
    assign muxdff_w = {KEY[3], muxdff_q[3:1]};

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin: muxdff_gen
            muxdff muxdff_i(
                .clk(KEY[0]),
                .w(muxdff_w[i]),
                .R(muxdff_r[i]),
                .E(KEY[1]),
                .L(KEY[2]),
                .Q(muxdff_q[i])
            );
        end
    endgenerate

endmodule

module muxdff (
    input clk,
    input w, R, E, L,
    output Q
);
    wire mux1_out, mux2_out;
    
    mux2to1 mux1 (
        .a(w),
        .b(Q),
        .sel(E),
        .out(mux1_out)
    );

    mux2to1 mux2 (
        .a(R),
        .b(mux1_out),
        .sel(L),
        .out(mux2_out)
    );

    dff_u dff (
        .clk(clk),
        .d(mux2_out),
        .q(Q)
    );

endmodule

module mux2to1 (
    input a,
    input b,
    input sel,
    output out);

    assign out = sel ? a : b;
endmodule

module dff_u (
    input clk,
    input d, 
    output reg q);

    always @(posedge clk) begin
        q <= d;
    end
endmodule