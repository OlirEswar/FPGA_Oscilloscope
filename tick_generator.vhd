--=============================================================================
--Library Declarations:
--=============================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.math_real.all;
library UNISIM;
use UNISIM.VComponents.all;

--=============================================================================
--Entity Declaration:
--=============================================================================
entity tick_generator is
	generic (FREQUENCY_DIVIDER_RATIO : integer);
	port (
		system_clk_port  : in  std_logic;
		tick_port		 : out std_logic);
end tick_generator;

--=============================================================================
--Architecture Type:
--=============================================================================
architecture behavioral_architecture of tick_generator is
--=============================================================================
--Signal Declarations: 
--=============================================================================
--CONSTANT FOR SYNTHESIS:
constant FREQUENCY_DIVIDER_TC: integer := FREQUENCY_DIVIDER_RATIO;
--CONSTANT FOR SIMULATION:
--constant FREQUENCY_DIVIDER_TC: integer := 20;

--Automatic register sizing:
constant COUNT_LEN					: integer := integer(ceil( log2( real(FREQUENCY_DIVIDER_TC) ) ));
signal frequency_divider_counter	: unsigned(COUNT_LEN-1 downto 0) := (others => '0');       

--=============================================================================
--Processes: 
--=============================================================================
begin
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--Frequency Divider:
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
frequency_divider: process(system_clk_port, frequency_divider_counter)
begin
	if rising_edge(system_clk_port) then
	   	if frequency_divider_counter = FREQUENCY_DIVIDER_TC-1 then 	  
			frequency_divider_counter <= (others => '0');			  -- Reset
		else
			frequency_divider_counter <= frequency_divider_counter + 1; -- Count up
		end if;
	end if;
	
	if frequency_divider_counter = 0 then tick_port <= '1';
	else tick_port <= '0';
	end if;
end process frequency_divider;

end behavioral_architecture;