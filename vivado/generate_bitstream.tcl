# ----- project -----
set proj build
create_project $proj ./vivado/$proj -part xc7z020clg400-1 -force
# If you have Digilent board files, uncomment:
# set_property board_part {digilentinc.com:arty-z7-20:part0:1.1} [current_project]

# ----- BD -----
create_bd_design sys
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 ps7
# Apply presets / enable GP0 & FCLK0
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config { make_external "FIXED_IO,DDR" } [get_bd_cells ps7]

create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio
set_property -dict [list CONFIG.C_IS_DUAL {1} CONFIG.C_GPIO_WIDTH {16} CONFIG.C_ALL_INPUTS {0} \
                         CONFIG.C_GPIO2_WIDTH {9} ] [get_bd_cells gpio]

apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/ps7/M_AXI_GP0" Clk "/ps7/FCLK_CLK0"} [get_bd_intf_pins gpio/S_AXI]

make_bd_pins_external [get_bd_pins gpio/gpio_io_o]
make_bd_pins_external [get_bd_pins gpio/gpio2_io_i]

# Enable PS UART1 (Arty Z7 USB-UART is on UART1 MIO 48/49)
set ps7 [get_bd_cells ps7]
set_property -dict [list \
  CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
  CONFIG.PCW_UART1_UART1_IO {MIO 48 .. 49} \
] $ps7

# Validate & save
validate_bd_design
save_bd_design


# Generate + add wrapper in one step (no add_files needed)
make_wrapper -files [get_files -quiet */sys/sys.bd] -top -import

# Use existing RTL in hdl/ rather than generating ad-hoc modules in the script
# Add the project's RTL sources (top and adders) from the hdl/ directory
add_files ./hdl/adder_1bit.v
add_files ./hdl/adder_8bit.v
add_files ./hdl/top.v

# Ensure the top module is set to the module declared in hdl/top.v
set_property top top [current_fileset]

# ----- bitstream -----
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1

# ----- export hardware (.xsa with bitstream) -----
write_hw_platform -fixed -include_bit -force -file ./export/adder_8bit.xsa
