/*
Count clock

Create a set of counters suitable for use as a 12-hour clock (with am/pm indicator). Your counters are clocked by a fast-running clk, with a pulse on ena whenever your clock should increment (i.e., once per second).

reset resets the clock to 12:00 AM. pm is 0 for AM and 1 for PM. hh, mm, and ss are two BCD (Binary-Coded Decimal) digits each for hours (01-12), minutes (00-59), and seconds (00-59). Reset has higher priority than enable, and can occur even when not enabled.

The following timing diagram shows the rollover behaviour from 11:59:59 AM to 12:00:00 PM and the synchronous reset and enable behaviour.

Diagram Missing Here.
*/

module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

    wire [1:0] ena_ss, ena_mm;
    wire ena_hh;
    wire [1:0] rst_ss, rst_mm;

    assign rst_ss[0] = reset;
    assign rst_ss[1] = reset | (ena_ss[0] & (ss == 8'h59));
    assign rst_mm[0] = reset;
    assign rst_mm[1] = reset | (ena_mm[0] & (mm == 8'h59));


    assign ena_ss[0] = ena;
    assign ena_ss[1] = ena_ss[0] & (ss[3:0] == 4'h9);
    assign ena_mm[0] = ena_ss[0] & (ss == 8'h59);
    assign ena_mm[1] = ena_mm[0] & (mm[3:0] == 4'h9);
    assign ena_hh = ena_mm[0] & (mm == 8'h59);


    always @(posedge clk) begin
        if (reset)
            pm <= 1'b0;
        else if (ena && ss == 8'h59 && mm == 8'h59 && hh == 8'h11)
            pm <= ~pm;
    end

    countbcd counter_ss0 (
        .clk(clk),
        .reset(rst_ss[0]),
        .ena(ena_ss[0]),
        .q(ss[3:0])
    );

    countbcd counter_ss1 (
        .clk(clk),
        .reset(rst_ss[1]),
        .ena(ena_ss[1]),
        .q(ss[7:4])
    );

    countbcd counter_mm0 (
        .clk(clk),
        .reset(rst_mm[0]),
        .ena(ena_mm[0]),
        .q(mm[3:0])
    );

    countbcd counter_mm1 (
        .clk(clk),
        .reset(rst_mm[1]),
        .ena(ena_mm[1]),
        .q(mm[7:4])
    );

    always @(posedge clk) begin
        if (reset)
            hh <= 8'h12;
        else if (ena_hh) begin
            if (hh == 8'h12)
                hh <= 8'h01;
            else if (hh[3:0] == 4'h9)
                hh <= {hh[7:4] + 1'b1, 4'h0};
            else
                hh <= hh + 1'b1;
        end
    end

endmodule

module countbcd(
    input clk,
    input reset,   // Synchronous active-high reset
    input ena,
    output reg [3:0] q
);

    always @(posedge clk) begin
        if (reset)
            q <= 4'b0000;
        else if (ena)  begin
            if (q == 4'h9)
                q <= 4'b0000;
            else
                q <= q + 1'b1;
        end
    end

endmodule
