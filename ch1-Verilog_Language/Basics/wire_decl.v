`default_nettype none
module top_module(
    input  wire a,
    input  wire b,
    input  wire c,
    input  wire d,
    output wire  out,
    output wire  out_n   ); 

    wire and_ab = a & b;
    wire and_cd = c & d;
    wire and_abcd = and_ab | and_cd;
    assign out = and_abcd;
    assign out_n = ~out;
endmodule