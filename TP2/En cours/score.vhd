----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:49:17 02/25/2022 
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
    Port ( CE_1ms : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           BPL : in  STD_LOGIC;
           BPreset : in  STD_LOGIC;
           BPV : in  STD_LOGIC;
           loc_unit : out  STD_LOGIC_VECTOR (3 downto 0);
           loc_dec : out  STD_LOGIC_VECTOR (3 downto 0);
           vis_unit : out  STD_LOGIC_VECTOR (3 downto 0);
           vis_dec : out  STD_LOGIC_VECTOR (3 downto 0));
end score;

architecture Behavioral of score is

	component register_1b is
		 Port ( D : in  STD_LOGIC;
				  clk : in  STD_LOGIC;
				  Q : out  STD_LOGIC);
	end component;

	component register_1b_E is
		 Port ( CE : in  STD_LOGIC;
				  D : in  STD_LOGIC;
				  clk : in  STD_LOGIC;
				  Q : out  STD_LOGIC);
	end component;

	component counterDec_4b_RE is
		 Port ( R : in  STD_LOGIC;
				  CE : in  STD_LOGIC;
				  clk : in  STD_LOGIC;
				  Q : out  STD_LOGIC_VECTOR (3 downto 0);
				  TC : out  STD_LOGIC);
	end component;

	component XOR_2b is
		 Port ( A : in  STD_LOGIC;
				  B : in  STD_LOGIC;
				  O : out  STD_LOGIC);
	end component;

	-- SIGNAUX INTERNES
	
	signal bpl_r: std_logic := '0';
	signal bpl_d: std_logic := '0';
	signal bpl_f: std_logic := '0';
	signal bpl_fr: std_logic := '0';
	signal bpv_r: std_logic := '0';
	signal bpv_d: std_logic := '0';
	signal bpv_f: std_logic := '0';
	signal bpv_fr: std_logic := '0';
	signal bpl_inc: std_logic := '0';
	signal bpv_inc: std_logic := '0';
	signal CE_LOC: std_logic := '0';
	signal CE_VIS: std_logic := '0';
	
begin

	-- COMPOSANTS

	u0: register_1b_E port map (CE => CE_1ms, clk => CLK, D => BPL, Q => bpl_r);
	u1: register_1b_E port map (CE => CE_1ms, clk => CLK, D => bpl_r, Q => bpl_d);
	u2: register_1b port map (clk => CLK, D => bpl_d, Q => bpl_f);
	u3: XOR_2b port map (A => bpl_f, B => bpl_d, O => bpl_fr);
	-- bpl_inc1 : and2
	bpl_inc1: bpl_inc <= '1' when (bpl_d = '1') and (bpl_fr = '1') else '0';
	
	u5: register_1b_E port map (CE => CE_1ms, clk => CLK, D => BPV, Q => bpv_r);
	u6: register_1b_E port map (CE => CE_1ms, clk => CLK, D => bpv_r, Q => bpv_d);
	u7: register_1b port map (clk => CLK, D => bpv_d, Q => bpv_f);
	u8: XOR_2b port map (A => bpv_f, B => bpv_d, O => bpv_fr);
	-- bpv_inc1 : and2
	bpv_inc <= '1' when (bpv_d = '1') and (bpv_fr = '1') else '0';
	
	u10: counterDec_4b_RE port map (R => BPreset ,CE => bpl_inc ,clk => CLK,Q => loc_unit,TC => CE_LOC);
	u11: counterDec_4b_RE port map (R => BPreset ,CE => CE_LOC ,clk => CLK,Q => loc_dec,TC => open);
	u12: counterDec_4b_RE port map (R => BPreset ,CE => bpv_inc ,clk => CLK,Q => vis_unit,TC => CE_VIS);
	u13: counterDec_4b_RE port map (R => BPreset ,CE => CE_VIS ,clk => CLK,Q => vis_dec,TC => open);

end Behavioral;

