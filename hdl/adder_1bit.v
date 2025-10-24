`timescale 1ns / 1ps

module adder_1bit(
    input A,
    input B,
    input Cin,
    output S,
    output Cout
); 

wire p = A ^ B;

assign S = p ^ Cin;
assign Cout = (A & B) | (Cin & p);
endmodule