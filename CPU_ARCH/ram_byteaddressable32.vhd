library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.tools.all;

entity ram_byteaddressable32 is 
generic( 
	addresses : integer :=8;
	init_file_directory : string
);
port(
	clk,cs,rd1,rd2,wd: in std_logic;
	D : in std_logic_vector(31 downto 0);
	-- follows riscv funct3 filed to choose size
	-- outs 4 bytes and non concerned bytes are 0 or sign extended
	-- takes nescessary bytes only
	special_write,special_read1,special_read2: in std_logic_vector(2 downto 0);
	address_write,address_read1,address_read2: in std_logic_vector(addresses-1 downto 0);
	Q1,Q2 : out std_logic_vector(31 downto 0)
);
end ram_byteaddressable32;

architecture arch of ram_byteaddressable32 is 

--type ram_t is array (0 to (2**addresses -1)) of std_logic_vector(7 downto 0);
--signal data : ram_t;

signal data : std_logic_vector_array(2**addresses -1 downto 0)(7 downto 0)--:=init_ram_withFile(init_file_directory,addresses)
;
attribute RAM_INIT_FILE : string;
attribute RAM_INIT_FILE of data : signal is init_file_directory;
-- use attribute for mif 
-- function for simulation :)
begin
-- CHANGE THEM TO ACCOMODATE TO RISCV FUNCT 3 FIELD IN LOAD AND STORE OPERATIONS
process(clk,cs,wd,address_write,D,special_write)
begin 
if (cs='0') then if (clk'event and clk='1') then 
		if(wd='1') then case special_write is 
			--store word
			when "010"=> data(to_integer(unsigned(address_write)+0))<=D(7 downto 0);
							 data(to_integer(unsigned(address_write)+1))<=D(15 downto 8);
							 data(to_integer(unsigned(address_write)+2))<=D(23 downto 16);
							 data(to_integer(unsigned(address_write)+3))<=D(31 downto 24);
			-- store half word unsigned
			when "001"=> data(to_integer(unsigned(address_write)+0))<=D(7 downto 0);
							 data(to_integer(unsigned(address_write)+1))<=D(15 downto 8);
			-- store byte unsigned
			when "000"=> data(to_integer(unsigned(address_write)+0))<=D(7 downto 0);
			--else do nothing
			when others=>NULL;
		end case;
		end if;

end if;end if;
end process;


process(cs,rd1,address_read1,special_read1)
begin 
Q1<=(others=>'0');
if (cs='0') then 
		if(rd1='1') then case special_read1 is 
			--load word
			when "010"=> Q1(7 downto 0)<=data(to_integer(unsigned(address_read1)+0));
							 Q1(15 downto 8)<=data(to_integer(unsigned(address_read1)+1));
							 Q1(23 downto 16)<=data(to_integer(unsigned(address_read1)+2));
							 Q1(31 downto 24)<=data(to_integer(unsigned(address_read1)+3));
			--load half word signed (msb of second byte is used to determine the sign)
			when "001"=> Q1(7 downto 0)<=data(to_integer(unsigned(address_read1)+0));
							 Q1(15 downto 8)<=data(to_integer(unsigned(address_read1)+1)); 	
							 Q1(31 downto 16)<=(others=>data(to_integer(unsigned(address_read1)+1))(7));
		   --load half word unsigned
			when "101"=> Q1(7 downto 0)<=data(to_integer(unsigned(address_read1)+0));
							 Q1(15 downto 8)<=data(to_integer(unsigned(address_read1)+1)); 	
			--load byte signed(msb of first byte is used to determine the sign)
			when "000"=> Q1(7 downto 0)<=data(to_integer(unsigned(address_read1)+0));
							 Q1(31 downto 8)<=(others=>data(to_integer(unsigned(address_read1)+0))(7));
		   --load byte word unsigned
			when "100"=> Q1(7 downto 0)<=data(to_integer(unsigned(address_read1)+0));
			when others=>NULL;
			end case;
		end if;
end if;
end process;


process(cs,rd2,address_read2,special_read2)
begin 
Q2<=(others=>'0');
if (cs='0') then 
		if(rd2='1') then case special_read2 is 
			--load word
			when "000"=> Q2(7 downto 0)<=data(to_integer(unsigned(address_read2)+0));
							 Q2(15 downto 8)<=data(to_integer(unsigned(address_read2)+1));
							 Q2(23 downto 16)<=data(to_integer(unsigned(address_read2)+2));
							 Q2(31 downto 24)<=data(to_integer(unsigned(address_read2)+3));
			--load half word signed (msb of second byte is used to determine the sign)
			when "001"=> Q2(7 downto 0)<=data(to_integer(unsigned(address_read2)+0));
							 Q2(15 downto 8)<=data(to_integer(unsigned(address_read2)+1)); 	
							 Q2(31 downto 16)<=(others=>data(to_integer(unsigned(address_read2)+1))(7));
		   --load half word unsigned
			when "010"=> Q2(7 downto 0)<=data(to_integer(unsigned(address_read2)+0));
							 Q2(15 downto 8)<=data(to_integer(unsigned(address_read2)+1)); 	
			--load byte signed(msb of first byte is used to determine the sign)
			when "011"=> Q2(7 downto 0)<=data(to_integer(unsigned(address_read2)+0));
							 Q2(31 downto 8)<=(others=>data(to_integer(unsigned(address_read2)+0))(7));
		   --load half word unsigned
			when "100"=> Q2(7 downto 0)<=data(to_integer(unsigned(address_read2)+0));
			when others=>NULL;
			end case;
		end if;
end if;
end process;

end arch;
