`timescale 1ns / 1ps

module adder_8bit_tb;

reg [7:0] A;
reg [7:0] B;
wire [7:0] S;
wire Cout;

integer i, j;

adder_8bit uut (
    .A(A),
    .B(B),
    .Cin(1'b0),
    .S(S),
    .Cout(Cout)
);

initial begin
    $dumpfile("waves/waves_8bit.vcd");
    $dumpvars(0, adder_8bit_tb);

    $display("Running exhaustive 8-bit adder test...");
    for (i = 0; i < 256; i = i + 1) begin
        for (j = 0; j < 256; j = j + 1) begin
            A = i;
            B = j;
            #1; // allow combinational outputs to settle
            // check expected result
            if ({Cout, S} !== (A + B)) begin
                $display("Mismatch: A=%0d B=%0d => got Cout=%b S=%02x expected=%03x", A, B, Cout, S, (A + B));
                $finish;
            end
        end
    end
    $display("All tests passed: 8-bit adder works for all combinations.");
    $finish;
end

endmodule
