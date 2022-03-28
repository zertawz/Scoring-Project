----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03/22/2022 
-- Design Name: 
-- Module Name:    pb_debouncer_1b - rtl 
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

entity pb_debouncer_1b is
    Port ( clk : in  STD_LOGIC;
           CE_1ms : in  STD_LOGIC;
           PBin : in  STD_LOGIC;
           PBout : out  STD_LOGIC);
end pb_debouncer_1b;

architecture rtl of pb_debouncer_1b is

    COMPONENT register_1b_E
    PORT(
         CE : IN  std_logic;
         D : IN  std_logic;
         clk : IN  std_logic;
         Q : OUT  std_logic
        );
    END COMPONENT;
	 
	 COMPONENT register_1b
    PORT(
         D : IN  std_logic;
         clk : IN  std_logic;
         Q : OUT  std_logic
        );
    END COMPONENT;

	 SIGNAL bpin_reg1, bpin_reg2, bpin_reg3 : STD_LOGIC := '0';
	 
begin

   U0: register_1b_E PORT MAP (
          CE => CE_1ms,
          D => PBin,
          clk => clk,
          Q => bpin_reg1
        );
		  
   U1: register_1b_E PORT MAP (
          CE => CE_1ms,
          D => bpin_reg1,
          clk => clk,
          Q => bpin_reg2
        );
	
	U2: register_1b PORT MAP (
          D => bpin_reg2,
          clk => clk,
          Q => bpin_reg3
        );

	PBout <= (bpin_reg3 XOR bpin_reg2) AND bpin_reg2;	-- bpin_reg3 AND (NOT bpin_reg2)
	
	
end rtl;

