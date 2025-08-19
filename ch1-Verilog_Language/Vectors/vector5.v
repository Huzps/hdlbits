module top_module (
    input a, b, c, d, e,
    output [24:0] out );//

    // The output is XNOR of two vectors created by 
    // concatenating and replicating the five inputs.
    // assign out = ~{ ... } ^ { ... };
    wire [4:0] i = {a, b, c, d, e};
    wire [4:0] a5 = ~{5{a}} ^ i;
    wire [4:0] b5 = ~{5{b}} ^ i;
    wire [4:0] c5 = ~{5{c}} ^ i;
    wire [4:0] d5 = ~{5{d}} ^ i;
    wire [4:0] e5 = ~{5{e}} ^ i;
    assign out = {a5, b5, c5, d5, e5};

endmodule
