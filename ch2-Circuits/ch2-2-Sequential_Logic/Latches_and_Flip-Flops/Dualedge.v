module top_module (
    input clk,
    input d,
    output q
); 
    // Use MUX

    reg p_posedge, p_negedge;

    always @(posedge clk) begin
        p_posedge <= d;
    end

    always @(negedge clk) begin
        p_negedge <= d;
    end

    assign q = clk ? p_posedge : p_negedge;

endmodule


/* another solution
    USE XOR gates to combine the two registers into a single output. The output will be high if either register is high, and low if both registers are low. This will ensure that the output changes state on both the rising and falling edges of the clock signal.
    
    module top_module(
    input clk,
    input d,
    output q
);

    reg p, n;

    always @(posedge clk)
        p <= d ^ n;

    always @(negedge clk)
        n <= d ^ p;

    assign q = p ^ n;

endmodule
*/