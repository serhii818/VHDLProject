library ieee;
use ieee.std_logic_1164.all;

entity Uklad_tb is
end Uklad_tb;

architecture Uklad_tb of Uklad_tb is
signal	data : 			std_logic_vector(2 downto 0);
signal	accept : 		std_logic;
signal	delete : 		std_logic;
signal	change_pincode: std_logic; 
signal	reset :  		std_logic;		   

signal	open_lock : 	std_logic;	
		
signal	port_l1 :  		std_logic_vector(2 downto 0);	 
signal	port_l2 :  		std_logic_vector(2 downto 0);
signal	port_l3 :  		std_logic_vector(2 downto 0);
signal	port_l4 :  		std_logic_vector(2 downto 0);

signal	port_l1k :  	std_logic_vector(2 downto 0);	 
signal	port_l2k :  	std_logic_vector(2 downto 0);
signal	port_l3k :  	std_logic_vector(2 downto 0);
signal	port_l4k :  	std_logic_vector(2 downto 0); 

signal	out_stan :  	std_logic_vector(2 downto 0);  
signal  przeprogramuwanie : std_logic;
begin

	utt : entity work.Uklad port map(
		data => data,
		accept => accept,		
		delete => delete,
		change_pincode => change_pincode,
		reset => reset,
		open_lock => open_lock,
		port_l1 => port_l1,
		port_l2 => port_l2,
		port_l3 => port_l3,
		port_l4 => port_l4,
		port_l1k => port_l1k,
		port_l2k => port_l2k,
		port_l3k => port_l3k,
		port_l4k => port_l4k,
		out_stan => out_stan,
		przeprogramuwanie => przeprogramuwanie
	);

	process
	begin		
		-- wprowadzenie pinkodu
		data <= "001";
		wait for 5ns;
		accept <= '1', '0' after 10 ns;
		wait for 20 ns;	
		
		data <= "010"; 	
		wait for 5ns;
		accept <= '1', '0' after 10 ns;
		wait for 20 ns;
		
		data <= "111";
		wait for 5ns;
		accept <= '1', '0' after 10 ns;
		wait for 20 ns;
		
		-- usuniecie jednej liczby
		delete <= '1';
		wait for 5 ns;
		delete <= '0';
		wait for 20 ns;	
		
		data <= "011";
		wait for 5ns;
		accept <= '1', '0' after 10 ns;
		wait for 20 ns;
		
		data <= "100";
		wait for 5ns;
		accept <= '1', '0' after 10 ns;
		wait for 100 ns;
		
		-- przeprogramowanie
		change_pincode <= '1';
		wait for 5ns;
		change_pincode <= '0';
		wait for 20ns;
		-- wprowadzenie nowego pinkodu
		data <= "111";
		wait for 5ns;
		accept <= '1', '0' after 10 ns;
		wait for 20 ns;	
		
		data <= "010"; 	
		wait for 5ns;
		accept <= '1', '0' after 10 ns;
		wait for 20 ns; 
		
		data <= "101";
		wait for 5ns;
		accept <= '1', '0' after 10 ns;
		wait for 20 ns;
		
		data <= "001";
		wait for 5ns;
		accept <= '1', '0' after 10 ns;
		wait for 100 ns;
		
		-- wprowadzmy stary pinkod
		data <= "001";
		wait for 5ns;
		accept <= '1', '0' after 10 ns;
		wait for 20 ns;	
		
		data <= "010"; 	
		wait for 5ns;
		accept <= '1', '0' after 10 ns;
		wait for 20 ns; 
		
		data <= "011";
		wait for 5ns;
		accept <= '1', '0' after 10 ns;
		wait for 20 ns;
		
		data <= "100";
		wait for 5ns;
		accept <= '1', '0' after 10 ns;
		wait for 100 ns; 
		-- niedziala
		
		-- wprowadzmy nowy pinkod
		data <= "111";
		wait for 5ns;
		accept <= '1', '0' after 10 ns;
		wait for 20 ns;	
		
		data <= "010"; 	
		wait for 5ns;
		accept <= '1', '0' after 10 ns;
		wait for 20 ns; 
		
		data <= "101";
		wait for 5ns;
		accept <= '1', '0' after 10 ns;
		wait for 20 ns;
		
		data <= "001";
		wait for 5ns;
		accept <= '1', '0' after 10 ns;
		wait for 100 ns; 
		-- dziala
		
	end process;


end Uklad_tb;
