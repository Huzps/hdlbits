module top_module ( input a, input b, output out );

    mod_a mod_a_inst(a, b, out);
endmodule

module mod_a (
    input      in1,
    input      in2,
    output     out
);
    assign out = in1 ^ in2 & in1 | in2;
endmodule