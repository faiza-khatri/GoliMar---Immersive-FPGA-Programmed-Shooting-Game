# Implementing a Shooting Game using the Basys 3 Digilent Board

- The project can be opened in vivado and can be used as an input module for integration.

This project uses Verilog HDL to program the Digilent Basys 3. The inputs are in the form of the Dual Axis PS2 joysticks, operating on a data communication bus, and the FPGA buttons. USing these, the game invlves pixel mapping vga output such that there are two characters, enemies, that the player must kill, and friends that the player must save.

The FSM is a Mealy Machine, and the state diagram is as follows:
![Screenshot 2024-05-10 222619](https://github.com/faiza-khatri/GoliMar---Immersive-FPGA-Programmed-Shooting-Game/assets/161750227/83840f83-cd58-4cd7-9c21-8c4174a52a34)



