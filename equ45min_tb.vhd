--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:52:59 02/28/2022
-- Design Name:   
-- Module Name:   C:/CPE_USERS/TPELEC_3ETI/GR_C/Equipe_7/chronoscore_phase2/equ45min_tb.vhd
-- Project Name:  chronoscore_phase2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: equ45min
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
 
ENTITY equ45min_tb IS
END equ45min_tb;
 
ARCHITECTURE behavior OF equ45min_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT equ45min
    PORT(
         min_dec : IN  std_logic_vector(3 downto 0);
         min_unit : IN  std_logic_vector(3 downto 0);
         equ : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal min_dec : std_logic_vector(3 downto 0) := (others => '0');
   signal min_unit : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal equ : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: equ45min PORT MAP (
          min_dec => min_dec,
          min_unit => min_unit,
          equ => equ
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
-- 
--
--   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
			min_dec <= "0000";
			min_unit <= "0000";
			wait for 50 ns;
			min_dec <= "0100";
			wait for 50 ns;
			min_unit <= "0101";
      wait;
   end process;

END;
