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
		port_l4 : out std_logic_vector(2 downto 0);
		
		out_stan : out std_logic_vector(2 downto 0); -- stan wprowadzenia sekwencji
		przeprogramuwanie : out std_logic;
		port_l1k : out std_logic_vector(2 downto 0);	 -- obecny pinkod
		port_l2k : out std_logic_vector(2 downto 0);
		port_l3k : out std_logic_vector(2 downto 0);
		port_l4k : out std_logic_vector(2 downto 0)
	);
end Uklad;



architecture Uklad of Uklad is
-- stan sekwencji liczb
subtype stan_ukladu is integer range 0 to 5;
signal stan : stan_ukladu := 0;

-- stan przeprogramuwania
signal stan_zaprogramuwania : std_logic := '0'; 

-- pinkod zaprogramowany
subtype kod is integer range 0 to 7;
signal l1 : kod := 1;
signal l2 : kod := 2;
signal l3 : kod := 3;
signal l4 : kod := 4;
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
			stan_zaprogramuwania <= '1';
			stan <= 0;	
			
		elsif (delete = '1') then  -- remove one digit
			if (stan /= 0) then
				stan <= stan - 1; 
			end if;		 
			
		elsif (accept = '1') then -- zapisuje wprowadzone dane do odpowiedniego sygnau wedlug stanu
			case stan is
				when 0 => 
					l1_in <= to_integer(unsigned(data));
					stan <= 1;
				when 1 =>
					l2_in <= to_integer(unsigned(data));
					stan <= 2;			
				when 2 => 
					l3_in <= to_integer(unsigned(data));
					stan <= 3;
				when 3 => 
					l4_in <= to_integer(unsigned(data));
					sprawz_pinkod <= '1', '0' after 5ns;
					stan <= 0;
					stan_zaprogramuwania <= '0' after 10 ns;
				when others => null; 
			end case;

		end if;
	end process;
	
	process(sprawz_pinkod)
	begin
		if (sprawz_pinkod = '1') then
			if (stan_zaprogramuwania = '1') then
			  	l1 <= l1_in;
			   	l2 <= l2_in;
			   	l3 <= l3_in;
			   	l4 <= l4_in;

			else   
				if ((l1 = l1_in) and (l2 = l2_in) and (l3 = l3_in) and (l4 = l4_in)) then
					sig_open_lock <= '1', '0' after 20ns;
				end if;
			end if;
		end if;
	end process;
			  
	
	-- podlaczeine sygnalow
	open_lock <= sig_open_lock;
	out_stan <= std_logic_vector(to_unsigned(stan, 3));
	przeprogramuwanie <= stan_zaprogramuwania;
	
	port_l1 <= std_logic_vector(to_unsigned(l1_in, 3));	
	port_l2 <= std_logic_vector(to_unsigned(l2_in, 3));
	port_l3 <= std_logic_vector(to_unsigned(l3_in, 3));
	port_l4 <= std_logic_vector(to_unsigned(l4_in, 3));
	port_l1k <= std_logic_vector(to_unsigned(l1, 3));	
	port_l2k <= std_logic_vector(to_unsigned(l2, 3));
	port_l3k <= std_logic_vector(to_unsigned(l3, 3));
	port_l4k <= std_logic_vector(to_unsigned(l4, 3));

end Uklad;
