library ieee;
Use ieee.std_logic_1164.all;

entity partE is 
	port(
	A: in std_logic_vector(15 downto 0);
	B: in std_logic_vector(15 downto 0);
	Cin: in std_logic;
	S10: in std_logic_vector(1 downto 0);
	F: out std_logic_vector(15 downto 0);
	Cout: out std_logic;
	Vout: out std_logic
	);
end entity partE;

architecture mainE of partE is
component my_nadder is
	Generic (n : integer := 8);
	PORT(
	a, b : in std_logic_vector(n-1 downto 0) ;
	cin : in std_logic;
	s : out std_logic_vector(n-1 downto 0);
	cout : out std_logic
	);
end component;
signal dataBusNAdder,inB: std_logic_vector(15 downto 0);
signal NAdderCout,inC: std_logic;
begin
	inB <= "0000000000000000" when S10 = "00" else
		B when S10 = "01" else
		not B when S10 = "10" else
		"1111111111111111";

	inC <= not S10(0);

	NAdder: my_nadder generic map (n=>16) port map(A,inB,inC,dataBusNadder,NadderCout);
	
	Cout <= NadderCout when S10 = "00" or S10 = "01" else
		not NadderCout;

	F <= "0000000000000000" when S10 = "11" and Cin = '1' else
	     dataBusNadder;

	Vout <= '1' when (A(15)='0' and inB(15)='0' and dataBusNadder(15)='1') or (A(15)='1' and inB(15)='1' and dataBusNadder(15)='0') else
		'0';

end architecture mainE;