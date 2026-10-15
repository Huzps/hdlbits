/* Lfsr5

A linear feedback shift register is a shift register usually with a few XOR gates to produce the next state of the shift register. A Galois LFSR is one particular arrangement where bit positions with a "tap" are XORed with the output bit to produce its next value, while bit positions without a tap shift. If the taps positions are carefully chosen, the LFSR can be made to be "maximum-length". A maximum-length LFSR of n bits cycles through 2n-1 states before repeating (the all-zero state is never reached).

The following diagram shows a 5-bit maximal-length Galois LFSR with taps at bit positions 5 and 3. (Tap positions are usually numbered starting from 1). Note that I drew the XOR gate at position 5 for consistency, but one of the XOR gate inputs is 0.

Diagram is not provided here.

Build this LFSR. The reset should reset the LFSR to 1.
*/

module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 5'h1
    output [4:0] q
); 

    wire [4:0] din;

    assign din = {{q[0] ^ 1'b0}, q[4], {q[3] ^ q[0]}, q[2:1]};

    dff_u dff_i0(
        .clk(clk),
        .rst(reset),
        .d(din[0]),
        .rst_val(1'b1),
        .q(q[0])
    );

    dff_u dff_i1(
        .clk(clk),
        .rst(reset),
        .d(din[1]), 
        .rst_val(1'b0),
        .q(q[1])
    );

    dff_u dff_i2(
        .clk(clk),
        .rst(reset),
        .d(din[2]),
        .rst_val(1'b0),
        .q(q[2])
    );

    dff_u dff_i3(
        .clk(clk),
        .rst(reset),
        .d(din[3]),
        .rst_val(1'b0),
        .q(q[3])
    );

    dff_u dff_i4(
        .clk(clk),
        .rst(reset),
        .d(din[4]),
        .rst_val(1'b0),
        .q(q[4])
    );

endmodule

module dff_u(
    input clk,
    input d,
    input rst,
    input rst_val,
    output reg q
);

    always @(posedge clk) begin
        if (rst) begin
            q <= rst_val;
        end
        else begin
            q <= d;
        end
    end

endmodule