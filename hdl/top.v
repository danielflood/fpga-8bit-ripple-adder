`timescale 1ns / 1ps

module top(
   inout  [14:0] DDR_addr,
   inout  [2:0]  DDR_ba,
   inout         DDR_cas_n,
   inout         DDR_ck_n,
   inout         DDR_ck_p,
   inout         DDR_cke,
   inout         DDR_cs_n,
   inout  [3:0]  DDR_dm,
   inout  [31:0] DDR_dq,
   inout  [3:0]  DDR_dqs_n,
   inout  [3:0]  DDR_dqs_p,
   inout         DDR_odt,
   inout         DDR_ras_n,
   inout         DDR_reset_n,
   inout         DDR_we_n,
   inout         FIXED_IO_ddr_vrn,
   inout         FIXED_IO_ddr_vrp,
   inout  [53:0] FIXED_IO_mio,
   inout         FIXED_IO_ps_clk,
   inout         FIXED_IO_ps_porb,
   inout         FIXED_IO_ps_srstb
);

   // Top-level wires to/from system wrapper
   wire [15:0] gpio_io_o;
   wire  [8:0] gpio2_io_i;

   // Instantiate system wrapper with explicit port connections
   // (Vivado synthesis does not accept the SystemVerilog '.*' implicit port map)
   processing_system_wrapper u_sys(
      .DDR_addr(DDR_addr),
      .DDR_ba(DDR_ba),
      .DDR_cas_n(DDR_cas_n),
      .DDR_ck_n(DDR_ck_n),
      .DDR_ck_p(DDR_ck_p),
      .DDR_cke(DDR_cke),
      .DDR_cs_n(DDR_cs_n),
      .DDR_dm(DDR_dm),
      .DDR_dq(DDR_dq),
      .DDR_dqs_n(DDR_dqs_n),
      .DDR_dqs_p(DDR_dqs_p),
      .DDR_odt(DDR_odt),
      .DDR_ras_n(DDR_ras_n),
      .DDR_reset_n(DDR_reset_n),
      .DDR_we_n(DDR_we_n),
      .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
      .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
      .FIXED_IO_mio(FIXED_IO_mio),
      .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
      .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
      .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
      .GPIO2_0_tri_i(gpio2_io_i),
      .GPIO_0_tri_o(gpio_io_o)
   );

   // Split gpio into two 8-bit operands
   wire [7:0] a = gpio_io_o[7:0];
   wire [7:0] b = gpio_io_o[15:8];

   // Adder outputs
   wire [7:0] sum;
   wire       carry;

   adder_8bit u_add8(
      .A(a),
      .B(b),
      .Cin(1'b0),
      .S(sum),
      .Cout(carry)
   );

   // Drive gpio2 with carry + sum
   assign gpio2_io_i = {carry, sum};

endmodule
