module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );

    wire p2ab_and = p2a & p2b;
    wire p2cd_and = p2c & p2d;
    assign p2y = p2ab_and | p2cd_and;

    wire p1abc_and = p1a & p1b & p1c;
    wire p1def_and = p1d & p1e & p1f;
    assign p1y = p1abc_and | p1def_and;

endmodule