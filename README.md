# PONG GAME !!!
- This is a mini project (just for fun) implementing PONG Game on Sispeed Tang Nano 9k FPGA and display the game on the Monitor using VGA cable
- We will use a 1368x768 @60Hz Monitor (Samsung B1930N)
- The clock frequency of the FPGA is 27MHz
<img width="1200" height="800" alt="image" src="https://github.com/user-attachments/assets/41b7f20a-9990-4aff-bf54-5496b5b75e04" />

## TIMING DIAGRAM
<img width="1200" height="800" alt="image" src="https://github.com/user-attachments/assets/c82b9a55-da7f-46a2-a036-82146bc26612" />


- We'll choose Horizontal frequency at 47.7kHz and Vertical frequency at 60Hz

### Horizontal
|               |  Pixels  | MicroSeconds |
|:--------------|:---------|:-------------|
| Visible Area  |    430   |     15.93    |
| Front Porch   |    23    |     0.84     |
| Sync Pulse    |    45    |     1.677    |
| Back Porch    |    68    |     2.515    |
| Whole Line    |    566   |     20.96    |  (47,7 kHz)

### Vertical
|               |  Pixels  | Mili Seconds |
|:--------------|:---------|:-------------|
| Visible Area  |    768   |     16.1     |
| Front Porch   |    1     |     0.021    |
| Sync Pulse    |    3     |     0.063    |
| Back Porch    |    23    |     0.482    |
| Whole Line    |    795   |     16.67    |  (60 Hz)


## PINOUT
- We only need 5 pins to drive the monitor including RED, GREEN, BLUE, H-SYNC and V-SYNC
- RED, GREEN and BLUE have 75 Ohms output impedance and they need a voltage at 0.7V to work properly
- The unused pins can be tied to GND

<img width="1200" height="800" alt="image" src="https://github.com/user-attachments/assets/216b34af-6bf5-4231-a43e-6da75d4cf17f" />

- In this project, I employed a 64-color lookup table (CLUT), which utilizes a 6-bit color depth (2 bits per color channel: Red, Green, and Blue).

<img width="665" height="377" alt="image" src="https://github.com/user-attachments/assets/8daafffe-10a2-4332-b070-57ef1ff87cc2" />

### Coloring Table

| RAM1 and RAM2 Input | RGB Voltage (V) | Resistance (Ohm) |
|:--------------------|:----------------|:-----------------|
|         00          |        0        |         0        |
|         01          |        0.23     |       1.55k      |
|         10          |        0.47     |       722.9      |
|         11          |        0.7      |       460.7      |

![Image](https://github.com/user-attachments/assets/3155589e-9384-4821-bd6a-ffd600e15430)

## DISPLAYING
- At first, we'll try to display this image to check whether the VGA displaying module is working or not

<img width="1280" height="1080" alt="image" src="https://github.com/user-attachments/assets/c21047e4-6b2c-4995-9488-e16739006185" />

### DISPLAYING IMAGE
https://github.com/user-attachments/assets/2dac2017-d662-4112-8aea-bb7184494ea9



### PONG GAME !!!
https://github.com/user-attachments/assets/e4cf6e9e-e3d1-45ba-9d36-35078ce55938


