library ieee;
Use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity partB is 
	port(
	A: in std_logic_vector(15 downto 0);
	B: in std_logic_vector(15 downto 0);
	S10: in std_logic_vector(1 downto 0);
	F: out std_logic_vector(15 downto 0)
	);
end entity partB;

architecture mainB of partB is
begin
	
	F <= A and B when S10 = "00" else
	     A or B when S10 = "01" else
	     (not A) + "0000000000000001" when S10 = "10" else
	     not A;

end architecture mainB;
