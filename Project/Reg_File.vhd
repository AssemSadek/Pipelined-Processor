-- 7x16 General_Reg 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Reg_File is 
port(
Clk : in std_logic;
WB : in std_logic; 					--Write Back enable Signal 
Ra_Selc: in std_logic_vector(2 downto 0);		--Ra Selector 
Rb_Selc: in std_logic_vector(2 downto 0);		--Rb Selector
Ra_Data : out std_logic_vector(15 downto 0);		--Ra Output Data
Rb_Data : out std_logic_vector(15 downto 0);		--Rb Output Data
Write_Data : in std_logic_vector(15 downto 0);		--Write Data (Data to be Written) 
Write_Reg_Selc : in std_logic_vector(2 downto 0);	--Reg to be written Selector
Reset : in std_logic;

 
push_sig : in std_logic;				--Push Signal
pop_sig : in std_logic;	

--Not yet Handled				--Pop Signal
flags_i: in std_logic_vector(3 downto 0);			--FLAGS
flags_o: out std_logic_vector(3 downto 0)			--FLAGS 
);
end Reg_File;

architecture Reg_File_arch of Reg_File is
component General_Reg is  --THE GENERAL REGISTER 
Generic ( n : integer := 16);
port(
Clk : in std_logic;
Enb : in std_logic;
Rst : in std_logic;
D : in std_logic_vector((n-1) downto 0);
Q : out std_logic_vector((n-1) downto 0));
end component;

--This Decoder accepts the WB signal as its Enable
--IF WB=1 => The Decoder Decodes the (Write_Reg_Selc) and Enables the Selected Register to be written at.
component DEC_3TO8 is port( 
Enable : in std_logic;
Input : in std_logic_vector(2 downto 0);
Output : out std_logic_vector(7 downto 0));
end component;

--The Mux's are connected to the output BUS 
--One for Ra output and another One for Rb Output
--All General_Regs Signals thier output to the MUX's
--Ra_Selc and Rb_Selc determins which Regs will be able to place data to the Output BUS.

signal RaMux_O, RbMux_O : std_logic_vector(15 downto 0); --Ra,Rb Multiplixers Output.
signal R0_Q, R1_Q, R2_Q, R3_Q, R4_Q, R5_Q, R6_Q, R7_Q : std_logic_vector(15 downto 0); --Registers Output Signals.
signal DEC_Output: std_logic_vector(7 downto 0); --Decoder Output.
signal WB_Signal, Reset_Signal: std_logic;
signal Write_Reg_Selc_Signal: std_logic_vector(2 downto 0); 
signal Write_Data_Signal: std_logic_vector(15 downto 0);
signal Write_Data_Signal_SP: std_logic_vector(15 downto 0);
signal SP_Dec: std_logic;

begin
-- Initializing SP with 255


WB_Signal <= (Reset or WB);

Write_Reg_Selc_Signal <= Write_Reg_Selc;

Write_Data_Signal <= "0000000000000000" when Reset = '1' else
                      Write_Data;

Write_Data_Signal_SP <= "0000000011111111" when Reset = '1' else
			Write_Data when (WB='1' and Write_Reg_Selc="111") else
                      std_logic_vector(unsigned(R7_Q)-1) when push_sig = '1' else
                      std_logic_vector(unsigned(R7_Q)+1);

SP_DEC <= (Reset or push_sig or pop_sig);

--Reset_Signal <= '0' when Reset = '1' else
--                Reset;




R0: General_Reg port map(Clk, DEC_Output(0), Reset, Write_Data_Signal, R0_Q);
R1: General_Reg port map(Clk, DEC_Output(1), Reset, Write_Data_Signal, R1_Q);
R2: General_Reg port map(Clk, DEC_Output(2), Reset, Write_Data_Signal, R2_Q);
R3: General_Reg port map(Clk, DEC_Output(3), Reset, Write_Data_Signal, R3_Q);
R4: General_Reg port map(Clk, DEC_Output(4), Reset, Write_Data_Signal, R4_Q);
R5: General_Reg port map(Clk, DEC_Output(5), Reset, Write_Data_Signal, R5_Q);
R6: General_Reg port map(Clk, DEC_Output(6), Reset, Write_Data_Signal, R6_Q);
R7: General_Reg port map(Clk, SP_DEC, '0', Write_Data_Signal_SP, R7_Q); --Acts as SP (needs furthur adjustments).

CCR: General_Reg generic map (n=>4) port map(Clk,'1',Reset,flags_i,flags_o);

R_AxIn_DEC: DEC_3TO8 port map(WB_Signal, Write_Reg_Selc_Signal, DEC_Output);

Ra_Data <= R0_Q when Ra_Selc="000" else
	   R1_Q when Ra_Selc="001" else
	   R2_Q when Ra_Selc="010" else
	   R3_Q when Ra_Selc="011" else
	   R4_Q when Ra_Selc="100" else
	   R5_Q when Ra_Selc="101" else
	   R6_Q when Ra_Selc="110" else
	   R7_Q;

Rb_Data <= R0_Q when Rb_Selc="000" else
	   R1_Q when Rb_Selc="001" else
	   R2_Q when Rb_Selc="010" else
	   R3_Q when Rb_Selc="011" else
	   R4_Q when Rb_Selc="100" else
	   R5_Q when Rb_Selc="101" else
	   R6_Q when Rb_Selc="110" else
	   R7_Q;



--Still Missing:
--CCR Reg.
--Push and Pop Signals handlers.

end Reg_File_arch; 