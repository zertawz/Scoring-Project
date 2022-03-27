--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:33:05 02/14/2022
-- Design Name:   
-- Module Name:   C:/CPE_USERS/TPELEC_3ETI/GR_C/EQUIPE_7/transcoder_7segs_tb.vhd
-- Project Name:  chronoscore_phase1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: transcoder_7segs
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
 
ENTITY transcoder_7segs_tb IS
END transcoder_7segs_tb;
 
ARCHITECTURE behavior OF transcoder_7segs_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT transcoder_7segs
    PORT(
         A : IN  std_logic_vector(3 downto 0);
         O : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal O : std_logic_vector(6 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   -- constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: transcoder_7segs PORT MAP (
          A => A,
          O => O
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
--   stim_proc: process
--   begin		
--      -- hold reset state for 100 ns.
--      wait for 100 ns;	
--
--      wait for <clock>_period*10;

      -- insert stimulus here 
		
		
		
      --wait;
   --end process;

A<= "0000" after 20ns, 
	 "0001" after 40ns,
	 "0010" after 60ns,
	 "0011" after 80ns,
	 "0100" after 100ns,
	 "0101" after 120ns,
	 "0110" after 140ns,
	 "0111" after 160ns,
	 "1000" after 180ns,
	 "1001" after 200ns,
	 "1010" after 220ns,
	 "1011" after 240ns,
	 "1100" after 260ns,
	 "1101" after 280ns,
	 "1110" after 300ns,
	 "1111" after 320ns;
END;
