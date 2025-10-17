# 1-Bit Adder (Verilog) — Simulation with Icarus Verilog

This project implements a simple 1-bit full adder in Verilog and tests it using **Icarus Verilog** and **GTKWave**.  
I'm using it to learn how to structure HDL projects cleanly with a separate simulation directory and Makefile.


## 🧩 Project structure
```bash
fp32-calculator-fpga/
├── hdl/
│   ├── adder_1bit.v # 1-bit full adder module
│   └── tb/
│       └── adder_1bit_tb.v # testbench
└── sim/
    ├── Makefile # build/run automation
    └── waves.vcd # generated waveform (after simulation)
```

## ⚙️ Requirements

Install the following tools (Linux / macOS / WSL):

```bash
sudo apt install iverilog gtkwave make
```

## ▶️ Running the simulation
Navigate to the simulation folder:

```bash
cd sim
```
Run the Makefile:

```bash
make
```
This will:
- Compile the design with iverilog
- Execute the simulation with vvp
- Print results to the terminal

Example output:
```bash
A B Cin | C Cout
0 0 0   | 0 0
0 1 1   | 0 1
1 1 1   | 1 1
```

View waveforms (optional):
```bash
make view
```
or open manually:

```bash
gtkwave waves.vcd
```
Clean generated files:

```bash
make clean
```
## 🧠 Notes
- iverilog compiles Verilog source into a simulation executable (sim.out).
- vvp runs the simulation and produces a waveform file (waves.vcd).
- gtkwave lets you visualize signal transitions over time.
- The Makefile uses := for immediate variable expansion to keep paths stable.

## 🏗️ Next steps
This basic module will later be extended into a multi-bit ripple-carry adder implemented in Verilog and integrated with Vivado and Vitis on a Zynq platform.
