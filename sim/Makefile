# Simple, reproducible simulation Makefile
SIM        ?= iverilog
RUN        ?= vvp
GTKWAVE    ?= gtkwave

SRC_DIR    := ../hdl
BUILD_DIR  := build
WAVES_DIR  := waves

RTL        := $(SRC_DIR)/adder_1bit.v $(SRC_DIR)/adder_8bit.v
TB1        := $(SRC_DIR)/tb/adder_1bit_tb.v
TB8        := $(SRC_DIR)/tb/adder_8bit_tb.v

OUT1       := $(BUILD_DIR)/sim1.vvp
OUT8       := $(BUILD_DIR)/sim8.vvp
OUTTOP     := $(BUILD_DIR)/sim_top.vvp

LOG1       := $(BUILD_DIR)/sim1.log
LOG8       := $(BUILD_DIR)/sim8.log
LOGTOP     := $(BUILD_DIR)/sim_top.log

WAVE1      := $(WAVES_DIR)/waves_1bit.vcd
WAVE8      := $(WAVES_DIR)/waves_8bit.vcd
WAVETOP    := $(WAVES_DIR)/waves_top.vcd

SIM_FLAGS  := -Wall

.PHONY: all sim1 sim8 sim_top view1 view8 view_top clean

# Default now runs and opens the top-level simulation
all: view_top

# compile-only targets
$(OUT1): | $(BUILD_DIR)
	$(SIM) $(SIM_FLAGS) -o $@ $(SRC_DIR)/adder_1bit.v $(TB1)

$(OUT8): | $(BUILD_DIR)
	$(SIM) $(SIM_FLAGS) -o $@ $(RTL) $(TB8)

$(OUTTOP): | $(BUILD_DIR)
	$(SIM) $(SIM_FLAGS) -o $@ $(SRC_DIR)/top.v $(RTL) $(SRC_DIR)/tb/top_tb.v

# run targets (capture logs)
sim1: $(OUT1) | $(WAVES_DIR)
	@echo "Running 1-bit TB..."
	$(RUN) $(OUT1) > $(LOG1) 2>&1 || (cat $(LOG1); false)
	@echo "Log: $(LOG1)"

sim8: $(OUT8) | $(WAVES_DIR)
	@echo "Running 8-bit exhaustive TB..."
	$(RUN) $(OUT8) > $(LOG8) 2>&1 || (cat $(LOG8); false)
	@echo "Log: $(LOG8)"

sim_top: $(OUTTOP) | $(WAVES_DIR)
	@echo "Running top-level TB..."
	$(RUN) $(OUTTOP) > $(LOGTOP) 2>&1 || (cat $(LOGTOP); false)
	@echo "Log: $(LOGTOP)"

view1: sim1
	$(GTKWAVE) $(WAVE1)	

view8: sim8
	$(GTKWAVE) $(WAVE8)

view_top: sim_top
	$(GTKWAVE) $(WAVETOP)

# build directory
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# waves directory
$(WAVES_DIR):
	mkdir -p $(WAVES_DIR)

clean:
	rm -rf $(BUILD_DIR)
	rm -rf $(WAVES_DIR)
