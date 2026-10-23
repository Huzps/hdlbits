/* Fsm1s

This is a Moore state machine with two states, one input, and one output. Implement this state machine. Notice that the reset state is B.

This exercise is the same as fsm1, but using synchronous reset.

Fig not provided

*/
// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

    // Fill in state name declarations

    reg present_state, next_state;

    localparam A = 1'b0, B = 1'b1; 

    always @(*) begin
        case (present_state)
                // Fill in state transition logic
                A: begin
                    next_state = in ? A : B; 
                    out = 1'b0;
                end
                B: begin
                    next_state = in ? B : A; 
                    out = 1'b1;
                end 
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin  
            // Fill in reset logic
            present_state <= B;
        end else begin
            // State flip-flops
            present_state <= next_state;   
        end
    end

endmodule