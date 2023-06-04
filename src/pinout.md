# Connectors and Schematics:
## HDMI Out
### HDMI Connector to J10:

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

CLK_p   -> B1_p -> Pin 21 -> CA_B1_P \
CLK_n   -> B1_n -> Pin 23 -> CA_B1_N 

<img src="/images/Sche_car.png">

Connected to Header JB2/JM2

TMDS0_p -> A1_p -> Pin 20 -> CA_A1_P -> Pin 63\
TMDS0_n -> A1_n -> Pin 22 -> CA_A1_N -> Pin 61

TMDS1_p -> A2_p -> Pin 26 -> CA_A2_P -> Pin 86\
TMDS1_n -> A2_n -> Pin 28 -> CA_A2_N -> Pin 88

TMDS2_p -> A3_p -> Pin 32 -> CA_A3_P -> Pin 45\
TMDS2_n -> A3_n -> Pin 34 -> CA_A3_P -> Pin 47

CLK_p   -> B1_p -> Pin 21 ->CA_B1_P -> Pin 76\
CLK_n   -> B1_n -> Pin 23 ->CA_B1_N -> Pin 78

<img src="/images/Sche_car2.PNG">

TMDS0_p -> A1_p -> Pin 20 -> CA_A1_P -> Pin 63 -> B35_L15_N\
TMDS0_n -> A1_n -> Pin 22 -> CA_A1_N -> Pin 61 -> B35_L15_P

TMDS1_p -> A2_p -> Pin 26 -> CA_A2_P -> Pin 86 -> B35_L8_N\
TMDS1_n -> A2_n -> Pin 28 -> CA_A2_N -> Pin 88 -> B35_L8_P

TMDS2_p -> A3_p -> Pin 32 -> CA_A3_P -> Pin 45 -> B35_L21_N\
TMDS2_n -> A3_n -> Pin 34 -> CA_A3_P -> Pin 47 -> B35_L21_P

CLK_p   -> B1_p -> Pin 21 ->CA_B1_P -> Pin 76 -> BE_L9_P\
CLK_n   -> B1_n -> Pin 23 ->CA_B1_N -> Pin 78 -> BE_L9_N

<img src="/images/Sche_TE0711.PNG">

TMDS0_p -> A1_p -> Pin 20 -> CA_A1_P -> Pin 63 -> B35_L15_N -> G2\
TMDS0_n -> A1_n -> Pin 22 -> CA_A1_N -> Pin 61 -> B35_L15_P -> H2

TMDS1_p -> A2_p -> Pin 26 -> CA_A2_P -> Pin 86 -> B35_L8_N -> A3\
TMDS1_n -> A2_n -> Pin 28 -> CA_A2_N -> Pin 88 -> B35_L8_P -> A4

TMDS2_p -> A3_p -> Pin 32 -> CA_A3_P -> Pin 45 -> B35_L21_N -> H4\
TMDS2_n -> A3_n -> Pin 34 -> CA_A3_P -> Pin 47 -> B35_L21_P -> J4

CLK_p   -> B1_p -> Pin 21 ->CA_B1_P -> Pin 76 -> BE_L9_P -> B1\
CLK_n   -> B1_n -> Pin 23 ->CA_B1_N -> Pin 78 -> BE_L9_N -> A1

<img src="/images/Sche1_TE0711.PNG">
