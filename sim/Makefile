SRC 	:= ../hdl/adder_1bit.v ../hdl/tb/adder_1bit_tb.v
OUT		:= sim.out
WAVE 	:= waves.vcd

.PHONY: all clean view

all: $(OUT)
	vvp $(OUT)

$(OUT): $(SRC)
	iverilog -o $@ $(SRC)

view: $(WAVE)
	gtkwave $(WAVE) &

$(WAVE): $(OUT)
	vvp $(OUT)

clean:
	rm -f $(OUT) $(WAVE)
