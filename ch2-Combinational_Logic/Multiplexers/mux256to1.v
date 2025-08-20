module top_module( 
    input [255:0] in,
    input [7:0] sel,
    output  out );
    // output reg out
    // integer i;
    // always @(*) begin
    //     out = 1'b0;
    //     for(i = 0; i < 256; i = i + 1)
    //     begin
    //         if(sel == i)
    //         begin
    //             out = in[sel]; 
    //         end
    //     end
    // end
    assign out = in[sel];
endmodule
