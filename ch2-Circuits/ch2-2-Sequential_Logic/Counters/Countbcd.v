/*
Countbcd

Build a 4-digit BCD (binary-coded decimal) counter. Each decimal digit is encoded using 4 bits: q[3:0] is the ones digit, q[7:4] is the tens digit, etc. For digits [3:1], also output an enable signal indicating when each of the upper three digits should be incremented.

You may want to instantiate or modify some one-digit decade counters.
*/

module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    assign ena[1] = (q[3:0] == 4'h9);
    assign ena[2] = ena[1] & (q[7:4] == 4'h9);
    assign ena[3] = ena[2] & (q[11:8] == 4'h9);

    countbcd counter0
    (
        .clk(clk),
        .reset(reset),
        .ena(1'b1),
        .q(q[3:0])
    );

    countbcd counter1
    (
        .clk(clk),
        .reset(reset),
        .ena(ena[1]),
        .q(q[7:4])
    );

    countbcd counter2
    (
        .clk(clk),
        .reset(reset),
        .ena(ena[2]),
        .q(q[11:8])
    );

    countbcd counter3
    (
        .clk(clk),
        .reset(reset),
        .ena(ena[3]),
        .q(q[15:12])
    );

endmodule

module countbcd(
    input clk,
    input reset,   // Synchronous active-high reset
    input ena,
    output [3:0] q
);

    always @(posedge clk) begin
        if (reset)
            q <= 4'b0000;
        else if (ena)  begin
            if (q == 4'h9)
                q <= 4'b0000;
            else
                q <= q + 1'b1;
        end
    end

endmodule