/* Exams/ece241 2013 q12

In this question, you will design a circuit for an 8x1 memory, where writing to the memory is accomplished by shifting-in bits, and reading is "random access", as in a typical RAM. You will then use the circuit to realize a 3-input logic function.

First, create an 8-bit shift register with 8 D-type flip-flops. Label the flip-flop outputs from Q[0]...Q[7]. The shift register input should be called S, which feeds the input of Q[0] (MSB is shifted in first). The enable input controls whether to shift. Then, extend the circuit to have 3 additional inputs A,B,C and an output Z. The circuit's behaviour should be as follows: when ABC is 000, Z=Q[0], when ABC is 001, Z=Q[1], and so on. Your circuit should contain ONLY the 8-bit shift register, and multiplexers. (Aside: this circuit is called a 3-input look-up-table (LUT)).

    */

module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 

    localparam NUM_OF_DFFS = 8;
    wire [NUM_OF_DFFS - 1 :0] D, Q;
    assign D = {Q[NUM_OF_DFFS - 2 :0], S};
    wire [2:0] mux_sel = {A, B, C};

    genvar i;
    generate
        for (i = 0; i < NUM_OF_DFFS; i = i + 1) begin: dff_inst
            dff_u dff_i(
                .clk(clk),
                .d(D[i]),
                .enable(enable),
                .q(Q[i])
            );
        end
    endgenerate

    mux8to1 mux_i(
        .sel(mux_sel),
        .mux_in(Q),
        .mux_out(Z)
    );

endmodule

module dff_u (
    input clk,
    input d,
    input enable, 
    output reg q);

    always @(posedge clk) begin
        if (enable)begin
            q <= d; 
        end
        else begin
            q <= q;
        end
    end
endmodule

module mux8to1(
    input [7:0] mux_in,
    input [2:0] sel,
    output mux_out
);
    always @(*) begin
        case (sel)
        3'd0: mux_out = mux_in[0];
        3'd1: mux_out = mux_in[1];
        3'd2: mux_out = mux_in[2];
        3'd3: mux_out = mux_in[3];
        3'd4: mux_out = mux_in[4];
        3'd5: mux_out = mux_in[5];
        3'd6: mux_out = mux_in[6];
        3'd7: mux_out = mux_in[7];
    endcase
    end
    
endmodule