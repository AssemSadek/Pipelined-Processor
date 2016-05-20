--Multiplixer that selects the candidate Register to output on the BUS
library ieee;
use ieee.std_logic_1164.all;
entity MUX_3x8 is port(
Input0, Input1, Input2, Input3, Input4, Input5, Input6, Input7 : in std_logic_vector(15 downto 0);
Selectors : in std_logic_vector(2 downto 0);
Output : out std_logic_vector(15 downto 0)
);
end MUX_3x8;

architecture MUX_3x8_Arch of MUX_3x8 is
begin
Output <= Input0 when Selectors = "000" 
     else Input1 when Selectors = "001"
     else Input2 when Selectors = "010"
     else Input3 when Selectors = "011"
     else Input4 when Selectors = "100"
     else Input5 when Selectors = "101"
     else Input6 when Selectors = "110"
     else Input7 when Selectors = "111";
end MUX_3x8_Arch;

