module top_module ( // latch
    input d, 
    input ena,
    output q); 

    always @(*) begin
        if (ena) begin
            q <= d;
        end
    end

endmodule
