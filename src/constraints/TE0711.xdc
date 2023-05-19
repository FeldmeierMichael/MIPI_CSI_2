#############################################################
##   Pin Constraints    								   ##
#############################################################
set_property LOC P17 [get_ports sys_clk]           #100 MHz Clock
set_property IOSTANDARD LVCMOS33 [get_ports {sys_clk}]




set_property LOC A8 [get_ports led]
set_property IOSTANDARD LVCMOS33 [get_ports {led}]

#############################################################
##   Clock Constraints    								   ##
#############################################################

create_clock -name sys_clk -period 10.0 [get_ports sys_clk]