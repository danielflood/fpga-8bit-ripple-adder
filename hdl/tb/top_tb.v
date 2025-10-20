`timescale 1ns / 1ps

module top_tb;

reg clk = 0;
reg rst;
reg [7:0] A;
reg [7:0] B;
wire [7:0] S;
wire Cout;

// Instantiate DUT
top uut (
    .clk(clk),
    .rst(rst),
    .A(A),
    .B(B),
    .S(S),
    .Cout(Cout)
);

// 10ns clock
always #5 clk = ~clk;

integer i;
reg [8:0] expected;

task apply_and_check(input [7:0] a, input [7:0] b);
begin
    A = a;
    B = b;
    // top registers inputs and outputs are pipelined: new A/B are captured on
    // the first rising edge, and the corresponding sum appears on the next
    // rising edge. So wait two clock edges before checking.
    @(posedge clk); // capture A/B into A_reg/B_reg inside DUT
    @(posedge clk); // S and Cout are updated to reflect the captured values

    expected = a + b; // 9-bit expected result
    if ({Cout, S} !== expected) begin
        $display("ERROR: A=%0d B=%0d => got Cout=%b S=%02x expected=%03x", a, b, Cout, S, expected);
        $finish;
    end else begin
        $display("OK:    A=%0d B=%0d => Cout=%b S=%02x", a, b, Cout, S);
    end
end
endtask

initial begin
    // Put waveform in the sim/waves directory so the Makefile can find it
    $dumpfile("waves/waves_top.vcd");
    $dumpvars(0, top_tb);

    // Reset
    rst = 1;
    A = 0; B = 0;
    repeat (2) @(posedge clk);
    rst = 0;
    @(posedge clk);

    $display("Starting top.v tests...");

    // deterministic edge cases
    apply_and_check(8'd0, 8'd0);
    apply_and_check(8'd1, 8'd0);
    apply_and_check(8'd0, 8'd1);
    apply_and_check(8'd1, 8'd1);
    apply_and_check(8'd127, 8'd1);
    apply_and_check(8'd128, 8'd127);
    apply_and_check(8'd255, 8'd1);
    apply_and_check(8'd255, 8'd255);

    // some random tests
    for (i = 0; i < 50; i = i + 1) begin
        apply_and_check($random & 8'hFF, $random & 8'hFF);
    end

    $display("All top.v tests passed.");
    $finish;
end

endmodule
