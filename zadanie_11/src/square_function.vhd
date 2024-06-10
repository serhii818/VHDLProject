library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity square_function is
	port(
	addr : in std_logic_vector(4 downto 0);
	data : out std_logic_vector(11 downto 0)
	);
end square_function;



architecture a1 of square_function is
type rom_type is array(0 to 63) of std_logic_vector(11 downto 0);
signal ROM : rom_type := (
X"000", X"001", X"004", X"009", X"010", X"019", X"024", X"031",	  -- tabla kwadratów
X"040", X"051", X"064", X"079", X"090", X"0a9", X"0c4", X"0e1",
X"100", X"121", X"144", X"169", X"190", X"1b9", X"1e4", X"211",
X"240", X"271", X"2a4", X"2d9", X"310", X"349", X"384", X"3c1",
X"400", X"441", X"484", X"4c9", X"510", X"559", X"5a4", X"5f1",
X"640", X"691", X"6e4", X"739", X"790", X"7e9", X"844", X"8a1",
X"900", X"961", X"9c4", X"a29", X"a90", X"af9", X"b64", X"bd1",
X"c40", X"cb1", X"d24", X"d99", X"e10", X"e89", X"f04", X"f81" 
); 
begin

  data <= ROM(conv_integer(addr));
end a1;
