/* Conwaylife

Conway's Game of Life is a two-dimensional cellular automaton.

The "game" is played on a two-dimensional grid of cells, where each cell is either 1 (alive) or 0 (dead). At each time step, each cell changes state depending on how many neighbours it has:

0-1 neighbour: Cell becomes 0.
2 neighbours: Cell state does not change.
3 neighbours: Cell becomes 1.
4+ neighbours: Cell becomes 0.
The game is formulated for an infinite grid. In this circuit, we will use a 16x16 grid. To make things more interesting, we will use a 16x16 toroid, where the sides wrap around to the other side of the grid. For example, the corner cell (0,0) has 8 neighbours: (15,1), (15,0), (15,15), (0,1), (0,15), (1,1), (1,0), and (1,15). The 16x16 grid is represented by a length 256 vector, where each row of 16 cells is represented by a sub-vector: q[15:0] is row 0, q[31:16] is row 1, etc. (This tool accepts SystemVerilog, so you may use 2D vectors if you wish.)

load: Loads data into q at the next clock edge, for loading initial state.
q: The 16x16 current state of the game, updated every clock cycle.
The game state should advance by one timestep every clock cycle.

John Conway, mathematician and creator of the Game of Life cellular automaton, passed away from COVID-19 on April 11, 2020.

*/

module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 

    wire [255:0] q_load;

    always @(posedge clk) begin
        if(load) begin
            q <= data;
        end
        else begin
            q <= q_load;
        end
    end

    generate
        genvar i,j; // i - rows, j - columns
        for (i = 0; i < 16 ; i = i + 1 ) begin: row_inst
            for (j = 0; j < 16 ; j = j + 1 ) begin: col_inst
                wire [7:0] cell_neighbour;
                assign cell_neighbour = {
                    q[(i == 0 ? 15 : i-1) * 16 + (j == 0 ? 15 : j-1)],
                    q[(i == 0 ? 15 : i-1) * 16 +                   j],
                    q[(i == 0 ? 15 : i-1) * 16 + (j == 15 ? 0 : j+1)],
                    q[                  i * 16 + (j == 0 ? 15 : j-1)],
                    q[                  i * 16 + (j == 15 ? 0 : j+1)],
                    q[(i == 15 ? 0 : i+1) * 16 + (j == 0 ? 15 : j-1)],
                    q[(i == 15 ? 0 : i+1) * 16 +                   j],
                    q[(i == 15 ? 0 : i+1) * 16 + (j == 15 ? 0 : j+1)]
                };
                conway_cell conway_cell_i(
                    .center      (q[i * 16 + j]     ),
                    .neighbour   (cell_neighbour    ),
                    .center_q    (q_load[i * 16 + j])
                );
            end
        end
    endgenerate

endmodule

module conway_cell(
    input center,
    input [7:0] neighbour,
    output center_q
);
    /* 
        // Calculate using SystemVerilog functions
        wire [3:0] count;
        assign count = $countones(data); 
        assign center_q = (count == 4'd3) ? 1'b1 :
                          (count == 4'd2) ? center : 1'b0;
    */

    reg [3:0] count;
    integer  i;

    always_comb begin
        count = 4'd0;
        for (i = 0; i < 8; i = i + 1) begin
            count = count + neighbour[i];
        end
    end

    assign center_q = (count == 4'd3) ? 1'b1 :
                      (count == 4'd2) ? center : 1'b0;

endmodule