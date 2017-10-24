library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;



entity Monociclo is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC);
end Monociclo;

architecture Behavioral of Monociclo is

	COMPONENT regis
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		datain : IN std_logic_vector(31 downto 0);          
		dataout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT sumador32bits
	PORT(
		datainA : IN std_logic_vector(31 downto 0);
		datainB : IN std_logic_vector(31 downto 0);          
		Salida : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT InstruccionMemory
	PORT(
		address : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;          
		instruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT SEUdisp22
	PORT(
		disp22 : IN std_logic_vector(21 downto 0);          
		extdisp22 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT SEUdisp30
	PORT(
		disp30 : IN std_logic_vector(29 downto 0);          
		extdisp30 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;




signal aux_npcpc: std_logic_vector(31 downto 0);
signal aux_pc: std_logic_vector(31 downto 0);
signal aux_muxpc : std_logic_vector(31 downto 0);
signal aux_muxsumpc: std_logic_vector(31 downto 0);
signal aux_muxsumdisp22: std_logic_vector(31 downto 0);
signal aux_muxsumdisp30: std_logic_vector(31 downto 0);
signal aux_outseudips30: std_logic_vector(31 downto 0);
signal aux_outseudisp22: std_logic_vector(31 downto 0);
signal aux_instruction  : std_logic_vector(31 downto 0);
--signal aux_
--signal aux_
--signal aux_
--signal aux_
--signal aux_



begin

	Inst_SEUdisp30: SEUdisp30 PORT MAP(
		disp30 =>aux_instruction(29 downto 0) ,
		extdisp30 => aux_outseudips30
	);


	Inst_SEUdisp22: SEUdisp22 PORT MAP(
		disp22 => aux_instruction(21 downto 0),
		extdisp22 => aux_outseudisp22
	);

	Inst_InstruccionMemory: InstruccionMemory PORT MAP(
		address => aux_pc,
		rst =>RST ,
		instruction => aux_instruction
	);

	sumpc: sumador32bits PORT MAP(
		datainA => "00000000000000000000000000000001" ,
		datainB => aux_npcpc,
		Salida => aux_muxsumpc
	);
	
	
	sumdisp22: sumador32bits PORT MAP(
		datainA => aux_pc,
		datainB => aux_outseudisp22,
		Salida => aux_muxsumdisp22
	);
	
	sumdisp30: sumador32bits PORT MAP(
		datainA => aux_outseudips30,
		datainB => aux_pc ,
		Salida => aux_muxsumdisp30
	);
	
	
	npc: regis PORT MAP(
		clk => CLK,
		rst => RST,
		datain =>aux_muxpc ,
		dataout => aux_npcpc
	);
	
	pc: regis PORT MAP(
		clk => CLK,
		rst => RST,
		datain => aux_npcpc,
		dataout => aux_pc
	);


end Behavioral;

