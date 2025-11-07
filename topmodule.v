/*
================================================================================
-- Module: cordic_top.v
-- Description: Top-level wrapper for the CORDIC sine-cosine engine.
--              Exposes only clean I/O ports for easy schematic integration.
================================================================================
*/

module cordic_top(
    input        clk,          // System clock
    input        rst_n,        // Active-low reset
    input        start,        // Start signal
    input  [15:0] angle_in,    // Input angle (Q2.14 format)
    output [15:0] x_out,       // Cos(angle_in)
    output [15:0] y_out,       // Sin(angle_in)
    output        done          // Done flag
);

    // Internal wires to connect to the CORDIC core
    wire signed [15:0] x_wire;
    wire signed [15:0] y_wire;
    wire done_wire;

    // Instantiate the main CORDIC core
    cordic #(
        .DATA_WIDTH(16),
        .ITERATIONS(16)
    ) cordic_core (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .angle_in(angle_in),
        .x_out(x_wire),
        .y_out(y_wire),
        .done(done_wire)
    );

    // Drive the outputs
    assign x_out = x_wire;
    assign y_out = y_wire;
    assign done  = done_wire;

endmodule
