--GENERAL REGISTER n-Bit (16 default)
library ieee;
use ieee.std_logic_1164.all;
entity General_Reg is 
Generic ( n : integer := 16);
port(
Clk : in std_logic;
Rst : in std_logic;
Enb : in std_logic;
D : in std_logic_vector((n-1) downto 0);
Q : out std_logic_vector((n-1) downto 0)
);
end General_Reg;

architecture General_Reg_arch of General_Reg is
component DFF is port(
Clock, Enable, Clear, D : in std_logic;
Q: out std_logic);
end component;

begin
loop1: for i in 0 to n-1 generate
bit_i: DFF port map(Clk, Enb, Rst, D(i), Q(i));
end generate;
end General_Reg_arch; 
