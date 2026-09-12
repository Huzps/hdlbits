module top_module (
    input clk,
    input w, R, E, L,
    output Q
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