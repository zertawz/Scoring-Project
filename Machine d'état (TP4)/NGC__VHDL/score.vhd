----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:31:09 03/05/2017 
-- Design Name: 
-- Module Name:    score - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity score is
    Port ( CLK 		: in  STD_LOGIC;
           CE_1ms 	: in  STD_LOGIC;       
			  CE_1s 		: in  STD_LOGIC;    
			  BPU 		: in  STD_LOGIC;
           BPR 		: in  STD_LOGIC;
			  BPD 		: in  STD_LOGIC;
           BPL 		: in  STD_LOGIC;
			  BPC 		: in  STD_LOGIC;
           BPreset 	: in  STD_LOGIC;
			  ------------------------------------------------------------			  
			  --LSINC 		: out  STD_LOGIC;
			  --VSINC 		: out  STD_LOGIC;
			  RGBL 		: out  STD_LOGIC_VECTOR (2 downto 0);
			  RGBR 		: out  STD_LOGIC_VECTOR (2 downto 0);
           OL_unit 	: out  STD_LOGIC_VECTOR (3 downto 0);
           OL_dec 	: out  STD_LOGIC_VECTOR (3 downto 0);
           vis_unit 	: out  STD_LOGIC_VECTOR (3 downto 0);
           vis_dec 	: out  STD_LOGIC_VECTOR (3 downto 0));
end score;

architecture Behavioral of score is

	COMPONENT pb_debouncer_1b
		 PORT ( clk : in  STD_LOGIC;
				  CE_1ms : in  STD_LOGIC;
				  PBin : in  STD_LOGIC;
				  PBout : out  STD_LOGIC);
	END COMPONENT;

	COMPONENT sd_fsm
		 PORT ( rst 	: in  STD_LOGIC;
				  --CLR 	: out  STD_LOGIC;
				  clk 	: in  STD_LOGIC;
				  CE_1s 	: in  STD_LOGIC;
				  PB1 	: in  STD_LOGIC;
				  PB2 	: in  STD_LOGIC;
				  PB3 	: in  STD_LOGIC;
				  PB4 	: in  STD_LOGIC;
				  PBV 	: in  STD_LOGIC;
				  ------------------------------------------------------------
				  LSINC 	: out  STD_LOGIC;
				  VSINC 	: out  STD_LOGIC;
				  LRGB 	: out  STD_LOGIC_VECTOR(2 downto 0);	-- Local RGB
				  VRGB 	: out  STD_LOGIC_VECTOR(2 downto 0)	-- Vesitor RGB
				  );
	END COMPONENT;

	COMPONENT register_1b
		 PORT ( D : in  STD_LOGIC;
				  clk : in  STD_LOGIC;
				  Q : out  STD_LOGIC);
	END COMPONENT;

	 COMPONENT counterDec_4b_RE
    PORT(
         R : IN  std_logic;
         CE : IN  std_logic;
         clk : IN  std_logic;
         Q : OUT  std_logic_vector(3 downto 0);
         TC : OUT  std_logic
        );
    END COMPONENT;
	 
signal bpu_int : STD_LOGIC;
signal bpr_int : STD_LOGIC;
signal bpd_int : STD_LOGIC;
signal bpl_int : STD_LOGIC;
signal bpc_int : STD_LOGIC;

signal lsinc_int, lsinc_reg, lsinc_int_re : STD_LOGIC;
signal vsinc_int, vsinc_reg, vsinc_int_re : STD_LOGIC;

signal CE_OL : STD_LOGIC;
signal CE_VIS : STD_LOGIC;

--CONSTANT N : INTEGER := 2;
--SIGNAL PBint, PBout : STD_LOGIC_VECTOR (N-1 downto 0) := (OTHERS => '0');

begin

	U0: pb_debouncer_1b
			 PORT MAP( 	clk 		=> CLK,
							CE_1ms 	=> CE_1ms,
							PBin 		=> BPU,
							PBout 	=> bpu_int);

	U1: pb_debouncer_1b
			 PORT MAP( 	clk 		=> CLK,
							CE_1ms 	=> CE_1ms,
							PBin 		=> BPR,
							PBout 	=> bpr_int);	
							
	U2: pb_debouncer_1b
			 PORT MAP( 	clk 		=> CLK,
							CE_1ms 	=> CE_1ms,
							PBin 		=> BPD,
							PBout 	=> bpd_int);
							
	U3: pb_debouncer_1b
			 PORT MAP( 	clk 		=> CLK,
							CE_1ms 	=> CE_1ms,
							PBin 		=> BPL,
							PBout 	=> bpl_int);							

	U4: pb_debouncer_1b
			 PORT MAP( 	clk 		=> CLK,
							CE_1ms 	=> CE_1ms,
							PBin 		=> BPC,
							PBout 	=> bpc_int);

	U5 : sd_fsm
		 PORT MAP ( rst 	=> BPreset, 
						--CLR 	=> CLR_int,
						clk 	=> CLK,
						CE_1s => CE_1s,
						PB1 	=> bpu_int,
						PB2 	=> bpr_int,
						PB3 	=> bpd_int,
						PB4 	=> bpl_int,
						PBV 	=> bpc_int,
						LSINC => lsinc_int,
						VSINC => vsinc_int,
						LRGB 	=> RGBL,
						VRGB 	=> RGBR);

	--LSINC <= lsinc_int;
	--VSINC <= vsinc_int;

	U6: register_1b PORT MAP (
          D => lsinc_int,
          clk => CLK,
          Q => lsinc_reg
        );

	U7: register_1b PORT MAP (
          D => vsinc_int,
          clk => CLK,
          Q => vsinc_reg
        );
		
	lsinc_int_re <= lsinc_reg AND (NOT lsinc_int);
	vsinc_int_re <= vsinc_reg AND (NOT vsinc_int);
							
	U10: counterDec_4b_RE PORT MAP (
          R => BPreset,
          CE => lsinc_int_re,
          clk => CLK,
          Q => OL_unit,
          TC => CE_OL
        );
	
	U11: counterDec_4b_RE PORT MAP (
          R => BPreset,
          CE => CE_OL,
          clk => CLK,
          Q => OL_dec,
          TC => open
        );
	
	U12: counterDec_4b_RE PORT MAP (
          R => BPreset,
          CE => vsinc_int_re,
          clk => CLK,
          Q => vis_unit,
          TC => CE_VIS
        );
	
	U13: counterDec_4b_RE PORT MAP (
          R => BPreset,
          CE => CE_VIS,
          clk => CLK,
          Q => vis_dec,
          TC => open
        );
end Behavioral;

