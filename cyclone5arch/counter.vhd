library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is 
generic( counter_width : integer:=8);
port(
	clk,rst:in std_logic;
	count: out std_logic_vector(counter_width-1 downto 0)
);end counter;

architecture arch of counter is 
signal count_unsigned : unsigned(counter_width-1 downto 0);
begin
 
process(clk,rst)
begin
	if (rst='1') then count_unsigned<=(others=>'0');
	elsif (clk'event and clk='1') then count_unsigned<=count_unsigned+1;
	end if;
end process;

count<=std_logic_vector(count_unsigned);
end arch;