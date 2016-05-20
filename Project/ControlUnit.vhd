library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


Entity ControlUnit is

port ( InstCode : in std_logic_vector(4 downto 0);
       WBSig: out std_logic;
       MRSig: out std_logic;
       MWSig: out std_logic;
       JZSig : out std_logic;
       JNSig : out std_logic;
       JCSig : out std_logic;
       JmpSig : out std_logic;
       CallSig : out std_logic;
       PushSig: out std_logic;
       PopSig: out std_logic;
       RETSig: out std_logic;
       InSig: out std_logic;
       OutSig: out std_logic;
       ExecuteSig: out std_logic_vector(1 downto 0);
       Selectors: out std_logic_vector(3 downto 0);
       F_D_Flush: out std_logic;
       Interrupt_Signal: in std_logic;
       RETISig: out std_logic
       );
       
end entity ControlUnit;

architecture ControlUnit_function of ControlUnit is

begin
 
 
 
 WBSig <= '1' when ((InstCode>= "00001" and InstCode<="00111") or  (InstCode>="01011" and InstCode<="01100") or (InstCode>="01110" and InstCode<="10001") or (InstCode>="11001" and InstCode<="11010")) and Interrupt_Signal='0' else
	  '0';
 MRSig <= '1' when (InstCode = "01011"  or InstCode = "10111" or InstCode = "11000" or InstCode = "11010") and Interrupt_Signal='0'  else
          '0';
 MWSig <= '1' when InstCode = "01010"  or InstCode = "10110" or InstCode = "11011" or Interrupt_Signal='1'  else
          '0';
 JZSig<= '1' when (InstCode="10010") and Interrupt_Signal='0' else
	   '0';
 JNSig<= '1' when (InstCode="10011") and Interrupt_Signal='0' else
	   '0';
 JCSig<= '1' when (InstCode="10100") else
	   '0';
 JmpSig<= '1' when (InstCode="10101") else
	   '0';
 CallSig<= '1' when InstCode="10110" or Interrupt_Signal='1' else
	   '0';
 PushSig<= '1' when InstCode="10110" or InstCode ="01010" or Interrupt_Signal='1' else
           '0';
 PopSig <= '1' when (InstCode="01011" or InstCode="10111" or InstCode="11000") and Interrupt_Signal='0' else
           '0';

 RETSig <= '1' when (InstCode="10111" or InstCode="11000") and Interrupt_Signal='0' else
           '0';
 
 RETISig <= '1' when (InstCode="11000") and Interrupt_Signal='0' else
	    '0';

 InSig <= '1' when (InstCode="01100") and Interrupt_Signal='0'  else
           '0';
 OutSig <= '1' when (InstCode="01101") and Interrupt_Signal='0'  else
           '0';
		   
 ExecuteSig <="01" when ((InstCode>= "00010" and InstCode<="01001") or (InstCode>="01110" and InstCode<="10001"))  and Interrupt_Signal='0' else
              "10" when  ((InstCode>="10110" and InstCode<="11011") or InstCode ="01010" or InstCode="01011") and Interrupt_Signal='0' else
	      "00"; --MOV

 Selectors <= "0000" when InstCode="10000"  else
              "0001" when InstCode="00010"  else
              "0010" when InstCode="00011"  else
              "0011" when InstCode="10001"  else
              "0100" when InstCode="00100"  else
              "0101" when InstCode="00101"  else
              "0110" when InstCode="01111"  else
              "0111" when InstCode="01110"  else
              "1010" when InstCode="00111"  else
              "1110" when InstCode="00110"  else
	      "1000" when InstCode="01000"  else --SETC
	      "1001" when InstCode="01001"  else --CLRC
              "1111";

 F_D_Flush <= '1' when InstCode="11010"  and Interrupt_Signal='0' else
	      '0';

end architecture ControlUnit_function;
