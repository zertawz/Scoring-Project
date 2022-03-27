--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:34:03 03/14/2022
-- Design Name:   
-- Module Name:   C:/CPE_users/TPELEC_3ETI/GR_C/ELN2/SCORING/EQUIPE_7/chronoscore_phase1/display_tb.vhd
-- Project Name:  chronoscore_phase1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: display
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
 
ENTITY display_tb IS
END display_tb;
 
ARCHITECTURE behavior OF display_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT display
    PORT(
         CE_1ms : IN  std_logic;
         CLK : IN  std_logic;
         data_disp1_R0 : IN  std_logic_vector(3 downto 0);
         data_disp1_R1 : IN  std_logic_vector(3 downto 0);
         data_disp1_L0 : IN  std_logic_vector(3 downto 0);
         data_disp1_L1 : IN  std_logic_vector(3 downto 0);
         data_disp2_R0 : IN  std_logic_vector(3 downto 0);
         data_disp2_R1 : IN  std_logic_vector(3 downto 0);
         data_disp2_L0 : IN  std_logic_vector(3 downto 0);
         data_disp2_L1 : IN  std_logic_vector(3 downto 0);
         CE_1s : IN  std_logic;
         AN : OUT  std_logic_vector(7 downto 0);
         LEDS : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CE_1ms : std_logic := '0';
   signal CLK : std_logic := '0';
   signal data_disp1_R0 : std_logic_vector(3 downto 0) := (others => '0');
   signal data_disp1_R1 : std_logic_vector(3 downto 0) := (others => '0');
   signal data_disp1_L0 : std_logic_vector(3 downto 0) := (others => '0');
   signal data_disp1_L1 : std_logic_vector(3 downto 0) := (others => '0');
   signal data_disp2_R0 : std_logic_vector(3 downto 0) := (others => '0');
   signal data_disp2_R1 : std_logic_vector(3 downto 0) := (others => '0');
   signal data_disp2_L0 : std_logic_vector(3 downto 0) := (others => '0');
   signal data_disp2_L1 : std_logic_vector(3 downto 0) := (others => '0');
   signal CE_1s : std_logic := '0';

 	--Outputs
   signal AN : std_logic_vector(7 downto 0);
   signal LEDS : std_logic_vector(7 downto 0);

   -- Clock period definitions
	constant CLK_period : time := 10 ns;
	constant CE_1ms_period : time := 100 ns;
	constant CE_1s_period : time := 100 ns; -- ou constant CE_1s_period : time := 800 ns;
	
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: display PORT MAP (
          CE_1ms => CE_1ms,
          CLK => CLK,
          data_disp1_R0 => data_disp1_R0,
          data_disp1_R1 => data_disp1_R1,
          data_disp1_L0 => data_disp1_L0,
          data_disp1_L1 => data_disp1_L1,
          data_disp2_R0 => data_disp2_R0,
          data_disp2_R1 => data_disp2_R1,
          data_disp2_L0 => data_disp2_L0,
          data_disp2_L1 => data_disp2_L1,
          CE_1s => CE_1s,
          AN => AN,
          LEDS => LEDS
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

	CE_1s_process :process
	begin
		CE_1s <= '0';
		wait for 90 ns; 
		CE_1s <= '1';
		wait for 10 ns;
	end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
			data_disp1_R0 <="0000";
			data_disp1_R1 <="0001";
			data_disp1_L0 <="0010";
			data_disp1_L1 <="0011";
			data_disp2_R0 <="0100";
			data_disp2_R1 <="0101";
			data_disp2_L0 <="0110";
			data_disp2_L1 <="0111";

      wait for CLK_period*10;

       

      wait;
   end process;

END;
