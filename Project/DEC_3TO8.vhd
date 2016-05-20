--Distenation Selector DECODER 
--Decoder that will select the register to write into
library ieee;
use ieee.std_logic_1164.all;
entity DEC_3TO8 is port(
Enable : in std_logic;
Input : in std_logic_vector(2 downto 0);
Output : out std_logic_vector(7 downto 0)
);
end DEC_3TO8;
architecture DEC_3TO8_Arch of DEC_3TO8 is
begin
--to select the reg2 input = 010
Output <= "00000000" when Enable ='0' else
	  "00000001" when Input="000" else
	  "00000010" when Input="001" else
	  "00000100" when Input="010" else
	  "00001000" when Input="011" else
	  "00010000" when Input="100" else
	  "00100000" when Input="101" else
	  "01000000" when Input="110" else
	  "10000000";
end DEC_3TO8_Arch;
