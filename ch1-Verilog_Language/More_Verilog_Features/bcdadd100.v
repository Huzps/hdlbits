module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    genvar i;
    wire [98:0] ci;
    generate
        for(i = 0; i < 100; i = i + 1)
        begin: bcd_add
            if(i == 0)
                begin
                    bcd_fadd adder(a[4*i+3:4*i], b[4*i+3:4*i], cin, ci[i], sum[4*i+3:4*i]);
                end
            else if(i == 99)
                begin
                    bcd_fadd adder(a[4*i+3:4*i], b[4*i+3:4*i], ci[i-1], cout, sum[4*i+3:4*i]);
                end
            else
                begin
                    bcd_fadd adder(a[4*i+3:4*i], b[4*i+3:4*i], ci[i-1], ci[i], sum[4*i+3:4*i]);
                end
        end
    endgenerate

endmodule