----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:13:57 02/16/2016 
-- Design Name: 
-- Module Name:    counterDec_4b_RE - Behavioral 
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
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counterDec_4b_RE is
    Port ( R : in  STD_LOGIC;
           CE : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (3 downto 0);
           TC : out  STD_LOGIC);
end counterDec_4b_RE;

architecture Behavioral of counterDec_4b_RE is

signal Q_int: UNSIGNED (3 downto 0) :=(others => '0');
signal TC_int: STD_LOGIC :='0';

begin

CPTDEC_4b_RE : process (clk, R, CE)
begin
		-- Reset asynchrone
		if(R = '1') then
		Q_int (3 downto 0) <=  "0000";
		TC_int <='0';
		-- Boucle de comptage
		elsif (rising_edge (clk)) then
				if (CE='1') then
					-- si CE=1 réinitialisation du comptage pour 9 et mise à 1 de TC_int
					if (Q_int (3 downto 0) = "1001") then
					Q_int (3 downto 0) <= "0000";
					TC_int <='1';
					-- si CE=1 comptage et mise à 0 de TC_int
					else
					Q_int (3 downto 0) <= Q_int (3 downto 0) + 1;
					TC_int <='0';
					end if;
				else
				-- si CE=0 mise à 0 de TC_int
				TC_int <='0';
				end if;
		end if;
end process;

Q (3 downto 0) <= std_logic_vector (Q_int (3 downto 0));
TC <= TC_int;

--TC <= '1' when (Q_int (3 downto 0) = "1001" AND R = '0' AND CE = '1') else
--		'0';

end Behavioral;

