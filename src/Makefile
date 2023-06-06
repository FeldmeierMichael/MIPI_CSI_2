PREFIX ?= /snap/openxc7/current
DB_DIR=${PREFIX}/opt/nextpnr-xilinx/external/prjxray-db
CHIPDB=chipdb

PART = xc7a100tcsg324-1
#PART = xc7a35tcsg324-1


# The chip database only needs to be generated once
# that is why we don't clean it with make clean
${CHIPDB}/${PART}.bin:
	python3 ${PREFIX}/opt/nextpnr-xilinx/python/bbaexport.py --device ${PART} --bba ${PART}.bba
	bbasm -l ${PART}.bba ${CHIPDB}/${PART}.bin
	rm -f ${PART}.bba


#############################################################
##   blinky-Test										   ##
#############################################################
blinky.json: topfiles/blinky.v
	yosys -p "synth_xilinx -flatten -abc9 -nobram -arch xc7 -top blinky; write_json blinky.json" $<

blinky.fasm: blinky.json ${CHIPDB}/${PART}.bin
	nextpnr-xilinx --chipdb ${CHIPDB}/${PART}.bin --xdc constraints/TE0711.xdc --json blinky.json --fasm $@ --verbose --debug	
	
blinky.frames: blinky.fasm
	fasm2frames --part ${PART} --db-root ${DB_DIR}/artix7 $< > $@ #FIXME: fasm2frames should be on PATH

blinky.bit: blinky.frames
	xc7frames2bit --part_file ${DB_DIR}/artix7/${PART}/part.yaml --part_name ${PART} --frm_file $< --output_file $@
	cp blinky.bit /media/sf_Shared-Folder
	cp blinky.bit bitfiles
	rm blinky.bit

#############################################################
##   HDMI-Test										       ##
#############################################################
HDMI_test.json: topfiles/HDMI_test.v  
	yosys -p "read_verilog hdmi-core/HDMI_Transciever.v; read_verilog hdmi-core/TMDS_Encoder.v;	 synth_xilinx -flatten -abc9 -nobram -arch xc7 -top HDMI_test;   write_json HDMI_test.json" $<

HDMI_test.fasm: HDMI_test.json ${CHIPDB}/${PART}.bin
	nextpnr-xilinx --chipdb ${CHIPDB}/${PART}.bin --xdc constraints/TE0711.xdc --freq 100 --json HDMI_test.json --fasm $@ --verbose --debug	
	
HDMI_test.frames: HDMI_test.fasm
	fasm2frames --part ${PART} --db-root ${DB_DIR}/artix7 $< > $@ #FIXME: fasm2frames should be on PATH

HDMI_test.bit: HDMI_test.frames
	xc7frames2bit --part_file ${DB_DIR}/artix7/${PART}/part.yaml --part_name ${PART} --frm_file $< --output_file $@
	cp HDMI_test.bit /media/sf_Shared_Folder
	cp HDMI_test.bit bitfiles
	rm HDMI_test.bit

#############################################################
##   END										           ##
#############################################################

.PHONY: clean
clean:
	@rm -f *.bit
	@rm -f *.frames
	@rm -f *.fasm
	@rm -f *.json
