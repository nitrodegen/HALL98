# HALL98
8bit CPU in Verilog with basic stuff.


<h1>Specifications</h1>
32bit registers (H,A,L,N)<br>
16bit Instruction Pointer (P)<br>
100MHZ Speed

<h1>Instructions: </h1>
MOV (works with numbers and registers)
<br>
ADD (works only with registers (to lazy to add more) ) 
<br>
SUB (works only with registers (to lazy to add more) )
<br>
MUL (works only with registers (to lazy to add more) )
<br>
LDR (loads instruction from stack address to register)
<br>
STR (stores register value to stack address)

<br>

<h1>Why? </h1>
I'm currently doing geohot's course ,so I somehow need to learn this stuff.
<br>
And today I think I finally connected the dots on how CPU emulators work in Verilog.
<br>
Basically everything is the same as let's say, building emulators in C++ , just harder and more hardware specific.
<h1> Opcodes: </h1>
MOV: 0x45
<br>
ADD: 0x46
<br>
SUB: 0x47
<br>
MUL: 0x48
<br>
STR: 0x49
<br>
LDR: 0x4a
<br>
<h1>Example: Result of memtest.v </h1>
<img width="1293" alt="image" src="https://user-images.githubusercontent.com/59802817/174687095-c39d0236-cee4-4e6e-8292-72bc277e5a4e.png">

