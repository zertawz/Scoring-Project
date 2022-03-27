--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:47:59 03/14/2022
-- Design Name:   
-- Module Name:   C:/CPE_users/TPELEC_3ETI/GR_C/ELN2/SCORING/EQUIPE_7/chronoscore_phase1/score_tb.vhd
-- Project Name:  chronoscore_phase1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: score
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY score_tb IS
END score_tb;
 
ARCHITECTURE behavior OF score_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT score
    PORT(
         CE_1ms : IN  std_logic;
         CLK : IN  std_logic;
         BPL : IN  std_logic;
         BPreset : IN  std_logic;
         BPV : IN  std_logic;
         loc_unit : OUT  std_logic_vector(3 downto 0);
         loc_dec : OUT  std_logic_vector(3 downto 0);
         vis_unit : OUT  std_logic_vector(3 downto 0);
         vis_dec : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CE_1ms : std_logic := '0';
   signal CLK : std_logic := '0';
   signal BPL : std_logic := '0';
   signal BPreset : std_logic := '0';
   signal BPV : std_logic := '0';

 	--Outputs
   signal loc_unit : std_logic_vector(3 downto 0);
   signal loc_dec : std_logic_vector(3 downto 0);
   signal vis_unit : std_logic_vector(3 downto 0);
   signal vis_dec : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: score PORT MAP (
          CE_1ms => CE_1ms,
          CLK => CLK,
          BPL => BPL,
          BPreset => BPreset,
          BPV => BPV,
          loc_unit => loc_unit,
          loc_dec => loc_dec,
          vis_unit => vis_unit,
          vis_dec => vis_dec
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
	
	CE_1ms_process :process
	begin
		CE_1ms <= '0';
		wait for 90 ns;
		CE_1ms <= '1';
		wait for 10 ns;
	end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		wait for CLK_period*10;	
		BPreset <= '0';
		BPL <= '0', '1' after 20 ns;  --bouton poussoir score équipe locale
		BPV <= '0', '1' after 50 ns; --bouton poussoir score équipe visiteur
      

      -- insert stimulus here 

      wait;
   end process;

END;
