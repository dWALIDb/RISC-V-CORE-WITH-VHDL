-- this file is used for synthesis,and is providing PC,SEVEN SEGMENT DISPLAY
-- the synthesis file directories are used to initialize the memories
-- more outputs are provided to prevent the synthesizer from omitting logic :)
-- MAKE SURE YOU GOT VHDL2008
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RV32IMF_PROJECT is
generic(
data_width:integer:=32;
address_width:integer:=5;
instruction_memory_address_width:integer:=12;--bare in mind that 2 lsbs are not used to address ram(word addressable shenanigans)

instruction_file_directory0:string:=
"C:\Users\DELL\Desktop\xpack_RISCV_gcc\mif_0.mif"

);
port (
--"rd" must be '1' and "wd" must be '0'
	clk,rst,int:in std_logic;
	IN_DATA:in std_logic_vector(31 downto 0);
	OUT_DATA,instruction_address,instruction:out std_logic_vector(31 downto 0);
	funct3:out std_logic_vector(2 downto 0);
	ram_out,ram_in:out std_logic_vector(31 downto 0);
	WD_en:out std_logic;
	sev_seg1,sev_seg2,sev_seg3,sev_seg4,sev_seg5,sev_seg6,sev_seg7,sev_seg8:out std_logic_vector(6 downto 0)--MSB iS a
);end RV32IMF_PROJECT;
architecture arch of RV32IMF_PROJECT is 

component ram_byteaddressable32 is 
	generic (address_width : INTEGER;
	INIT_FILE:STRING
	);
port (
        clk        : in  std_logic;
        we,re1,re2         : in  std_logic;
        byte_en    : in  std_logic_vector(3 downto 0);
        addr_wr    : in  std_logic_vector(address_width-1 downto 0);  -- 10-bit byte address
        din        : in  std_logic_vector(31 downto 0);
        addr_rd1   : in  std_logic_vector(address_width-1 downto 0);
        addr_rd2   : in  std_logic_vector(address_width-1 downto 0);
        dout1      : out std_logic_vector(31 downto 0);
        dout2      : out std_logic_vector(31 downto 0)
    );
end component;

component sevseg is 
port(
	input: in std_logic_vector(3 downto 0);
	output: out std_logic_vector(6 downto 0)
);
end component;

component RV32IMF is 
generic(
data_width:integer:=32;
address_width:integer:=6;
instruction_memory_address_width:integer:=6;
data_memory_address_width:integer:=6;
mantissa_width:integer:=23;
exponent_width:integer:=8;
opcode_length:integer:=7
);
port(
--could use "go" signal that is used to rst control unit and to rst whole pipeline :)
	clk,rst,int:in std_logic;
	I_DATA,current_instruction,data_toread:in std_logic_vector(data_width-1 downto 0);
	RD,WD:out std_logic;
	-- used for LB/U,LH/U,LW
	special_load_store:out std_logic_vector(2 downto 0);
	O_DATA,instruction_pointer,data_pointer,data_towrite:out std_logic_vector(data_width-1 downto 0)
);
end component;

component uart is 
generic(buffer_addresses: integer:=3;
	baud_rate: integer:=115200;
	frequency: integer:=50 --in Mhz 
	);
port(
	clk,rst_tx,rst_rx,send,rx_in,cs,RD_RX,WD_TX: in std_logic;
	tx_buffer_in:in std_logic_vector(7 downto 0);
	tx_buffer_Waddress,rx_buffer_Raddress:in std_logic_vector(buffer_addresses-1 downto 0);
	--bytes recieved/transmitted 
	count_rx,count_tx:out std_logic_vector(buffer_addresses-1 downto 0);
	tx_out,doneTx,doneRx:out std_logic;
	rx_buffer_out:out std_logic_vector(7 downto 0)
);end component;

signal CPU_output,current_instruction,data_toread,data_towrite : std_logic_vector(31 downto 0);
signal data_pointer,instruction_pointer,adjusted_readdata,adjusted_writedata : std_logic_vector(31 downto 0);
signal RD,WD:std_logic;
signal special_load_store: std_logic_vector(2 downto 0);
constant zero: std_logic_vector(31 downto 0):=(others=>'0');
signal byte_en : std_logic_vector(3 downto 0);
signal clk_slow: unsigned(3 downto 0);
begin

-- this is basically an MMU that maps CPU generated addresses to BRAM addresses using func3 field, RD,WD and 2 lsb bits of addresses.

--in code data is in the least byte/half word but our memory writes each byte to specific location, not always in lsbs, hence we scale it as needed
adjusted_writedata<= data_towrite when wd='1' and special_load_store="010" else --SW
							x"000000"&data_towrite(7 downto 0) when special_load_store="000" and wd='1' and data_pointer(1 downto 0)="00" else --SB
							x"0000"&data_towrite(7 downto 0)&x"00" when special_load_store="000" and wd='1' and data_pointer(1 downto 0)="01" else
							x"00"&data_towrite(7 downto 0)&x"0000" when special_load_store="000" and wd='1' and data_pointer(1 downto 0)="10" else
							data_towrite(7 downto 0)&x"000000" when special_load_store="000" and wd='1' and data_pointer(1 downto 0)="11" else
							x"0000"&data_towrite(15 downto 0) when special_load_store="001" and wd='1' and data_pointer(1 downto 0)="00" else --SH
							data_towrite(15 downto 0)&x"0000" when special_load_store="001" and wd='1' and data_pointer(1 downto 0)="10" else 
							data_towrite;

byte_en<="1111" when special_load_store="010" and wd='1' else --SW
			"0001" when special_load_store="000" and wd='1' and data_pointer(1 downto 0)="00" else --SB
			"0010" when special_load_store="000" and wd='1' and data_pointer(1 downto 0)="01" else
			"0100" when special_load_store="000" and wd='1' and data_pointer(1 downto 0)="10" else
			"1000" when special_load_store="000" and wd='1' and data_pointer(1 downto 0)="11" else
			"0011" when special_load_store="001" and wd='1' and data_pointer(1 downto 0)="00" else --SH
			"1100" when special_load_store="001" and wd='1' and data_pointer(1 downto 0)="10" else 	
			"0000";

--read happens as 32 bits, so we need to get the proper byte/half word depending on value of lower 2 address bits
data_toread <= adjusted_readdata when special_load_store="010" else --LW
					(31 downto 8=>adjusted_readdata(7))&adjusted_readdata(7 downto 0) when special_load_store="000" and rd='1' and data_pointer(1 downto 0)="00" else --LB
					(31 downto 8=>adjusted_readdata(15))&adjusted_readdata(15 downto 8) when special_load_store="000" and rd='1' and data_pointer(1 downto 0)="01" else 
					(31 downto 8=>adjusted_readdata(23))&adjusted_readdata(23 downto 16) when special_load_store="000" and rd='1' and data_pointer(1 downto 0)="10" else
					(31 downto 8=>adjusted_readdata(31))&adjusted_readdata(31 downto 24) when special_load_store="000" and rd='1' and data_pointer(1 downto 0)="11" else
					zero(31 downto 8)&adjusted_readdata(7 downto 0) when special_load_store="100" and rd='1' and data_pointer(1 downto 0)="00" else --LBU
					zero(31 downto 8)&adjusted_readdata(15 downto 8) when special_load_store="100" and rd='1' and data_pointer(1 downto 0)="01" else 
					zero(31 downto 8)&adjusted_readdata(23 downto 16) when special_load_store="100" and rd='1' and data_pointer(1 downto 0)="10" else
					zero(31 downto 8)&adjusted_readdata(31 downto 24) when special_load_store="100" and rd='1' and data_pointer(1 downto 0)="11" else
					(31 downto 16=>adjusted_readdata(15))&adjusted_readdata(15 downto 0) when special_load_store="001" and rd='1' and data_pointer(1 downto 0)="00" else --LH
					(31 downto 16=>adjusted_readdata(31))&adjusted_readdata(31 downto 16) when special_load_store="001" and rd='1' and data_pointer(1 downto 0)="10" else
					zero(31 downto 16)&adjusted_readdata(15 downto 0) when special_load_store="101" and rd='1' and data_pointer(1 downto 0)="00" else --LHU
					zero(31 downto 16)&adjusted_readdata(31 downto 16) when special_load_store="101" and rd='1' and data_pointer(1 downto 0)="10" else
					adjusted_readdata;


RAM0: ram_byteaddressable32 generic map(instruction_memory_address_width,instruction_file_directory0) port map(clk,WD,RD,'1',byte_en,data_pointer(instruction_memory_address_width-1 downto 0),
adjusted_writedata,data_pointer(instruction_memory_address_width-1 downto 0),instruction_pointer(instruction_memory_address_width-1 downto 0),adjusted_readdata,current_instruction);

process(clk,rst)
begin
if rst='1' then clk_slow<=(others=>'0');
elsif(clk'event and clk='1')then 
clk_slow<=clk_slow+1;
end if;
end process;
			
--im using same memory for instructions and data,riscv compiler with custom linker script handle the addresses
THE_CORE:RV32IMF 
generic map(32,address_width,instruction_memory_address_width,instruction_memory_address_width,23,8,7)
port map(clk,rst,int,IN_DATA,current_instruction,data_toread,RD,WD,special_load_store,CPU_output,instruction_pointer,
data_pointer,data_towrite);

WD_en<=wd;
funct3<=special_load_store;
instruction_address<=instruction_pointer;
ram_in<=adjusted_writedata;
ram_out<=adjusted_readdata;
--seven segment display set up, but outputs must be assigned
SEVSEG1:sevseg port map(CPU_output(3 downto 0),sev_seg1);
SEVSEG2:sevseg port map(CPU_output(7 downto 4),sev_seg2);
SEVSEG3:sevseg port map(CPU_output(11 downto 8),sev_seg3);
SEVSEG4:sevseg port map(CPU_output(15 downto 12),sev_seg4);
SEVSEG5:sevseg port map(CPU_output(19 downto 16),sev_seg5);
SEVSEG6:sevseg port map(CPU_output(23 downto 20),sev_seg6);
SEVSEG7:sevseg port map(CPU_output(27 downto 24),sev_seg7);
SEVSEG8:sevseg port map(CPU_output(31 downto 28),sev_seg8);
--changed this to see the addresses when loading to fpga :)
--SEVSEG6:sevseg port map(instruction_pointer(3 downto 0),sev_seg6);
--SEVSEG7:sevseg port map(instruction_pointer(7 downto 4),sev_seg7);
--SEVSEG8:sevseg port map("00"&instruction_pointer(9 downto 8),sev_seg8);


--OUT_DATA<=zero(31 downto instruction_memory_address_width+2)&instruction_pointer(instruction_memory_address_width-1 downto 0)&"00";
OUT_DATA<=CPU_output;
instruction<=current_instruction;
end arch;
