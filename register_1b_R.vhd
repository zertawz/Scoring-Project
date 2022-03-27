----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:20:27 02/28/2022 
-- Design Name: 
-- Module Name:    register_1b_R - Behavioral 
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

entity register_1b_R is
    Port ( D : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           R : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end register_1b_R;

architecture Behavioral of register_1b_R is
	signal Q_int : std_logic := '0';
begin

	DataRst_process : process(clk)
	begin
		if rising_edge(clk) then
			if R = '1' then
				Q_int <= '0';
			else
				Q_int <= D;
			end if;
		end if;
	end process;
	
	Q <= Q_int;
end Behavioral;

