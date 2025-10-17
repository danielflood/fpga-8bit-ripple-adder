module adder_1bit(
    input A,
    input B,
    input Cin,
    output reg S,
    output reg Cout
); 

wire p = A ^ B;

always @ (*) 
begin
    S = p ^ Cin;
    Cout = (A & B) | (Cin & p);
end 

endmodule