module top_module(
        input [99:0] a, b,
        input cin,
        output [99:0] cout,
        output [99:0] sum );
    genvar i;
    generate
        for (i = 0; i < 100; i = i + 1 )
        begin: add
            if(i == 0)
            begin
                adder1 add0(a[i], b[i], cin, cout[i], sum[i]);
            end
            else
            begin
                adder1 addi(a[i], b[i], cout[i - 1], cout[i], sum[i]);
            end
        end
    endgenerate

endmodule

module adder1(
        input a,
        input b,
        input cin,
        output cout,
        output sum
    );
    assign sum = a ^ b ^ cin;
    assign cout = (a & b & cin) | (a & b & ~cin) | (~a & b & cin) | (a & ~b & cin);
endmodule
