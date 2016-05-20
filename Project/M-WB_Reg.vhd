library ieee;
use ieee.std_logic_1164.all;
entity MWB_Reg is 
Generic ( n : integer := 16);
port(
Clk : in std_logic;
Rst : in std_logic;
Enb : in std_logic;

InSignal_i: in std_logic;
WB_i: in std_logic;
Ra_i: in std_logic_vector(2 downto 0);
Data_i: in std_logic_vector(15 downto 0);
PopSignal_i: in std_logic;
PushSignal_i: in std_logic;
RetSignal_i: in std_logic;

InSignal_o: out std_logic;
WB_o: out std_logic;
Ra_o: out std_logic_vector(2 downto 0);
Data_o: out std_logic_vector(15 downto 0);
PopSignal_o: out std_logic;
PushSignal_o: out std_logic;
RetSignal_o: out std_logic;
RetiSig_i : in std_logic;
RetiSig_o : out std_logic
);
end MWB_Reg;

architecture MWB_Reg_arch of MWB_Reg is
component General_Reg is 
Generic ( n : integer := 16);
port(
Clk : in std_logic;
Rst : in std_logic;
Enb : in std_logic;
D : in std_logic_vector((n-1) downto 0);
Q : out std_logic_vector((n-1) downto 0)
);
end component;

component One_Bit_Reg is 
port(
Clk : in std_logic;
Rst : in std_logic;
Enb : in std_logic;
D : in std_logic;
Q : out std_logic
);
end component;

begin

InSignal: One_Bit_Reg port map(Clk,Rst,Enb,InSignal_i,InSignal_o);
WB: One_Bit_Reg port map(Clk,Rst,Enb,WB_i,WB_o);
Ra: General_Reg generic map (n=>3) port map(Clk,Rst,Enb,Ra_i,Ra_o);
Data: General_Reg generic map (n=>16) port map(Clk,Rst,Enb,Data_i,Data_o);
PopSignal: One_Bit_Reg port map(Clk,Rst,Enb,PopSignal_i,PopSignal_o);
PushSignal: One_Bit_Reg port map(Clk,Rst,Enb,PushSignal_i,PushSignal_o);
RetSignal: One_Bit_Reg port map(Clk,Rst,Enb,RetSignal_i,RetSignal_o);
RetiSignal: One_Bit_Reg port map(Clk,Rst,Enb,RetiSig_i,RetiSig_o);

end MWB_Reg_arch; 
