ECE281_CE3
==========

Moore and Mealy machiens

### Abstract

In the classes ultimate mission to build a computer, it is impossible to understate how important sequential logic is. The
purpose of this lab was to familiarize ourselves with sequential logic programming in VHDL.

### Exercise Results and Analysis

The situation given was to create an elevator control circuit that could step up and down floors given a stop input
(TRUE if stopped) and an up_down input (TRUE when going up). In implementing the design both a Moore and Mealy machine 
were created from the shell VHDL code provided by the instructor. The full implementation of each of the circuit codes 
in VHDL is provided above.

Interestingly the "next state" process did not change in between the Mealy and Moore machines. Because that code in the 
Moore machine represented *input* logic there was not need to change it for the Mealy machine as a Mealy machine only 
requires that the *output* logic directly take in the inputs.

Testbench files were then created to test each of the machines. For the Moore machine an arbitrary clock period of 10 ns
was chosen. This period has a corresponding frequency of 100 MHz, should for some reason the frequency need to be 
decreased to 50 MHz then a clock period of 20 ns would have to be used.

To test both designs a situation was created where the elevator would travel up all four floors one at a time, stopping 
for two clock cycles at every floor and taking one clock cycle to travel, then going from the fourth to the first floor 
without stopping. This was achieved by changing the two input signals "stop" and "up_down". Self checking assert and 
report statements were added to ease checking, although manual checking was carried out to guarantee accuracy.

Between the two testbench files the order in which the inputs were switched in relation to the checking statements had 
to be changed to ensure proper output responses for "next floor". These slight discrepancies occurred because the 
computational output logic process in relation to the inputs and the register which were not always necessarily 
synchronized for the proper output.


Moore Machine
![alt text](https://raw.github.com/IanGoodbody/ECE281_CE3/master/Moore_testbench_signal.jpg "Moore Machine")

A manual check of the signals was carried out for the Moore machine by ensuring that the floor outputs (seen in the 
bottom row) were in a proper sequence. As designed, the elevator goes up a floor for a clock cycle (10 ns) then waits at
the floor for two, the elevator then goes down three floors in three clock cycles (the last set of values can be read in
the values column on the far left). The floor number switches on the rising edge of the clock as designed, and the
system begain changing when intended. Given these facts the Moore design was shown to be successful. 

Mealy Machine
![alt text](https://raw.github.com/IanGoodbody/ECE281_CE3/master/Mealy_testbench_signal.jpg "Mealy Machine")

The same checking system was carried out for the Mealy machine by which the floor and nextfloor outputs were checked for
accuracy. For the most part all signals matched up, with the floor signal counting up and down as with the Moore machine
and the nextfloor indicating the next state. With this the Mealy machine was also shown to be successful.
