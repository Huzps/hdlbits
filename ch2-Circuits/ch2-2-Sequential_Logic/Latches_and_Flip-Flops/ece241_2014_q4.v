module top_module (
    input clk,
    input x,
    output z
); 

    wire dff_in1, dff_in2, dff_in3, dff_out1, dff_out2, dff_out3,
         dff_out1_not, dff_out2_not, dff_out3_not;

    assign z = ~(dff_out1 | dff_out2 | dff_out3);
    assign dff_in1 = x ^ dff_out1;
    assign dff_in2 = x & dff_out2_not;
    assign dff_in3 = x | dff_out3_not;

    dff_u dff1 (
        .clk(clk),
        .d(dff_in1),
        .q(dff_out1),
        .q_not(dff_out1_not)
    );

    dff_u dff2 (
        .clk(clk),
        .d(dff_in2),
        .q(dff_out2),
        .q_not(dff_out2_not)
    );

    dff_u dff3 (
        .clk(clk),
        .d(dff_in3),
        .q(dff_out3),
        .q_not(dff_out3_not)
    );

endmodule

module dff_u (
    input clk,
    input d, 
    output reg q,
    output reg q_not
    );

    initial begin
        q = 1'b0;
        q_not = 1'b1;
    end


    always @(posedge clk) begin
        q <= d;
        q_not <= ~d;
    end
endmodule