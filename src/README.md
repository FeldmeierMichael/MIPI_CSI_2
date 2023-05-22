# Testsetups for Xillinx Series 7

## Artix 7 Testsetup

 Artix 7 100T Trenz TE0711 with Carierboard TEB0707 and VHDPlus Cruve-MIPI HS Adapter
 
 ### TE0711 Artix 7 100T Board:
 
<img src="/images/TE0711.png">

### TEB0707 Carrier Board three Cruvi HS Connectors:

<img src="/images/TEB0707.jpg" >

### VHDPlus MIPI to Cruvi Boards:

<img src="/images/CruviMipi.png">

### Connectors and Schematics:
MIPI Connector to J10:

TMDS0_p -> A1_p -> Pin 20 \
TMDS0_n -> A1_n -> Pin 22 

TMDS1_p -> A2_p -> Pin 26 \
TMDS1_n -> A2_n -> Pin 28 

TMDS2_p -> A3_p -> Pin 32 \
TMDS2_n -> A3_n -> Pin 34 

CLK_p   -> B1_p -> Pin 21 \
CLK_n   -> B1_n -> Pin 23 


<img src="/images/CruviCam.png">


Schematic Carrier Board:

TMDS0_p -> A1_p -> Pin 20 -> CA_A1_P \
TMDS0_n -> A1_n -> Pin 22 -> CA_A1_N 

TMDS1_p -> A2_p -> Pin 26 -> CA_A2_P \
TMDS1_n -> A2_n -> Pin 28 -> CA_A2_N 

TMDS2_p -> A3_p -> Pin 32 -> CA_A3_P \
TMDS2_n -> A3_n -> Pin 34 -> CA_A3_P 

CLK_p   -> B1_p -> Pin 21 ->CA_B1_P \
CLK_n   -> B1_n -> Pin 23 ->CA_B1_N 

<img src="/images/Sche_car.png">

<img src="/images/Sche_car2.png">
