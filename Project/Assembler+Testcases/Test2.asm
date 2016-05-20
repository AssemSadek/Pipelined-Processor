6                    ;the program starts at address 6
125                  ;ISR address

;data segment
10
20
30
40

;program
Ldm R0, 2         ;R0 = 2d
Ldm R1, 3         ;R1 = 3d
LDD R2, 2            ;R2 = 10d
LDD R3, 3            ;R3 = 20d
STD R2, 4           ;Mem[4]=10
STD R3, 5           ;Mem[5]=20

.125                ;go to address 125
RTI
