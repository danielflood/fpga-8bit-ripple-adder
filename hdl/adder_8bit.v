`timescale 1ns / 1ps

module adder_8bit (
    input [7:0] A,
    input [7:0] B,
    input Cin,
    output [7:0] S,
    output Cout
);

wire [6:0] carry;
adder_1bit adder0 (
    .A(A[0]),
    .B(B[0]),
    .Cin(Cin),
    .S(S[0]),
    .Cout(carry[0])
);
adder_1bit adder1 (
    .A(A[1]),
    .B(B[1]),
    .Cin(carry[0]),
    .S(S[1]),
    .Cout(carry[1])
);
adder_1bit adder2 (
    .A(A[2]),
    .B(B[2]),
    .Cin(carry[1]),
    .S(S[2]),
    .Cout(carry[2])
);
adder_1bit adder3 (
    .A(A[3]),
    .B(B[3]),
    .Cin(carry[2]),
    .S(S[3]),
    .Cout(carry[3])
);
adder_1bit adder4 (
    .A(A[4]),
    .B(B[4]),
    .Cin(carry[3]),
    .S(S[4]),
    .Cout(carry[4])
);
adder_1bit adder5 (
    .A(A[5]),
    .B(B[5]),
    .Cin(carry[4]),
    .S(S[5]),
    .Cout(carry[5])
);
adder_1bit adder6 (
    .A(A[6]),
    .B(B[6]),
    .Cin(carry[5]),
    .S(S[6]),
    .Cout(carry[6])
);
adder_1bit adder7 (
    .A(A[7]),
    .B(B[7]),
    .Cin(carry[6]),
    .S(S[7]),
    .Cout(Cout)
);
endmodule