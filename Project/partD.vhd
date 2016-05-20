library ieee;
Use ieee.std_logic_1164.all;

entity partD is 
	port(
	A: in std_logic_vector(15 downto 0);
	S10: in std_logic_vector(1 downto 0);
	Cin: in std_logic;
	F: out std_logic_vector(15 downto 0);
	Cout: out std_logic
	);
end entity partD;

architecture mainD of partD is
begin

	Cout <= A(15);
	F <= A(14 downto 0)&'0' when S10 = "00" else
	     A(14 downto 0)&A(15) when S10 = "01" else
	     A(14 downto 0)&Cin when S10 = "10" else
	     "0000000000000000";

end architecture mainD;
