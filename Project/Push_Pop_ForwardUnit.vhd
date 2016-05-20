library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


Entity Push_Pop_ForwardUnit is
port ( D_ExPushSig: in std_logic;
       E_MPushSig: in std_logic;
       M_WBPushSig: in std_logic;
       E_MPopSig: in std_logic;
       M_WBPopSig: in std_logic;
       D_ExPopSig: in std_logic;
       Mux: out std_logic_vector (2 downto 0)
      );
end entity Push_Pop_ForwardUnit;

architecture Push_Pop_Archi of Push_Pop_ForwardUnit is

begin

Mux <= "001" when ( ((D_ExPopSig = '1') and (E_MPushSig = '1') and (M_WBPopSig = '1')) or ((D_ExPushSig = '1') and (E_MPushSig = '0') and (E_MPopSig = '0') and (M_WBPopSig = '1')) or ((D_ExPopSig = '1') and (E_MPopSig = '1') and (M_WBPushSig = '1')) or ((D_ExPopSig = '1') and (E_MPopSig = '0') and (E_MPushSig = '0') and (M_WBPushSig = '0') and (M_WBPopSig = '0')) or ((D_ExPushSig = '1') and (E_MPopSig = '1') and (M_WBPushSig = '0') and (M_WBPopSig = '0')) or ((D_ExPushSig = '1') and (E_MPopSig = '0') and (E_MPushSig = '0') and (M_WBPopSig = '1')) ) else
       "010" when ( ((D_ExPushSig = '1') and (E_MPopSig = '1') and (M_WBPopSig = '1')) or ((D_ExPopSig = '1') and (E_MPopSig = '0') and (E_MPushSig = '1') and (M_WBPopSig = '1')) or ((D_ExPushSig = '1') and (E_MPopSig = '1') and (M_WBPopSig = '1')) or ((D_ExPopSig = '1') and (E_MPopSig = '1') and (M_WBPushSig = '0') and (M_WBPopSig = '0')) ) else
       "011" when ( (D_ExPopSig='1') and (E_MPopSig='1') and (M_WBPopSig='1') ) else
       "100" when ( ((D_ExPopSig='1') and (E_MPushSig='1') and (M_WBPushSig='1')) or ((D_ExPushSig='1') and (E_MPushSig='1') and (M_WBPushSig='0') and (M_WBPopSig='0')) or ((D_ExPushSig='1') and (E_MPushSig='0') and (E_MPopSig='0') and (M_WBPushSig='1')) ) else
       "101" when ( (D_ExPushSig='1') and (E_MPushSig='1') and (M_WBPushSig='1')) else
       "000";
end architecture Push_Pop_Archi;

