library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity number_multiplyer is
	port(
	addr : in std_logic_vector(4 downto 0);
	data : out std_logic_vector(11 downto 0)
	);
end number_multiplyer;


architecture a1 of number_multiplyer is
type rom_type is array(63 downto 0) of std_logic_vector(11 downto 0);
signal ROM : rom_type := (
X"000", X"005", X"00a", X"00f", X"014", X"019", X"01e", X"023", X"028", X"02d",		-- tabelka wartosci przemnozonych przez 5
X"032", X"037", X"03c", X"041", X"046", X"04b", X"050", X"055", X"05a", X"05f", X"064",
X"069", X"06e", X"073", X"078", X"07d", X"082", X"087", X"08c", X"091", X"096", X"09b",
X"0a0", X"0a5", X"0aa", X"0af", X"0b4", X"0b9", X"0be", X"0c3", X"0c8", X"0cd", X"0d2",
X"0d7", X"0dc", X"0e1", X"0e6", X"0eb", X"0f0", X"0f5", X"0fa", X"0ff", X"104", X"109",
X"10e", X"113", X"118", X"11d", X"122", X"127", X"12c", X"131", X"136", X"13b"
); 

begin
	
	data <= ROM(conv_integer(addr));

end a1;
