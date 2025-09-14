srcfile:=	../../project/src/dvi_tx/dvi_tx.vo
			

tbfile:=	../../tb/tb.v \
			../../tb/driver/*.v \
			../../tb/monitor/*.v \
			../../tb/dvi_rx/dvi_rx.vo
			

ic:
	echo $(tbfile)
	echo $(srcfile)
	#iverilog -g2005-sv \
	#-v /Applications/GowinIDE.app/Contents/Resources/Gowin_EDA/IDE/simlib/gw1n/prim_sim.v \
	#$(tbfile) \
	#$(srcfile) 



vcs:
	vcs -debug_all -R -full64 -fsdb -sverilog \
	-v ../../tb/prim_sim.v \
	$(tbfile) \
	$(srcfile) 

verdi:
	verdi -sverilog	-nologo \
	-v ../../tb/prim_sim.v \
	$(tbfile) \
	$(srcfile) \
	-ssf tb.fsdb \
	&

clean:
	rm -rf compile  *.err *.log csrc  run.do  simv  simv.daidir  ucli.key  vc_hdrs.h  work novas.rc  nWaveLog   vcd2fsdbLog  verilog.vcd  verilog.vcd.fsdb vsim.wlf simv.vdb INCA_libs waves.shm .simvision *.rc cov_work daTaseT.asdb  fcover.acdb  library.cfg elab_file *.ucdb verdiLog inTer.vpd novas.conf wave.ses.png *.fsdb daTa

