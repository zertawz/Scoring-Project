----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:16:54 03/02/2022 
-- Design Name: 
-- Module Name:    sd_fsm - rtl 
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

entity sd_fsm is
    Port ( 	rst 	: in  STD_LOGIC;
			clk 	: in  STD_LOGIC;
			CE_1s 	: in  STD_LOGIC;
			PB1 	: in  STD_LOGIC;
			PB2 	: in  STD_LOGIC;
			PB3 	: in  STD_LOGIC;
			PB4 	: in  STD_LOGIC;
			PBV 	: in  STD_LOGIC;
			------------------------------------------------------------
			LSINC 	: out  STD_LOGIC;
			VSINC 	: out  STD_LOGIC;
			LRGB 	: out  STD_LOGIC_VECTOR(2 downto 0);	-- Local RGB
			VRGB 	: out  STD_LOGIC_VECTOR(2 downto 0)		-- Vesitor RGB
		);
end sd_fsm;

architecture rtl of sd_fsm is

begin

-- State Register:


-- Combinational for Next State and Logic for Output:


end rtl;

