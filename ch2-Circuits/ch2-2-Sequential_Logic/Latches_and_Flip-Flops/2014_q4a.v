module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    wire mux1_out, mux2_out;
    
    mux2to1 mux1 (
        .a(w),
        .b(Q),
        .sel(E),
        .out(mux1_out)
    );

    mux2to1 mux2 (
        .a(R),
        .b(mux1_out),
        .sel(L),
        .out(mux2_out)
    );

    dff_u dff (
        .clk(clk),
        .d(mux2_out),
        .q(Q)
    );

endmodule

module mux2to1 (
    input a,
    input b,
    input sel,
    output out);

    assign out = sel ? a : b;
endmodule

module dff_u (
    input clk,
    input d, 
    output reg q);

    always @(posedge clk) begin
        q <= d;
    end
endmodule