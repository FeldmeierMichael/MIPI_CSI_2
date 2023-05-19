#############################################################
##   Pin Constraints    								   ##
#############################################################
set_property LOC P17 [get_ports sys_clk]                 #100 MHz Clock
set_property IOSTANDARD LVCMOS33 [get_ports {sys_clk}]

set_property LOC A8 [get_ports led[0]]                   #LED D1
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]

set_property LOC R17 [get_ports led[1]]                  #LED D2
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]

set_property LOC L15 [get_ports led[2]]                  #LED D3
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]




#############################################################
##   Clock Constraints    								   ##
#############################################################

create_clock -name sys_clk -period 10.0 [get_ports sys_clk]