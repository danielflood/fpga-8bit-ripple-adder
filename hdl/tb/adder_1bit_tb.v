`timescale 1ns / 1ps

module adder_1bit_tb;

// 1. Declare inputs as regs
reg A;
reg B;
reg Cin;

// 2. Declare outputs as wires
wire S;
wire Cout;

// 3. Instantiate the module under test (UUT)
adder_1bit uut (
    .A(A),
    .B(B),
    .Cin(Cin),
    .S(S),
    .Cout(Cout)
);

// 4. Apply test patterns
initial begin
    $dumpfile("waves/waves_1bit.vcd");   // waveform output file
    $dumpvars(0, adder_1bit_tb);
    $display("Cin A  B  | S Cout");
    $monitor("%b   %b  %b  | %b  %b", Cin, A, B, S, Cout);

    // try all combinations
    Cin = 0; B = 0; A = 0; #10;
    Cin = 0; B = 0; A = 1; #10;
    Cin = 0; B = 1; A = 0; #10;
    Cin = 0; B = 1; A = 1; #10;
    Cin = 1; B = 0; A = 0; #10;
    Cin = 1; B = 0; A = 1; #10;
    Cin = 1; B = 1; A = 0; #10;
    Cin = 1; B = 1; A = 1; #10;

    $finish;
end

endmodule