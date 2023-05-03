# relevant FPGA Specs for MIPI CSI2


# Lattice ECP5
  -IDDRX2F Inputs up to 800Mbits/s per Lane at best Speed Grade
   https://www.latticesemi.com/-/media/LatticeSemi/Documents/DataSheets/ECP5/FPGA-DS-02012-2-8-ECP5-ECP5G-Family-Data-Sheet.ashx?document_id=50461 S.67

  -No 1:8 Deserialisation possible max at 1:4 with IDDRX2F

  -more possible with Lattice SERDES Primitives
   

# Spartan 7  
  -ISerdes Inputs up to 1250Mbits/s per Lane at best Speed Grade
   https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwiz9qvp4dj-AhWpwQIHHZipAqsQFnoECAwQAQ&url=https%3A%2F%2Fdocs.xilinx.com%2Fr%2Fen-US%2Fds189-spartan-7-data-sheet&usg=AOvVaw1EquHW1x9nMGJjTvGVS6tl S.13

   -1:8 Deserialisation possible

   -Spartan 7 has no Gigabyte Transceivers for higher Data Rates


# Artix 7