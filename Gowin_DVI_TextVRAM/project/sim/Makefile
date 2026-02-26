# Makefile for Text VRAM simulation

# Tools
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

# Source files
SRCDIR = ./rtl
SRCS = \
../src/dvi_tx/dvi_tx.vo \
../src/gowin_rpll/gowin_rpll.v \
../src/TextVRAM/vga_timing.v \
../src/TextVRAM/font_rom.v \
../src/TextVRAM/preset.v  \
../src/TextVRAM/text_vram_top.v \
../src/TextVRAM/text_vram.v \
../src/gowin_rpll/TMDS_rPLL.v \
../src/video_top.v \


GOWIN1NLIB = -v /Applications/GowinIDE.app/Contents/Resources/Gowin_EDA/IDE/simlib/gw1n/prim_sim.v  

BENCHDIR = ./bench
TB = $(BENCHDIR)/top.sv

# Output files
OUT = vga_top.vvp
VCD = wave.fst

.PHONY: all sim wave clean

all: sim

# Compile
$(OUT): $(SRCS) $(TB)
	##$(IVERILOG) -g2012 $(GOWIN1NLIB) $(TB) $(SRCS)  -o $(OUT)   
	###$(IVERILOG) -g2012 $(GOWIN1NLIB) $(TB) $(SRCS)  
	iverilog -g2012 -f list.f -o $(OUT)

# Run simulation
sim: $(OUT)
	$(VVP) $(OUT) -fst

# View waveform
wave wav: 
	$(GTKWAVE) $(VCD) &

# Clean
clean:
	rm -f $(OUT) $(VCD)
