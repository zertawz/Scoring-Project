----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:33:05 02/14/2022 
-- Design Name: 
-- Module Name:    register_8b - Behavioral 
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

entity register_8b is
    Port ( clk : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR (7 downto 0);
           Q : out  STD_LOGIC_VECTOR (7 downto 0));
			 		  
end register_8b;

architecture behavioral of register_8b is
signal Q_Int : std_logic_vector(7 downto 0);

Begin

	Q <= Q_Int;
	proc : process(clk,D)
	begin
		if(rising_edge(clk) ) then
			Q_Int <= D;
		end if;
	end process proc;
	
end behavioral;

