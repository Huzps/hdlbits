/*
Exams/m2014 q4k

Implement the following circuit:

(Figure Not Provided)

*/
module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);

    wire [3:0] dff_in, dff_out;
    assign dff_in = {dff_out[2:0], in};
    assign out = dff_out[3];

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin: dff_gen
            dff_u dff_i(
                .d(dff_in[i]),
                .q(dff_out[i]),
                .clk(clk),
                .rst_n(resetn)
            );
        end
    endgenerate


endmodule

module dff_u(
	input d,
	input clk,
    input rst_n,
	output reg q
);

	always @(posedge clk) begin
        if (~rst_n) begin
            q <= 0;
        end
        else begin
        	q <= d;    
        end
	end

endmodule