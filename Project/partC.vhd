library ieee;
Use ieee.std_logic_1164.all;

entity partC is 
	port(
	A: in std_logic_vector(15 downto 0);
	S10: in std_logic_vector(1 downto 0);
	Cin: in std_logic;
	F: out std_logic_vector(15 downto 0);
	Cout: out std_logic
	);
end entity partC;

architecture mainC of partC is
begin

	Cout <= A(0);
	F <= '0'&A(15 downto 1) when S10 = "00" else
	     A(0)&A(15 downto 1) when S10 = "01" else
	     Cin&A(15 downto 1) when S10 = "10" else
	     A(15)&A(15 downto 1);

end architecture mainC;
