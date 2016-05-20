2                 ;the program starts at address 2
125               ;ISR address

;program
;set value 45d at In Port
In R0              ;R0 = 45d
;set value 5d at In Port
In R1              ;R1 = 5d
;set value 70d at In Port
In R2              ;R2 = 70d
;set value 126d at In Port
In R3              ;R3 = 126d

ADD R0, R1         ;R0 = 50d, C=0, Z=0, N=0
SUB R1, R3         ;R1 = -121d = 10000111b, C=1, Z=0, N=1
MOV R1, R3         ;R1 = 126d
OUT R1             ;OUT PORT = 126d

.125                ;go to address 125
RTI
