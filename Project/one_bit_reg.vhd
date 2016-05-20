--GENERAL REGISTER n-Bit (16 default)
library ieee;
use ieee.std_logic_1164.all;
entity One_Bit_Reg is 
port(
Clk : in std_logic;
Rst : in std_logic;
Enb : in std_logic;
D : in std_logic;
Q : out std_logic
);
end One_Bit_Reg;

architecture One_Bit_Reg_arch of One_Bit_Reg is
component DFF is port(
Clock, Enable, Clear, D : in std_logic;
Q: out std_logic);
end component;
begin

bit_0: DFF port map(Clk, Enb, Rst, D, Q);

end One_Bit_Reg_arch; 
