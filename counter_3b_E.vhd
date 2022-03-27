----------------------------------------------------------------------------------
-- Company: 
-- Engineer: JC BURNOT avec son petit PC perso
-- 
-- Create Date:    16:36:25 03/12/2022 
-- Design Name: 
-- Module Name:    counter_3b_E - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_3b_E is
    Port ( clk : in  STD_LOGIC;
           CE : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (2 downto 0));
end counter_3b_E;

architecture Behavioral of counter_3b_E is
signal Q_int : unsigned(2 downto 0):= "000";

begin

process(clk,CE)

begin
if(rising_edge(clk)) then
	if (CE='1') then
		Q_int <= Q_int + 1;
		end if;
	end if;
end process;

Q <= STD_LOGIC_VECTOR (Q_int);

end Behavioral;

