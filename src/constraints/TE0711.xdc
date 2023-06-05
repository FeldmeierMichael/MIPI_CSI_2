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


set_property LOC H2 [get_ports TMDS_p[0]]                  #TMDS0_p
set_property IOSTANDARD LVCMOS33 [get_ports {TMDS_p[0]}]

set_property LOC G2 [get_ports TMDS_n[0]]                  #TMDS0_n
set_property IOSTANDARD LVCMOS33 [get_ports {TMDS_n[0]}]


set_property LOC A4 [get_ports TMDS_p[1]]                  #TMDS1_p
set_property IOSTANDARD LVCMOS33 [get_ports {TMDS_p[1]}]

set_property LOC A3 [get_ports TMDS_n[1]]                  #TMDS1_n
set_property IOSTANDARD LVCMOS33 [get_ports {TMDS_n[1]}]


set_property LOC J4 [get_ports TMDS_p[2]]                  #TMDS2_p
set_property IOSTANDARD LVCMOS33 [get_ports {TMDS_p[2]}]

set_property LOC H4 [get_ports TMDS_n[2]]                  #TMDS2_n
set_property IOSTANDARD LVCMOS33 [get_ports {TMDS_n[2]}]



set_property LOC B1 [get_ports TMDS_p[3]]                  #TMDS3_p-Clock
set_property IOSTANDARD LVCMOS33 [get_ports {TMDS_p[3]}]

set_property LOC A1 [get_ports TMDS_n[3]]                  #TMDS3_n-Clock
set_property IOSTANDARD LVCMOS33 [get_ports {TMDS_n[3]}]


#############################################################
##   Clock Constraints    								   ##
#############################################################

create_clock -name sys_clk -period 10.0 [get_ports sys_clk]