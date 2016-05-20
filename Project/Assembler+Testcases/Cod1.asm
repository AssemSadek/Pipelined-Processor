0             ;ISR address
125                   ;the program starts at address 6

;data segment
10
20
30
40
10
10

;program
LDM r0,5
in r0



.125                ;go to address 125
RTI
