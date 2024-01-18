## This file is a general .xdc for the Basys3 rev B board for ENGS31/CoSc56
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

##====================================================================
## External_Clock_Port
##====================================================================
set_property PACKAGE_PIN W5 [get_ports clk_ext_port]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk_ext_port]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk_ext_port]

##====================================================================
## Switch_ports
##====================================================================
## SWITCH 0
set_property PACKAGE_PIN V17 [get_ports {mode_ext_port}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {mode_ext_port}]
	
##====================================================================	
## 7 segment display
##====================================================================
set_property PACKAGE_PIN W7 [get_ports {seg_ext_port[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg_ext_port[0]}]
set_property PACKAGE_PIN W6 [get_ports {seg_ext_port[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg_ext_port[1]}]
set_property PACKAGE_PIN U8 [get_ports {seg_ext_port[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg_ext_port[2]}]
set_property PACKAGE_PIN V8 [get_ports {seg_ext_port[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg_ext_port[3]}]
set_property PACKAGE_PIN U5 [get_ports {seg_ext_port[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg_ext_port[4]}]
set_property PACKAGE_PIN V5 [get_ports {seg_ext_port[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg_ext_port[5]}]
set_property PACKAGE_PIN U7 [get_ports {seg_ext_port[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg_ext_port[6]}]

set_property PACKAGE_PIN V7 [get_ports dp_ext_port]							
	set_property IOSTANDARD LVCMOS33 [get_ports dp_ext_port]

set_property PACKAGE_PIN U2 [get_ports {an_ext_port[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an_ext_port[0]}]
set_property PACKAGE_PIN U4 [get_ports {an_ext_port[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an_ext_port[1]}]
set_property PACKAGE_PIN V4 [get_ports {an_ext_port[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an_ext_port[2]}]
set_property PACKAGE_PIN W4 [get_ports {an_ext_port[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an_ext_port[3]}]

##====================================================================
## Pmod Header JA
##====================================================================
#Sch name = JA1
set_property PACKAGE_PIN J1 [get_ports {spi_cs_ext_port}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {spi_cs_ext_port}]
#Sch name = JA2
set_property PACKAGE_PIN L2 [get_ports {spi_s_data_ext_port}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {spi_s_data_ext_port}]
#Sch name = JA3
#set_property PACKAGE_PIN J2 [get_ports {JA_port[2]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {JA_port[2]}]
#Sch name = JA4
set_property PACKAGE_PIN G2 [get_ports {spi_sclk_ext_port}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {spi_sclk_ext_port}]

##====================================================================
## Pmod Header JB
##====================================================================
##Sch name = JB1
set_property PACKAGE_PIN A14 [get_ports {spi_trigger_ext_port}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {spi_trigger_ext_port}]

##====================================================================
## Implementation Assist
##====================================================================	
## These additional constraints are recommended by Digilent, do not remove!
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]