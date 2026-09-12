module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);

    wire dff_in;
    wire dff_out;

    always @(*)begin
        Q = dff_out;
    end

    mux2to1 mux1 (
        .a(r_in),
        .b(q_in),
        .sel(L),
        .out(dff_in)
    );

    dff dff1 (
        .clk(clk),
        .d(dff_in),
        .q(dff_out)
    );

endmodule

module mux2to1 (
    input a,
    input b,
    input sel,
    output out);

    assign out = sel ? a : b;
endmodule

module dff (
    input clk,
    input d, 
    output reg q);

    always @(posedge clk) begin
        q <= d;
    end
endmodule