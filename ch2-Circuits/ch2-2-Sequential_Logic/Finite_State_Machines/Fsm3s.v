/* Fsm3s

See also: State transition logic for this FSM

The following is the state transition table for a Moore state machine with one input, one output, and four states. Implement this state machine. Include a synchronous reset that resets the FSM to state A. (This is the same problem as Fsm3 but with a synchronous reset.)

State	Next state	    Output
        in=0	in=1
A	    A	    B	    0
B	    C	    B	    0
C	    A	    D	    0
D	    C	    B	    1

*/

module top_module(
    input clk,
    input in,
    input reset,
    output out); //

    reg [1:0] state, next_state;
    parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end

    // Output logic
    assign out = (state == D);

endmodule