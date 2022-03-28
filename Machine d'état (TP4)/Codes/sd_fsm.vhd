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
			VRGB 	: out  STD_LOGIC_VECTOR(2 downto 0)	-- Vesitor RGB
		);
end sd_fsm;

architecture rtl of sd_fsm is
TYPE states IS (IDLE, SNV, LS1,  LS2,  LS3,  LS4, LSV, VS1, VS2,VS3,VS4, VSV);
SIGNAL current_state, next_state : states := IDLE;
signal cnt, cnt_reg : integer range 0 to 255 := 0;

begin

-- State Register:
SR_PROC : process (clk, rst)
begin
	if rst='1' then --see Note 2 above on boolean tests
		current_state <= IDLE;
		cnt_reg <= 0;
	elsif rising_edge(clk) then
		cnt_reg <= cnt;
		current_state <= next_state;
	end if;
end process;


--Combinational for Next State:
process(current_state,PB1,PB2,PB3,PB4,PBV, cnt_reg)
begin
	next_state <= current_state;
	cnt <= cnt_reg;
	case current_state is
		when IDLE =>
			if PB1 = '1' then
				next_state <= LS1;
			elsif PB3 = '1' then
				next_state <= VS1;
			elsif PB2='1' OR PB4='1' OR PBV='1' then
				next_state <= SNV;
			else
				next_state <= current_state;
			end if;
		when LS1 =>
			if PB2 = '1' then
				next_state <= LS2;
			elsif PB1='1' OR PBV='1' OR PB3='1' OR PB4='1' then
				next_state <= SNV;
			else
				next_state <= current_state;
			end if;
		when LS2 =>
			if PB3 = '1' then
				next_state <= LS3;
			elsif PB1='1' OR PB2='1' OR PBV='1' OR PB4='1' then
				next_state <= SNV;
			else
				next_state <= current_state;
			end if;
		when LS3 =>
			if PB4 = '1' then
				next_state <= LS4;
			elsif PB1='1' OR PB2='1' OR PB3='1' OR PBV='1' then
				next_state <= SNV;
			else
				next_state <= current_state;
			end if;
		when LS4 =>
			if PBV = '1' then
				next_state <= LSV;
			elsif PB1='1' OR PB2='1' OR PB3='1' OR PB4='1' then
				next_state <= SNV;
			else
				next_state <= current_state;
			end if;
		when LSV =>
			if(CE_1s='1') then
				cnt <= cnt_reg+1;
				if(cnt_reg=3) then
					cnt <= 0;
					next_state <= IDLE;
				end if;
			end if;	
		when VS1 =>
			if PB4 = '1' then
				next_state <= VS2;
			elsif PB1='1' OR PBV='1' OR PB3='1' OR PB2='1' then
				next_state <= SNV;
			else
				next_state <= current_state;
			end if;
		when VS2 =>
			if PB1 = '1' then
				next_state <= VS3;
			elsif PB1='1' OR PB2='1' OR PBV='1' OR PB4='1' then
				next_state <= SNV;
			else
				next_state <= current_state;
			end if;
		when VS3 =>
			if PB2 = '1' then
				next_state <= VS4;
			elsif PB1='1' OR PB4='1' OR PB3='1' OR PBV='1' then
				next_state <= SNV;
			else
				next_state <= current_state;
			end if;
		when VS4 =>
			if PBV = '1' then
				next_state <= VSV;
			elsif PB1='1' OR PB2='1' OR PB3='1' OR PB4='1' then
				next_state <= SNV;
			else
				next_state <= current_state;
			end if;
		when VSV =>
			if(CE_1s='1') then
				cnt <= cnt_reg+1;
				if(cnt_reg=2) then
					cnt <= 0;
					next_state <= IDLE;
				end if;
			end if;			
		when SNV =>
			if(CE_1s='1') then
				cnt <= cnt_reg+1;
				if(cnt_reg=1) then
					cnt <= 0;
					next_state <= IDLE;
				end if;
			end if;		
	end case;
end process;

-- Combinational for Moore output logic
process(current_state)
begin
	case current_state is
		when IDLE =>
			LRGB <= "001";
			VRGB <= "001";
			LSINC <= '0';
			VSINC <= '0';
		when LSV =>
			LRGB <= "010";
			VRGB <= "000";
			LSINC <= '1';
			VSINC <= '0';
		when VSV =>
			LRGB <= "000";
			VRGB <= "010";
			LSINC <= '0';
			VSINC <= '1';
		when SNV =>
			LRGB <= "100";
			VRGB <= "100";
			LSINC <= '0';
			VSINC <= '0';
		when others =>
			LRGB <= "000";
			VRGB <= "000";
			LSINC <= '0';
			VSINC <= '0';
			
	end case;
end process;

end rtl;
