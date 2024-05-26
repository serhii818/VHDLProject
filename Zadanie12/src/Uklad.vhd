library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Uklad is
	port(
		data : in std_logic_vector(2 downto 0);
		accept : in std_logic;
		delete : in std_logic;
		change_pincode : in std_logic; -- sygnal sterowania dla zmiany pikodu
		reset : in std_logic;		   
		
		open_lock : out std_logic;	-- sygnal ktorey sygnalizuje otwarcie zamka	   
		
		port_l1 : out std_logic_vector(2 downto 0);	 -- dla sledzenia wprowadzonych liczb
		port_l2 : out std_logic_vector(2 downto 0);
		port_l3 : out std_logic_vector(2 downto 0);
		port_l4 : out std_logic_vector(2 downto 0)
	);
end Uklad;



architecture Uklad of Uklad is
-- stan sekwencji liczb
subtype stan_ukladu is integer range 0 to 4;
type zaprogramuj is (false, true);

-- stan przeprogramuwania
signal stan : stan_ukladu := 0;
signal stan_zaprogramuwania : zaprogramuj := false; 

-- pinkod zaprogramowany
subtype kod is integer range 0 to 7;
signal l1 : kod := 0;
signal l2 : kod := 0;
signal l3 : kod := 0;
signal l4 : kod := 0;
-- pinkod wprowadzony
signal l1_in : kod;
signal l2_in : kod;
signal l3_in : kod;
signal l4_in : kod;

signal sig_open_lock : std_logic := '0';
signal sprawz_pinkod : std_logic := '0';

begin 
	-------------------------------------------------------------
	process(accept, delete, change_pincode, reset)
	begin
		if (reset = '1') then  -- resetuje wprowadzenie kodu
			stan <= 0;
			
		elsif (change_pincode = '1') then -- wprowadzenie kodu
			stan_zaprogramuwania <= true;
			stan <= 0;	
			
		elsif (delete = '1') then  -- remove one digit
			if (stan /= 0) then
				stan <= stan - 1; 
			end if;		 
			
		elsif (accept = '1') then -- zapisuje wprowadzone dane do odpowiedniego sygnau wedlug stanu
			case stan is
				when 0 => l1_in <= to_integer(unsigned(data));
				when 1 => l2_in <= to_integer(unsigned(data));
				when 2 => l3_in <= to_integer(unsigned(data));
				when 3 => l4_in <= to_integer(unsigned(data));
				when others => 
					sprawz_pinkod <= '1', '0' after 20 ns;
					stan_zaprogramuwania <= false;
					stan <= 0;
			end case;												 
		end if;
	end process;
	
	comb:process(sprawz_pinkod)	 -- process kombonacyjny
	begin
		if (stan_zaprogramuwania = true) then
		   l1 <= l1_in;
		   l2 <= l2_in;
		   l3 <= l3_in;
		   l4 <= l4_in;
		else   
			if ((l1 = l1_in) and (l2 = l2_in) and (l3 = l3_in) and (l4 = l4_in)) then
				sig_open_lock <= '1', '0' after 20ns;
			end if;
		end if;
	end process;			  
	
	-- podlaczeine sygnalow
	open_lock <= sig_open_lock;
	port_l1 <= std_logic_vector(to_unsigned(l1_in, 3));	
	port_l2 <= std_logic_vector(to_unsigned(l2_in, 3));
	port_l3 <= std_logic_vector(to_unsigned(l3_in, 3));
	port_l4 <= std_logic_vector(to_unsigned(l4_in, 3));

end Uklad;
