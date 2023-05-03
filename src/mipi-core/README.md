# MIPI CORE

- For Lattice ECP5 using IDDRX2F 1-4 Deserializer
- For Xillinx Series 7 using ISerdes 1-8 Deserializer


### Parameter for Component:
- init_file: name of .mem File for Camera Init-Sequence (see /I2C_Init/init_mem)

- mipi_clock: Mipiclock Frequency in MHz

- sys_clock: System Clock Frequenzy in MHz

- mipi_lanes: number of Lanes for MIPI

- mipi_format: Format of Mipi Payload Date RAW8,RAW10

- frame_width: Frame Widith in Pixel 

- frame_height: Frame Height in Pixel 

- address_out_width: Output Address Bits

- data_out_width: Output Data Bits for Pixel Data 

![Mipi-Core](mipicore.png)

