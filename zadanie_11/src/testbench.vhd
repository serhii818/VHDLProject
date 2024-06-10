library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity testbench is
end testbench;

architecture behavior of testbench is 
   -- Declarations of components
   component square_function
   port(
      addr : in  std_logic_vector(4 downto 0);
      data : out  std_logic_vector(11 downto 0)
      );
   end component;

   component number_multiplyer
   port(
      addr : in std_logic_vector(4 downto 0);
      data : out std_logic_vector(11 downto 0)
      );
   end component;

   -- Signals
   signal addr : std_logic_vector(4 downto 0);
   signal data : std_logic_vector(11 downto 0);
   signal mult_data : std_logic_vector(11 downto 0); -- for number_multiplyer

begin
   -- Instance of the tested module
   uut: square_function port map (
      addr => addr,
      data => data
      );

   -- Instance of number_multiplyer
   mult: number_multiplyer port map (
      addr => addr,
      data => mult_data
      );

   -- Test process
   stim_proc: process
   begin
      -- Test 1
      addr <= "00000";
      wait for 10 ns;
      assert data = X"000" report "Test 1 failed" severity error;
      -- Test 2
      addr <= "00001";
      wait for 10 ns;
      assert data = X"001" report "Test 2 failed" severity error;
      -- Test 3
      addr <= "00010";
      wait for 10 ns;
      assert data = X"004" report "Test 3 failed" severity error;
	  -- Test 4
	  addr <= "01010";
      wait for 10 ns;
      assert data = X"064" report "Test 4 failed" severity error;
	  -- Test 5
	  addr <= "10000";
      wait for 10 ns;
      assert data = X"100" report "Test 5 failed" severity error;
      wait;
   end process;
end behavior;