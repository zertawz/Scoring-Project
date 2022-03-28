--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:52:57 03/27/2022
-- Design Name:   
-- Module Name:   D:/CPE/2021-2022/ELN2/CHRONOSCORE/chronoscore_nexys_a7/testbench/sd_fsm_tb.vhd
-- Project Name:  chronoscore
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sd_fsm
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
USE ieee.numeric_std.ALL;
 
ENTITY sd_fsm_tb IS
END sd_fsm_tb;
 
ARCHITECTURE behavior OF sd_fsm_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sd_fsm
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         CE_1s : IN  std_logic;
         PB1 : IN  std_logic;
         PB2 : IN  std_logic;
         PB3 : IN  std_logic;
         PB4 : IN  std_logic;
         PBV : IN  std_logic;
         LSINC : OUT  std_logic;
         VSINC : OUT  std_logic;
         LRGB : OUT  std_logic_vector(2 downto 0);
         VRGB : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';
   signal CE_1s : std_logic := '0';
   signal PB1 : std_logic := '0';
   signal PB2 : std_logic := '0';
   signal PB3 : std_logic := '0';
   signal PB4 : std_logic := '0';
   signal PBV : std_logic := '0';

 	--Outputs
   signal LSINC : std_logic;
   signal VSINC : std_logic;
   signal LRGB : std_logic_vector(2 downto 0);
   signal VRGB : std_logic_vector(2 downto 0);
	
	--
	signal PB_SEQUENCE : std_logic_vector(4 downto 0);
	signal LOCAL_SEQUENCE : std_logic_vector(4 downto 0);
	signal VISITOR_SEQUENCE : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	constant CE_1s_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sd_fsm PORT MAP (
          rst => rst,
          clk => clk,
          CE_1s => CE_1s,
          PB1 => PB1,
          PB2 => PB2,
          PB3 => PB3,
          PB4 => PB4,
          PBV => PBV,
          LSINC => LSINC,
          VSINC => VSINC,
          LRGB => LRGB,
          VRGB => VRGB
        );
	--
	PBV <= PB_SEQUENCE(4);
	PB4 <= PB_SEQUENCE(3);
	PB3 <= PB_SEQUENCE(2);
	PB2 <= PB_SEQUENCE(1);
	PB1 <= PB_SEQUENCE(0);

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   -- Clock process definitions
   CE_1s_process :process
   begin
		CE_1s <= '0';
		wait for CE_1s_period - clk_period;
		CE_1s <= '1';
		wait for clk_period;
   end process;
	
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		-- insert stimulus here 
		
		rst <= '1';
      wait for clk_period*10;
		rst <= '0';
		
		-- Local Team Valid Sequence
		PB_SEQUENCE <= "00001";
		wait for clk_period*1;
		PB_SEQUENCE <= (others => '0');
		wait for CE_1s_period*5;
		PB_SEQUENCE <= "00010";
		wait for clk_period*1;
		PB_SEQUENCE <= (others => '0');
		wait for CE_1s_period*5;
		PB_SEQUENCE <= "00100";
		wait for clk_period*1;
		PB_SEQUENCE <= (others => '0');
		wait for CE_1s_period*5;
		PB_SEQUENCE <= "01000";
		wait for clk_period*1;
		PB_SEQUENCE <= (others => '0');
		wait for CE_1s_period*5;
		PB_SEQUENCE <= "10000";
		wait for clk_period*1;
		PB_SEQUENCE <= (others => '0');
		wait for CE_1s_period*5;
		
		wait for CE_1s_period*10;
		
		-- Visitor Team Valid Sequence
		PB_SEQUENCE <= "00100";
		wait for clk_period*1;
		PB_SEQUENCE <= (others => '0');
		wait for CE_1s_period*5;
		PB_SEQUENCE <= "01000";
		wait for clk_period*1;
		PB_SEQUENCE <= (others => '0');
		wait for CE_1s_period*5;
		PB_SEQUENCE <= "00001";
		wait for clk_period*1;
		PB_SEQUENCE <= (others => '0');
		wait for CE_1s_period*5;
		PB_SEQUENCE <= "00010";
		wait for clk_period*1;
		PB_SEQUENCE <= (others => '0');
		wait for CE_1s_period*5;
		PB_SEQUENCE <= "10000";
		wait for clk_period*1;
		PB_SEQUENCE <= (others => '0');
		wait for CE_1s_period*5;

		wait for CE_1s_period*10;
		
      -- Non Valid Sequences

      wait;
   end process;

END;
