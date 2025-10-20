module top (
    input clk,
    input rst,
    input [7:0] A,
    input [7:0] B,
    output reg [7:0] S,
    output reg  Cout
);

reg [7:0] A_reg;
reg [7:0] B_reg;
wire [7:0] S_wire;
wire Cout_wire;

adder_8bit uut (
    .A(A_reg),
    .B(B_reg),
    .Cin(1'b0),
    .S(S_wire),
    .Cout(Cout_wire)
);

// Use an event-based asynchronous reset (active-high) together with
// synchronous updates on the rising edge of clk.
always @(posedge clk or posedge rst) begin
    if (rst) begin
        A_reg <= 8'b0;
        B_reg <= 8'b0;
        S <= 8'b0;
        Cout <= 1'b0;
    end else begin
        A_reg <= A;
        B_reg <= B;
        S <= S_wire;
        Cout <= Cout_wire;
    end
end

endmodule
