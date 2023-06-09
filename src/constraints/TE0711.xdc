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
##   HDMI Constraints    								   ##
#############################################################

set_property LOC H1 [get_ports TMDS_p[0]]                  #TMDS0_p
set_property IOSTANDARD LVCMOS33 [get_ports {TMDS_p[0]}]

set_property LOC G1 [get_ports TMDS_n[0]]                  #TMDS0_n
set_property IOSTANDARD LVCMOS33 [get_ports {TMDS_n[0]}]


set_property LOC D8 [get_ports TMDS_p[1]]                  #TMDS1_p
set_property IOSTANDARD LVCMOS33 [get_ports {TMDS_p[1]}]

set_property LOC C7 [get_ports TMDS_n[1]]                  #TMDS1_n
set_property IOSTANDARD LVCMOS33 [get_ports {TMDS_n[1]}]


set_property LOC F4 [get_ports TMDS_p[2]]                  #TMDS2_p
set_property IOSTANDARD LVCMOS33 [get_ports {TMDS_p[2]}]

set_property LOC F3 [get_ports TMDS_n[2]]                  #TMDS2_n
set_property IOSTANDARD LVCMOS33 [get_ports {TMDS_n[2]}]



set_property LOC C4 [get_ports TMDS_p[3]]                  #TMDS3_p-Clock
set_property IOSTANDARD LVCMOS33 [get_ports {TMDS_p[3]}]

set_property LOC B4 [get_ports TMDS_n[3]]                  #TMDS3_n-Clock
set_property IOSTANDARD LVCMOS33 [get_ports {TMDS_n[3]}]



set_property LOC F1 [get_ports SCL]                  #SCL
set_property IOSTANDARD LVCMOS33 [get_ports {SCL}]


set_property LOC D3 [get_ports HPD]                  #HPD
set_property IOSTANDARD DIFF_LVCMOS33 [get_ports {HPD}]


set_property LOC E1 [get_ports SDA]                  #SDA
set_property IOSTANDARD DIFF_LVCMOS33 [get_ports {SDA}]

#############################################################
##   PSRAM Constraints    								   ##
#############################################################

set_property LOC F1 [get_ports CLK]                  #SCLK
set_property IOSTANDARD LVCMOS33 [get_ports {CLK}]

set_property LOC F1 [get_ports CE]                  #CE
set_property IOSTANDARD LVCMOS33 [get_ports {CE}]

set_property LOC F1 [get_ports DM0]                  #DM0
set_property IOSTANDARD LVCMOS33 [get_ports {DM0}]

set_property LOC F1 [get_ports DM1]                  #DM1
set_property IOSTANDARD LVCMOS33 [get_ports {DM1}]

set_property LOC F1 [get_ports D[0]]                  #D[0]
set_property IOSTANDARD LVCMOS33 [get_ports {D[0]}]

set_property LOC F1 [get_ports D[1]]                  #D[1]
set_property IOSTANDARD LVCMOS33 [get_ports {D[1]}]

set_property LOC F1 [get_ports D[2]]                  #D[2]
set_property IOSTANDARD LVCMOS33 [get_ports {D[2]}]

set_property LOC F1 [get_ports D[3]]                  #D[3]
set_property IOSTANDARD LVCMOS33 [get_ports {D[3]}]

set_property LOC F1 [get_ports D[4]]                  #D[4]
set_property IOSTANDARD LVCMOS33 [get_ports {D[4]}]

set_property LOC F1 [get_ports D[5]]                  #D[5]
set_property IOSTANDARD LVCMOS33 [get_ports {D[5]}]

set_property LOC F1 [get_ports D[6]]                  #D[6]
set_property IOSTANDARD LVCMOS33 [get_ports {D[6]}]

set_property LOC F1 [get_ports D[7]]                  #D[7]
set_property IOSTANDARD LVCMOS33 [get_ports {D[7]}]

set_property LOC F1 [get_ports D[8]]                  #D[8]
set_property IOSTANDARD LVCMOS33 [get_ports {D[8]}]

set_property LOC F1 [get_ports D[9]]                  #D[9]
set_property IOSTANDARD LVCMOS33 [get_ports {D[9]}]

set_property LOC F1 [get_ports D[10]]                  #D[10]
set_property IOSTANDARD LVCMOS33 [get_ports {D[10]}]

set_property LOC F1 [get_ports D[11]]                  #D[11]
set_property IOSTANDARD LVCMOS33 [get_ports {D[11]}]

set_property LOC F1 [get_ports D[12]]                  #D[12]
set_property IOSTANDARD LVCMOS33 [get_ports {D[12]}]

set_property LOC F1 [get_ports D[13]]                  #D[13]
set_property IOSTANDARD LVCMOS33 [get_ports {D[13]}]

set_property LOC F1 [get_ports D[14]]                  #D[14]
set_property IOSTANDARD LVCMOS33 [get_ports {D[14]}]

set_property LOC F1 [get_ports D[15]]                  #D[15]
set_property IOSTANDARD LVCMOS33 [get_ports {D[15]}]


#############################################################
##   Clock Constraints    								   ##
#############################################################

create_clock -name sys_clk -period 10.0 [get_ports sys_clk]