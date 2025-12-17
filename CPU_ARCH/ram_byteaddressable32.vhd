library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- used plug in wisard to generate this memory, one ram with read/write port
-- WITH BYTE ENABLE and mif initialization.
-- generated memory is word addressable with byte enable,
-- meaning i get access to specific bytes easilly with more logic an instantiation
entity ram_byteaddressable32 is
	GENERIC (address_width : INTEGER;--1 for data
	INIT_FILE:STRING-- 1 for data
	);
	 port (
        clk        : in  std_logic;
        we,re1,re2         : in  std_logic;
        byte_en    : in  std_logic_vector(3 downto 0);
        addr_wr    : in  std_logic_vector(31 downto 0);  -- 10-bit byte address
        din        : in  std_logic_vector(31 downto 0);
        addr_rd1   : in  std_logic_vector(31 downto 0);
        addr_rd2   : in  std_logic_vector(31 downto 0);
        dout1      : out std_logic_vector(31 downto 0);
        dout2      : out std_logic_vector(31 downto 0)
    );
end entity;

architecture rtl of ram_byteaddressable32 is
    -- Word address = addr(9 downto 2)
    signal wr_addr    : std_logic_vector(address_width-1 downto 2) := (others => '0');
    signal rd1_addr   : std_logic_vector(address_width-1 downto 2) := (others => '0');
    signal rd2_addr   : std_logic_vector(address_width-1 downto 2) := (others => '0');

    component ram_block
 	GENERIC (address_width : INTEGER;
	INIT_FILE:STRING
	);
	PORT
	(
		byteena_a		: IN STD_LOGIC_VECTOR (3 DOWNTO 0) :=  (OTHERS => '1');
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		rdaddress		: IN STD_LOGIC_VECTOR (address_width-1 DOWNTO 0);
		rden		: IN STD_LOGIC  := '1';
		wraddress		: IN STD_LOGIC_VECTOR (address_width-1 DOWNTO 0);
		wren		: IN STD_LOGIC  := '0';
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
    end component;
    signal q1, q2 : std_logic_vector(31 downto 0);
begin
    wr_addr  <= addr_wr(address_width-1 downto 2); -- Word aligned but byte enable controls 
    rd1_addr <= addr_rd1(address_width-1 downto 2); -- what part of word is used :)
    rd2_addr <= addr_rd2(address_width-1 downto 2); -- that occurs at LSU level
 
    -- First RAM instance: handles write + read1
    ram1: ram_block
	 generic map(address_width-2,INIT_FILE)
       PORT map
	(
		byteena_a=>byte_en,
		clock		=>clk,
		data		=>din,
		rdaddress=>rd1_addr,
		wraddress=>wr_addr,
		wren=>we,
		rden=>re1,
		q=>q1
	);
	
-- Second RAM instance: read-only mirror
    ram2: ram_block
	  generic map(address_width-2,INIT_FILE)
       PORT map
	(
		byteena_a=>byte_en,
		clock		=>clk,
		data		=>din,
		rdaddress=>rd2_addr,
		wraddress=>wr_addr,
		wren=>we,
		rden=>re2,
		q=>q2
	);

	
	--select data based on output
    dout1 <= q1;
    
	 
	 dout2 <= q2;--instruction
end architecture;