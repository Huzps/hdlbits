module top_module (
    input clk,
    input in, 
    output out);

    wire dff_in;
    wire dff_out;

    assign dff_in = in ^ dff_out;
    assign out = dff_out;

    dff dff1 (
        .clk(clk),
        .d(dff_in),
        .q(dff_out)
    );

endmodule


module dff (
    input clk,
    input d, 
    output q);

    always @(posedge clk) begin
        q <= d;
    end

endmodule