module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] in_d1;

    always @(posedge clk) begin
        in_d1 <= in;
        if (reset)
            out <= 32'b0;
        else
            out <= ~in & in_d1 | out;
    end

endmodule
