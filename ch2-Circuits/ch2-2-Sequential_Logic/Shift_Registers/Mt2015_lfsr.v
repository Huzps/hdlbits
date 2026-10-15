/* Mt2015 lfsr

Taken from 2015 midterm question 5. See also the first part of this question: mt2015_muxdff

Write the Verilog code for this sequential circuit (Submodules are ok, but the top-level must be named top_module). Assume that you are going to implement the circuit on the DE1-SoC board. Connect the R inputs to the SW switches, connect Clock to KEY[0], and L to KEY[1]. Connect the Q outputs to the red lights LEDR.

*/ 

module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q

	wire [2:0] dff_in, dff_out;

	assign LEDR = dff_out;

	dff_u dff_i0(
		.d(dff_in[0]),
		.clk(KEY[0]),
		.q(dff_out[0])
	);

	dff_u dff_i1(
		.d(dff_in[1]),
		.clk(KEY[0]),
		.q(dff_out[1])
	);

	dff_u dff_i2(
		.d(dff_in[2]),
		.clk(KEY[0]),
		.q(dff_out[2])
	);

	mux2to1_u mux2to1_i0(
		.a(SW[0]),
		.b(dff_out[2]),
		.s(KEY[1]),
		.o(dff_in[0])
	);

	mux2to1_u mux2to1_i1(
		.a(SW[1]),
		.b(dff_out[0]),
		.s(KEY[1]),
		.o(dff_in[1])
	);

	mux2to1_u mux2to1_i2(
		.a(SW[2]),
		.b(dff_out[1] ^ dff_out[2]),
		.s(KEY[1]),
		.o(dff_in[2])
	);


endmodule

module dff_u(
	input d,
	input clk,
	output reg q
);

	always @(posedge clk) begin
		q <= d;
	end

endmodule

module mux2to1_u (
	input a, b, s,
	output o
);
	assign o = s ? a : b;
endmodule