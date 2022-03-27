----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:53:22 02/14/2022 
-- Design Name: 
-- Module Name:    mux_8x1x4b - Behavioral 
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

entity mux_8x1x4b is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           C : in  STD_LOGIC_VECTOR (3 downto 0);
           D : in  STD_LOGIC_VECTOR (3 downto 0);
           E : in  STD_LOGIC_VECTOR (3 downto 0);
           F : in  STD_LOGIC_VECTOR (3 downto 0);
           G : in  STD_LOGIC_VECTOR (3 downto 0);
           H : in  STD_LOGIC_VECTOR (3 downto 0);
           sel : in  STD_LOGIC_VECTOR (2 downto 0);
           O : out  STD_LOGIC_VECTOR (3 downto 0));
end mux_8x1x4b;

architecture Behavioral of mux_8x1x4b is

begin
O <= A when (sel="000")else
	B when (sel="001")else
	C when (sel="010")else
	D when (sel="011")else
	E when (sel="100")else
	F when (sel="101")else
	G when (sel="110")else
	H;


end Behavioral;

