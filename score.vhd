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
    Port ( BPL : in  STD_LOGIC;
           BPreset : in  STD_LOGIC;
           BPV : in  STD_LOGIC;
			  CE_1ms : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           loc_unit : out  STD_LOGIC_VECTOR (3 downto 0);
           loc_dec : out  STD_LOGIC_VECTOR (3 downto 0);
           vis_unit : out  STD_LOGIC_VECTOR (3 downto 0);
           vis_dec : out  STD_LOGIC_VECTOR (3 downto 0));
end score;

architecture Behavioral of score is

	

component XOR_2b is
	 Port ( A : in  STD_LOGIC;
			  B : in  STD_LOGIC;
			  O : out  STD_LOGIC
			 );
end component;




component register_1b_E is
	 Port ( CE : in  STD_LOGIC;
			  D : in  STD_LOGIC;
			  clk : in  STD_LOGIC;
			  Q : out  STD_LOGIC
			 );
end component;




component counterDec_4b_RE is
	 Port ( 
			  CE : in  STD_LOGIC;
			  clk : in  STD_LOGIC;
			  R : in  STD_LOGIC;
			  TC : out  STD_LOGIC;
			  Q : out  STD_LOGIC_VECTOR (3 downto 0)
			 );

end component;


component register_1b is
	 Port ( D : in  STD_LOGIC;
			  clk : in  STD_LOGIC;
			  Q : out  STD_LOGIC
			 );
end component;

signal CE_LOC: std_logic := '0';
signal bpl_r: std_logic := '0';
signal bpv_f: std_logic := '0';
signal bpv_d: std_logic := '0';
signal bpl_f: std_logic := '0';
signal CE_VIS: std_logic := '0';
signal bpv_fr: std_logic := '0';
signal bpl_d: std_logic := '0';
signal bpv_r: std_logic := '0';
signal bpl_fr: std_logic := '0';
signal bpl_inc: std_logic := '0';
signal bpv_inc: std_logic := '0';

	
begin

bpv_inc <= '1' when (bpv_d = '1') and (bpv_fr = '1') else '0';
bpl_inc1: bpl_inc <= '1' when (bpl_d = '1') and (bpl_fr = '1') else '0';

u0: register_1b_E PORT MAP (
				CE => CE_1ms,
				clk => CLK,
				D => BPL,
				Q => bpl_r
			);


u1: register_1b_E PORT MAP (
				D => bpl_r,
				Q => bpl_d,
				CE => CE_1ms,
				clk => CLK
			);


u2: register_1b PORT MAP (
				clk => CLK,
				Q => bpl_f,
				D => bpl_d
			);


u3: XOR_2b PORT MAP (
				A => bpl_f,
				O => bpl_fr,
				B => bpl_d
			);




u5: register_1b_E PORT MAP (
				D => BPV,
				Q => bpv_r,
				clk => CLK,
				CE => CE_1ms
			);


u6: register_1b_E PORT MAP (
				clk => CLK,
				Q => bpv_d,
				CE => CE_1ms,
				D => bpv_r
			);


u7: register_1b PORT MAP (
				clk => CLK,
				D => bpv_d,
				Q => bpv_f
			);


u8: XOR_2b PORT MAP (
				A => bpv_f,
				B => bpv_d,
				O => bpv_fr
			);





u10: counterDec_4b_RE PORT MAP (
					clk => CLK,
					R => BPreset,
					CE => bpl_inc,
					TC => CE_LOC,
					Q => loc_unit
				);


u11: counterDec_4b_RE PORT MAP (
					clk => CLK,
					R => BPreset,
					CE => CE_LOC,
					TC => open,
					Q => loc_dec
				);


u12: counterDec_4b_RE PORT MAP (
					clk => CLK,
					R => BPreset,
					TC => CE_VIS,
					CE => bpv_inc,
					Q => vis_unit
				);


u13: counterDec_4b_RE PORT MAP (
					clk => CLK,
					R => BPreset,
					CE => CE_VIS,
					TC => open,
					Q => vis_dec
				);


end Behavioral;

