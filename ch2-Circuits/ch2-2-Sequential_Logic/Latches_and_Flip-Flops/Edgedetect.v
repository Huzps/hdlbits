module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : edge_detect_gen
            edge_detect ed (
                .clk(clk),
                .in(in[i]),
                .pedge(pedge[i])
            );
        end
    endgenerate


    /*

    Alternative implementation without using generate block:

        reg [7:0] in_d1;
        always @(posedge clk) begin
            in_d1 <= in;
            pedge <= in & ~in_d1;
        end

    */

endmodule

module edge_detect (
    input clk,
    input in,
    output pedge
);

    reg in_d1;

    always @(posedge clk) begin
        in_d1 <= in;
        pedge <= in & ~in_d1;
    end

endmodule