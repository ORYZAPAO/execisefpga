//create_clock -name I_clk -period 20 -waveform {0 10} [get_ports {I_clk}] -add
create_clock -name I_clk  -period 37.037 -waveform {0 18.518} [get_ports {I_clk}]
//create_clock -name I_clk2 -period 16.0 -waveform {0 8.0} [get_ports {I_clk2}]