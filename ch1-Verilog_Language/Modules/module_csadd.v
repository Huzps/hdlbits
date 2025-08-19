module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
wire cout;
wire [15:0] sum_i1, sum_i2;
add16 add1(a[15:0], b[15:0], 1'b0, sum[15:0], cout);
add16 add2(a[31:16], b[31:16], 1'b0, sum_i1, );
add16 add3(a[31:16], b[31:16], 1'b1, sum_i2, );
assign sum[31:16] = cout? sum_i2 : sum_i1;

endmodule
