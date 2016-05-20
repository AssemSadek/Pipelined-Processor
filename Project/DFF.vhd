library ieee;
use ieee.std_logic_1164.all;
entity DFF is port(
Clock, Enable, Clear, D : in std_logic;
Q: out std_logic);
end DFF;
architecture DFF_Arch of DFF is
begin
Process(Clock)
begin
if (Clock'EVENT and Clock = '0' ) then
	if (Clear = '1') then
		Q <= '0'; 	
        elsif (Enable = '1') then
		Q <= D;
	end if;
end if;

end Process;
end DFF_Arch;