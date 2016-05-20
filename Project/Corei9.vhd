library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

Entity Corei9 is

port( Clk: in std_logic;
      Reset: in std_logic;
      InPort: in std_logic_vector(15 downto 0);
      OutPort: out std_logic_vector(15 downto 0);
      Interrupt: in std_logic
);
       
end entity Corei9;

architecture Corei9_function of Corei9 is

----------------------------------------COMPONENTS------------------------

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

component syncram is
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
end component;

component ControlUnit is

port ( InstCode : in std_logic_vector(4 downto 0);
       WBSig: out std_logic;
       MRSig: out std_logic;
       MWSig: out std_logic;
       JZSig : out std_logic;
       JNSig : out std_logic;
       JCSig : out std_logic;
       JmpSig : out std_logic;
       CallSig : out std_logic;
       PushSig: out std_logic;
       PopSig: out std_logic;
       RETSig: out std_logic;
       InSig: out std_logic;
       OutSig: out std_logic;
       ExecuteSig: out std_logic_vector(1 downto 0);
       Selectors: out std_logic_vector(3 downto 0);
       F_D_Flush: out std_logic;
       Interrupt_Signal: in std_logic;
       RETISig: out std_logic
       );
       
end component;

component ForwardUnit is

port ( M_WRg: in std_logic_vector(2 downto 0);
       E_MRg: in std_logic_vector(2 downto 0);
       D_ERgA: in std_logic_vector(2 downto 0);
       D_ERgB: in std_logic_vector(2 downto 0);
       M_WWB: in std_logic;
       E_MWB: in std_logic;
       DecMuxA: out std_logic_vector(1 downto 0);
       DecMuxB: out std_logic_vector(1 downto 0)
       );
       
end component;

component BranchUnit is
port ( 
       Flags: in std_logic_vector(3 downto 0);
       JZSig : in std_logic;
       JNSig : in std_logic;
       JCSig : in std_logic;
       JmpSig : in std_logic;
       CallSig : in std_logic;
       RETSig: in std_logic;
       DecsSig: out std_logic
       );
       
end component;

component ALU is 
	port(
	A: in std_logic_vector(15 downto 0);
	B: in std_logic_vector(15 downto 0);
	Cin: in std_logic;
	S3210: in std_logic_vector(3 downto 0);
	Flags_i: in std_logic_vector(3 downto 0);
	F: out std_logic_vector(15 downto 0);
	Flags: out std_logic_vector(3 downto 0)
	);
end component;

component FD_Reg is 
Generic ( n : integer := 16);
port(
Clk : in std_logic;
Rst : in std_logic;
Enb : in std_logic;
inst_i : in std_logic_vector(15 downto 0);
inst_o : out std_logic_vector(15 downto 0);
PC_i : in std_logic_vector(15 downto 0);
PC_O : out std_logic_vector(15 downto 0)
);
end component;

component DEx_Reg is 
Generic ( n : integer := 16);
port(
Clk : in std_logic;
Rst : in std_logic;
Enb : in std_logic;

InSignal_i: in std_logic;
OutSignal_i: in std_logic;
RetSignal_i: in std_logic;
PC_i: in std_logic_vector(15 downto 0);
ExSelect_i: in std_logic_vector(1 downto 0);
MemRead_i: in std_logic;
MemWrite_i: in std_logic;
WB_i: in std_logic;
Ra_i: in std_logic_vector(2 downto 0);
Rb_i: in std_logic_vector(2 downto 0);
Vra_i: in std_logic_vector(15 downto 0);
Vrb_i: in std_logic_vector(15 downto 0);
PopSignal_i: in std_logic;
PushSignal_i: in std_logic;
Immediate_i: in std_logic_vector(7 downto 0);
Flags_i: in std_logic_vector(3 downto 0);
Selectors_i: in std_logic_vector(3 downto 0);
CallSig_i: in std_logic;
JZSig_i : in std_logic;
JNSig_i : in std_logic;
JCSig_i : in std_logic;
JmpSig_i : in std_logic;
IntSig_i : in std_logic;
InSignal_o: out std_logic;
OutSignal_o: out std_logic;
RetSignal_o: out std_logic;
PC_o: out std_logic_vector(15 downto 0);
ExSelect_o: out std_logic_vector(1 downto 0);
MemRead_o: out std_logic;
MemWrite_o: out std_logic;
WB_o: out std_logic;
Ra_o: out std_logic_vector(2 downto 0);
Rb_o: out std_logic_vector(2 downto 0);
Vra_o: out std_logic_vector(15 downto 0);
Vrb_o: out std_logic_vector(15 downto 0);
PopSignal_o: out std_logic;
PushSignal_o: out std_logic;
Immediate_o: out std_logic_vector(7 downto 0);
Flags_o: out std_logic_vector(3 downto 0);
Selectors_o: out std_logic_vector(3 downto 0);
CallSig_o: out std_logic;
JZSig_o : out std_logic;
JNSig_o : out std_logic;
JCSig_o : out std_logic;
JmpSig_o : out std_logic;
IntSig_o : out std_logic;
RetiSig_i : in std_logic;
RetiSig_o : out std_logic
);
end component;

component ExM_Reg is 
Generic ( n : integer := 16);
port(
Clk : in std_logic;
Rst : in std_logic;
Enb : in std_logic;

InSignal_i: in std_logic;
OutSignal_i: in std_logic;
RetSignal_i: in std_logic;
MemRead_i: in std_logic;
MemWrite_i: in std_logic;
WB_i: in std_logic;
Ra_i: in std_logic_vector(2 downto 0);
Vra_i: in std_logic_vector(15 downto 0);
Result_i: in std_logic_vector(15 downto 0);
PopSignal_i: in std_logic;
PushSignal_i: in std_logic;

InSignal_o: out std_logic;
OutSignal_o: out std_logic;
RetSignal_o: out std_logic;
MemRead_o: out std_logic;
MemWrite_o: out std_logic;
WB_o: out std_logic;
Ra_o: out std_logic_vector(2 downto 0);
Vra_o: out std_logic_vector(15 downto 0);
Result_o: out std_logic_vector(15 downto 0);
PopSignal_o: out std_logic;
PushSignal_o: out std_logic;
RetiSig_i : in std_logic;
RetiSig_o : out std_logic;
InterruptSig_i : in std_logic;
InterruptSig_o : out std_logic
);
end component;

component MWB_Reg is 
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
end component;

component Reg_File is 
port(
Clk : in std_logic;
WB : in std_logic; 					--Write Back enable Signal 
Ra_Selc: in std_logic_vector(2 downto 0);		--Ra Selector 
Rb_Selc: in std_logic_vector(2 downto 0);		--Rb Selector
Ra_Data : out std_logic_vector(15 downto 0);		--Ra Output Data
Rb_Data : out std_logic_vector(15 downto 0);		--Rb Output Data
Write_Data : in std_logic_vector(15 downto 0);		--Write Data (Data to be Written) 
Write_Reg_Selc : in std_logic_vector(2 downto 0);	--Reg to be written Selector
Reset: in std_logic;

--Not yet Handled 
push_sig : in std_logic;				--Push Signal
pop_sig : in std_logic;					--Pop Signal
flags_i: in std_logic_vector(3 downto 0);			--FLAGS
flags_o: out std_logic_vector(3 downto 0)			--FLAGS 
);
end component;

component Push_Pop_ForwardUnit is
port ( D_ExPushSig: in std_logic;
       E_MPushSig: in std_logic;
       M_WBPushSig: in std_logic;
       E_MPopSig: in std_logic;
       M_WBPopSig: in std_logic;
       D_ExPopSig: in std_logic;
       Mux: out std_logic_vector (2 downto 0)
      );
end component;

------------------------------SIGNALS--------------------------------------------------
--Inverse Clock
SIGNAL ClkInv: std_logic;
--PC Values
--SIGNAL PC_Jump: std_logic_vector ( 15 downto 0);
SIGNAL PC_i ,PC_o, PC_Jump: std_logic_vector ( 15 downto 0);
SIGNAL Memory_Final_Data: std_logic_vector ( 15 downto 0);

-- PC Control Signals
SIGNAL BU_Control: std_logic;

--Original 
SIGNAL InstOut: std_logic_vector (15 downto 0);

--Control Unit Signals 
SIGNAL CU_WBSig, CU_MRsig,CU_MWSig,CU_JZSig,CU_JNSig,CU_JCSig,CU_JmpSig,CU_CallSig,CU_PushSig,CU_PopSig,CU_RETSig,CU_InSig,CU_OutSig,CU_F_D_Flush,CU_RETISig: std_logic;
SIGNAL CU_ExecuteSig: std_logic_vector(1 downto 0);                 
SIGNAL CU_Selectors: std_logic_vector(3 downto 0);

-- Fetching Decoding Buffer Signals 
SIGNAL F_D_Flush: std_logic;                                           
SIGNAL F_D_InstCode,F_D_PC,F_D_PC_inc: std_logic_vector (15 downto 0);
SIGNAL F_D_rbSelect: std_logic_vector(2 downto 0);
SIGNAL F_D_Immediate: std_logic_vector(7 downto 0); 

--Registers File Signals
SIGNAL RF_Vra,RF_Vrb: std_logic_vector (15 downto 0);
SIGNAL RF_Flags: std_logic_vector ( 3 downto 0);



--Encoding/Decoding Buffer Signals
SIGNAL D_E_Flush: std_logic;
SIGNAL D_E_InSignal,D_E_OutSignal,D_E_RetSignal: std_logic;
SIGNAL D_E_PC: std_logic_vector(15 downto 0);
SIGNAL D_E_ExSelect: std_logic_vector(1 downto 0);
SIGNAL D_E_MemRead,D_E_MemWrite,D_E_WB: std_logic;
SIGNAL D_E_Ra,D_E_Rb: std_logic_vector(2 downto 0);
SIGNAL D_E_Vra,D_E_Vrb: std_logic_vector(15 downto 0);
SIGNAL D_E_PopSignal,D_E_PushSignal:  std_logic;
SIGNAL D_E_Immediate: std_logic_vector(7 downto 0);
SIGNAL D_E_Flags,D_E_Selectors: std_logic_vector(3 downto 0);
SIGNAL D_E_CallSig: std_logic;
SIGNAL D_E_JZSig,D_E_JNSig,D_E_JCSig,D_E_JmpSig,D_E_Interrupt,D_E_RETISig: std_logic;

--Executing Signals
SIGNAL ALU_A,ALU_B,ALU_F: std_logic_vector(15 downto 0);
SIGNAL ALU_Flags: std_logic_vector(3 downto 0);
SIGNAL Execute_Result: std_logic_vector (15 downto 0);
SIGNAL Execute_Vra: std_logic_vector (15 downto 0);
SIGNAL Execute_Vra_temp: std_logic_vector (15 downto 0);
SIGNAL Execute_Flags: std_logic_vector(3 downto 0);
SIGNAL Execute_Flags_temp: std_logic_vector(3 downto 0);
SIGNAL Execute_Immidiate: std_logic_vector (7 downto 0);
SIGNAL Execute_Immidiate_temp: std_logic_vector (7 downto 0);

--Executing/Memory Buffer Signals
SIGNAL E_M_Flush: std_logic;
SIGNAL E_M_InSignal,E_M_OutSignal, E_M_RetSignal,E_M_MemRead,E_M_MemWrite,E_M_WB: std_logic;
SIGNAL E_M_Ra: std_logic_vector(2 downto 0);
SIGNAL E_M_Vra,E_M_Result: std_logic_vector(15 downto 0);
SIGNAL E_M_PopSignal, E_M_PushSignal,E_M_RETISig,E_M_Interrupt: std_logic;

--Data Memory Signals
SIGNAL DM_DataOut: std_logic_vector(15 downto 0);
SIGNAL Memory_Data: std_logic_vector(15 downto 0);


SIGNAL Inst0,Inst1,Data0,Data1: std_logic_vector(15 downto 0);


SIGNAL Execute_Result_temp : std_logic_vector(15 downto 0);


--Memory/Write Back Buffer Signals
SIGNAL M_WB_Flush: std_logic;
SIGNAL M_WB_InSignal,M_WB_WB: std_logic;
SIGNAL M_WB_Ra: std_logic_vector(2 downto 0);
SIGNAL M_WB_Data: std_logic_vector(15 downto 0);
SIGNAL M_WB_PopSignal, M_WB_PushSignal,M_WB_RetSignal,M_WB_RETISig: std_logic;


--Forwarding Unit Signals
SIGNAL FU_DecMuxA,FU_DecMuxB: std_logic_vector (1 downto 0);

-- Push/Pop Unit Signals
SIGNAL PushPop_FU_Mux: std_logic_vector (2 downto 0);
SIGNAL FR_Flags_o: std_logic_vector (3 downto 0);


---test
--signal Q1,Q2: std_logic_vector ( 15 downto 0);
--------------------------------------------LOGIC------------------------------------------
begin

--PC Register--
PC : General_Reg generic map (n=>16) port map(Clk,'0','1',PC_i,PC_o);
----Flags Register
FR: General_Reg generic map (n=>4) port map(Clk,Reset,Interrupt,RF_Flags,FR_Flags_o);

Process(Clk,Reset,PC_i,PC_o)
begin
if(Reset='1') then
    PC_i <= Data0;
elsif (rising_edge(Clk)) then
    if(M_WB_RetSignal='1') then
        PC_i <= Memory_Final_Data;
	--PC_i <= "10101010101010";
    else
	if(CU_F_D_Flush='1') then
            PC_i <= PC_o;
	elsif(BU_Control='1') then
            PC_i <= PC_Jump;
        else
            PC_i <= PC_o+"0000000000000001";
        end if;    
    end if;
end if;

end Process;

Memory_Final_Data <= M_WB_Data;


--Multiplexers
F_D_Immediate <= F_D_InstCode(7 downto 0) when (CU_PopSig='0' and CU_PushSig='0') else
		 --RF_Vrb(7 downto 0)+"00000001" when (CU_PopSig='1' and CU_PushSig='0')else
		 RF_Vrb(7 downto 0);

ALU_A<= M_WB_Data  when FU_DecMuxA="10" else
        E_M_Result when FU_DecMuxA="01" else
        D_E_Vra ;

ALU_B<= M_WB_Data  when FU_DecMuxB="10" else
        E_M_Result when FU_DecMuxB="01" else
        D_E_Vrb ;

Execute_Result_temp<=ALU_B when D_E_ExSelect="00" else --MOV
		     ALU_F when D_E_ExSelect="01" else
		     "00000000" & Execute_Immidiate;
Execute_Result <= InPort when D_E_InSignal='1' else
		  Execute_Result_temp;


Execute_Vra_temp <= ALU_A when D_E_CallSig='0' else
	       D_E_PC;

Execute_Vra <= std_logic_vector(unsigned(Execute_Vra_temp)-1) when D_E_Interrupt='1' else
			   Execute_Vra_temp;

Execute_Flags_temp <= ALU_Flags when D_E_ExSelect="01" else
	              D_E_Flags;

Execute_Flags <= FR_Flags_o when M_WB_RETISig='1' else
		 Execute_Flags_temp;

Memory_Data <= DM_DataOut when E_M_MemRead='1' else
	       E_M_Result;



--Fetching
InstMemory: syncram port map (Clk,'0','1',PC_o(7 downto 0),"0000000000000000",InstOut,Inst0,Inst1);

--Fetching/Decoding Buffer
F_D_buffer: FD_Reg port map (Clk,F_D_Flush,'1',InstOut,F_D_InstCode,PC_o,F_D_PC);

F_D_PC_inc <= std_logic_vector(unsigned(F_D_PC)+1);

F_D_rbSelect <= "111" when (CU_CallSig='1' or CU_RETSig='1' or CU_PushSig='1' or CU_PopSig='1') else
		F_D_InstCode(7 downto 5);

--Registers File
RGFL: Reg_File port map (ClkInv,M_WB_WB,F_D_InstCode(10 downto 8),F_D_rbSelect,RF_Vra,RF_Vrb,M_WB_Data,M_WB_Ra,Reset,M_WB_PushSignal,M_WB_PopSignal,Execute_Flags,RF_Flags);




--Decoding/Control Unit
CntUnit: ControlUnit port map (F_D_InstCode(15 downto 11),CU_WBSig, CU_MRsig,CU_MWSig,CU_JZSig,CU_JNSig,CU_JCSig,CU_JmpSig,CU_CallSig,CU_PushSig,CU_PopSig,CU_RETSig,CU_InSig,CU_OutSig,
CU_ExecuteSig,CU_Selectors,CU_F_D_Flush,Interrupt,CU_RETISig);



--Decoding/Executing Buffer
D_E_buffer: DEx_Reg port map (Clk,D_E_Flush,'1',CU_InSig,CU_OutSig,CU_RetSig,F_D_PC_inc,CU_ExecuteSig,CU_MRSig,CU_MWSig,CU_WBSig,F_D_InstCode(10 downto 8),F_D_InstCode(7 downto 5),RF_VrA,RF_Vrb,CU_PopSig,CU_PushSig,F_D_Immediate,RF_Flags,CU_Selectors,CU_CallSig,CU_JZSig,CU_JNSig,CU_JCSig,CU_JmpSig,Interrupt,D_E_InSignal,D_E_OutSignal,D_E_RetSignal,D_E_PC,D_E_ExSelect,D_E_MemRead,D_E_MemWrite,D_E_WB,D_E_Ra,D_E_Rb,D_E_Vra,D_E_Vrb,D_E_PopSignal,D_E_PushSignal,D_E_Immediate,D_E_Flags,D_E_Selectors,D_E_CallSig,D_E_JZSig,D_E_JNSig,D_E_JCSig,D_E_JmpSig,D_E_Interrupt,CU_RETISig,D_E_RETISig);

--Executing
ALU1: ALU port map (ALU_A,ALU_B,D_E_Flags(2),D_E_Selectors,D_E_Flags,ALU_F,ALU_Flags);

--Executing/Data Memory Buffer
E_M_buffer: ExM_Reg port map (Clk,E_M_Flush,'1',D_E_InSignal,D_E_OutSignal,D_E_RetSignal,D_E_MemRead,D_E_MemWrite,D_E_WB,D_E_Ra,Execute_Vra,Execute_Result,D_E_PopSignal,D_E_PushSignal,E_M_InSignal,E_M_OutSignal,E_M_RetSignal,E_M_MemRead,E_M_MemWrite,E_M_WB,E_M_Ra,E_M_Vra,E_M_Result,E_M_PopSignal, E_M_PushSignal,D_E_RETISig,E_M_RETISig,D_E_Interrupt,E_M_Interrupt);

--Data Memory
DataMemory: syncram port map (Clk,E_M_MemWrite,E_M_MemRead,E_M_Result(7 downto 0),E_M_Vra,DM_DataOut,Data0,Data1);

--Data Memory/WB Buffer
M_WB_buffer: MWB_Reg port map (Clk,M_WB_Flush,'1',E_M_Insignal,E_M_WB,E_M_Ra,Memory_Data,E_M_PopSignal,E_M_PushSignal,E_M_RetSignal,M_WB_InSignal,M_WB_WB,M_WB_Ra,M_WB_Data,M_WB_PopSignal,M_WB_PushSignal,M_WB_RetSignal,E_M_RETISig,M_WB_RETISig);

--Data Hazards ( Forwarding Unit )
FU: ForwardUnit port map (M_WB_Ra,E_M_Ra,D_E_Ra,D_E_Rb,M_WB_WB,E_M_WB,FU_DecMuxA,FU_DecMuxB);

-- Push/Pop Hazards
PushPop_FU: Push_Pop_ForwardUnit port map (D_E_PushSignal,E_M_PushSignal,M_WB_PushSignal,E_M_PopSignal,M_WB_PopSignal,D_E_PopSignal,PushPop_FU_Mux);


Execute_Immidiate <=  D_E_Immediate when PushPop_FU_Mux = "000" else
                      std_logic_vector(unsigned(D_E_Immediate)+1) when PushPop_FU_Mux = "001" else
                      std_logic_vector(unsigned(D_E_Immediate)+2) when PushPop_FU_Mux = "010" else
                      std_logic_vector(unsigned(D_E_Immediate)+3) when PushPop_FU_Mux = "011" else
                      std_logic_vector(unsigned(D_E_Immediate)-1) when PushPop_FU_Mux = "100" else
                      std_logic_vector(unsigned(D_E_Immediate)-2);



--Control Hazards
 
--Branching
BU: BranchUnit port map (D_E_Flags,D_E_JZSig,D_E_JNSig,D_E_JCSig,D_E_JmpSig,D_E_CallSig,D_E_RetSignal,BU_Control);
PC_Jump <= Data1 when D_E_Interrupt='1' else
	   ALU_A;

-- Flush Signals --
F_D_Flush <= Reset or CU_F_D_Flush or BU_Control or M_WB_RetSignal or D_E_Interrupt;
D_E_Flush <= Reset or BU_Control or M_WB_RetSignal;
E_M_Flush <= Reset or M_WB_RetSignal;
M_WB_Flush <= Reset;

-- Inverse Clock
ClkInv <= not Clk;


--Out Instruction
OutPort <= ALU_A when D_E_OutSignal='1' else
	   "1111111111111111";

end architecture Corei9_function;

