library ieee;
Use ieee.std_logic_1164.all;

entity ALU is 
	port(
	A: in std_logic_vector(15 downto 0);
	B: in std_logic_vector(15 downto 0);
	Cin: in std_logic;
	S3210: in std_logic_vector(3 downto 0);
	F: out std_logic_vector(15 downto 0);
	Flags: out std_logic_vector(3 downto 0)
	);
end entity ALU;

architecture mainALU of ALU is
component partB is
	port(
	A: in std_logic_vector(15 downto 0);
	B: in std_logic_vector(15 downto 0);
	S10: in std_logic_vector(1 downto 0);
	F: out std_logic_vector(15 downto 0)
	);
end component;
component partC is
	port(
	A: in std_logic_vector(15 downto 0);
	S10: in std_logic_vector(1 downto 0);
	Cin: in std_logic;
	F: out std_logic_vector(15 downto 0);
	Cout: out std_logic
	);
end component;
component partD is
	port(
	A: in std_logic_vector(15 downto 0);
	S10: in std_logic_vector(1 downto 0);
	Cin: in std_logic;
	F: out std_logic_vector(15 downto 0);
	Cout: out std_logic
	);
end component;
component partE is 
	port(
	A: in std_logic_vector(15 downto 0);
	B: in std_logic_vector(15 downto 0);
	Cin: in std_logic;
	S10: in std_logic_vector(1 downto 0);
	F: out std_logic_vector(15 downto 0);
	Cout: out std_logic;
	Vout: out std_logic
	);
end component;

SIGNAL dataBusB,dataBusC,dataBusD,dataBusE: std_logic_vector(15 downto 0);
Signal CoutSigC,CoutSigD,CoutSigE,VoutSigE: std_logic;
begin

	u0: partB port map (A(15 downto 0),B(15 downto 0),S3210(1 downto 0),dataBusB);
	u1: partC port map (A(15 downto 0),S3210(1 downto 0),Cin,dataBusC,CoutSigC);
	u2: partD port map (A(15 downto 0),S3210(1 downto 0),Cin,dataBusD,CoutSigD);
	u3: partE port map (A(15 downto 0),B(15 downto 0),Cin,S3210(1 downto 0),dataBusE,CoutSigE,VoutSigE);
	
	Flags(2) <= CoutSigC when S3210(3 downto 2) = "10" else
		CoutSigD when S3210(3 downto 2) = "11" else
		CoutSigE when S3210(3 downto 2) = "00" else
	        '0';
	
	F <= dataBusB when S3210(3 downto 2) = "01" else
	     dataBusC when S3210(3 downto 2) = "10" else
	     dataBusD when S3210(3 downto 2) = "11" else
	     dataBusE;
	
	Flags(1) <= dataBusB(15) when S3210(3 downto 2) = "01" else
	     	dataBusC(15) when S3210(3 downto 2) = "10" else
	     	dataBusD(15) when S3210(3 downto 2) = "11" else
	     	dataBusE(15);

	Flags(0) <= '1' when (dataBusB = "0000000000000000" and S3210(3 downto 2) = "01") or (dataBusC = "0000000000000000" and S3210(3 downto 2) = "10") or (dataBusD = "0000000000000000" and S3210(3 downto 2) = "11") or (dataBusE = "0000000000000000" and S3210(3 downto 2) = "00") else
	     	'0';

	Flags(3) <= VoutSigE when S3210(3 downto 2) = "00" else
		'0';


end architecture mainALU;
