library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
Entity syncram is
Generic (n : integer := 8);
port ( clk : in std_logic;
we : in std_logic;
re : in std_logic;
address : in std_logic_vector(n-1 downto 0);
datain : in std_logic_vector(15 downto 0);
dataout : out std_logic_vector(15 downto 0);
data0: out std_logic_vector(15 downto 0);
data1: out std_logic_vector(15 downto 0)
);
end entity syncram;

architecture syncrama of syncram is
type ram_type is array (0 to (2**n)-1) of std_logic_vector(15 downto 0);
signal ram : ram_type;
begin
process(clk) is
begin
if rising_edge(clk) then
    if we = '1' then
	ram(to_integer(unsigned(address))) <= datain;
  
    end if;
--elsif falling_edge(clk) then 
--    if re='1' then
--	dataout <= ram(to_integer(unsigned(address)));
--     end if;

end if;
dataout <= ram(to_integer(unsigned(address)));
data0 <= ram(0);
data1 <= ram(1);
end process;

end architecture syncrama;


