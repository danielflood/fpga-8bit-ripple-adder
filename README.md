# 8-Bit Adder (Verilog)

This project implements a simple 8-bit ripple adder in Verilog and tests it using **Icarus Verilog** and **GTKWave**.  
I'm using this project to learn how to structure HDL projects cleanly with a separate simulation directory and Makefile.

## ⚙️ Requirements
- iverilog
- vvp
- gtkwave (optional, for waveform viewing)
- make

## 🧩 Project structure
```bash
fpga-8bit-ripple-adder/
├── hdl/
│   ├── adder_1bit.v
│   ├── adder_8bit.v
│   ├── top.v
│   └── tb/
│       ├── adder_1bit_tb.v
│       ├── adder_8bit_tb.v
│       └── top_tb.v
└── sim/
    ├── Makefile
    ├── build/       # generated simulation binaries & logs
    └── waves/       # generated VCD waveform files
```

## ▶️ Running the simulation
- Run the default (1-bit) test:   
  `make -C sim sim1`  

- Run the exhaustive 8-bit testbench:  
  `make -C sim sim8`

- Run the top level testbench:  
  `make -C sim sim_top`  
  or simply:  
  `make -C sim` (the Makefile's `all` target runs `sim_top`)

- View waveforms (runs the sim target then launches GTKWave):  
  `make -C sim view1` # 1-bit waves  
  `make -C sim view8` # 8-bit waves  
  `make -C sim view_top` # top level waves

- Clean generated files:  
  `make -C sim clean`

## Create vivado project
```bash
vivado -mode batch -source ./vivado/build.tcl 
```

## 🧠 Notes
- **iverilog** compiles Verilog source into a simulation executable (e.g. sim1.vvp).
- **vvp** runs the simulation and produces a waveform file (e.g. waves.vcd).
- **gtkwave** lets you visualize signal transitions over time.
