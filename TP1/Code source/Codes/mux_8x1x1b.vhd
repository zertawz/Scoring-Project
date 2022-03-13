----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:06:38 02/14/2022 
-- Design Name: 
-- Module Name:    mux_8x1x1b - Behavioral 
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

entity mux_8x1x1b is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           C : in  STD_LOGIC;
           D : in  STD_LOGIC;
           E : in  STD_LOGIC;
           F : in  STD_LOGIC;
           G : in  STD_LOGIC;
           H : in  STD_LOGIC;
           sel : in  STD_LOGIC_VECTOR (2 downto 0);
           O : out  STD_LOGIC);
end mux_8x1x1b;

architecture Behavioral of mux_8x1x1b is

begin
O <= A when sel="000" else
B when sel="001" else
C when sel="010" else
D when sel="011" else
E when sel="100" else
F when sel="101" else
G when sel="110" else
H;

end Behavioral;

