--=============================================================
--Ben Dobbins
--ES31/CS56
--This script is the SPI Receiver code for Lab 6, the voltmeter.
--Your name goes here:  Oliravan Eswaramoorthy
--=============================================================

--=============================================================
--Library Declarations
--=============================================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;			-- needed for arithmetic
use ieee.math_real.all;				-- needed for automatic register sizing
library UNISIM;						-- needed for the BUFG component
use UNISIM.Vcomponents.ALL;

--=============================================================
--Entitity Declarations
--=============================================================
entity spi_receiver is
	generic(
		N_SHIFTS 				: integer);
	port(
	    --1 MHz serial clock
		clk_port				: in  std_logic;	
    	
    	--controller signals
		take_sample_port 		: in  std_logic;	
		spi_cs_port			    : out std_logic;
        
        --datapath signals
		spi_s_data_port		    : in  std_logic;	
		adc_data_port			: out std_logic_vector(11 downto 0));
end spi_receiver; 

--=============================================================
--Architecture + Component Declarations
--=============================================================
architecture Behavioral of spi_receiver is
--=============================================================
--Local Signal Declaration
--=============================================================
signal shift_enable		: std_logic := '0';
signal load_enable		: std_logic := '0';
signal shift_reg	    : std_logic_vector(11 downto 0) := (others => '0');

signal count 			: unsigned(3 downto 0) := "0000";
signal tc				: std_logic := '0';

type state_type is (idle, assert_spi_cs, shift_bits, load);
signal current_state, next_state : state_type := idle;

begin
--=============================================================
--Controller:
--=============================================================

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--State Update:
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		
state_update: process(clk_port)
begin
	if rising_edge(clk_port) then
    	current_state <= next_state;
    end if;
end process state_update;

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--Next State Logic:
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
next_state_logic : process (current_state, take_sample_port, tc) 
begin
    next_state <= current_state;
         
    -- Fill in next state logic:                                         
	case (current_state) is
    	when (idle) => if take_sample_port = '1' then
        					next_state <= assert_spi_cs;
                       end if;
                               	                   
        when (assert_spi_cs) => next_state <= shift_bits;
          
        when (shift_bits) => if tc = '1' then
        							next_state <= load;
                             end if;

        when (load) => next_state <= idle;
                                
        when others => next_state <= idle;  -- should never reach
    end case;

end process next_state_logic;

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--Output Logic:
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
output_logic: process (current_state)
begin
    -- Define signal defaults:
    spi_cs_port <= '1';
    shift_enable <= '0';
    load_enable <= '0';
      
    -- Fill in output logic:                                         
	case (current_state) is
    	when (idle) =>	spi_cs_port <= '1';
        				shift_enable <= '0';
    					load_enable <= '0';
                          
        when (assert_spi_cs) =>	spi_cs_port <= '0';
        						shift_enable <= '1';
    							load_enable <= '0';

        when (shift_bits) =>	spi_cs_port <= '0';
        				        shift_enable <= '1';
    					        load_enable <= '0';

        when (load) =>	spi_cs_port <= '1';
        				shift_enable <= '0';
    					load_enable <= '1';
   
        when others => null;  -- should never reach
    end case;

end process output_logic;

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--Timer Sub-routine:
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
counter_process: process (clk_port)
begin
	
	if rising_edge(clk_port) then
	   if shift_enable = '1' then
        	if count = (N_SHIFTS-1) then
            	count <= "0000";
            else
            	count <= count + 1;
            end if;
        end if; 
    end if;
    
    if count = (N_SHIFTS-1) then
        tc <= '1';
    else 
        tc <= '0';
    end if;
end process;

--=============================================================
--Datapath:
--=============================================================
shift_register: process(clk_port) 
begin
	if rising_edge(clk_port) then
		if shift_enable = '1' then shift_reg <= shift_reg(10 downto 0) & spi_s_data_port;
		end if;
		
		if load_enable = '1' then adc_data_port <= shift_reg;
		end if;
    end if;
end process;
end Behavioral; 