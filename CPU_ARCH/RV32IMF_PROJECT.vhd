-- this file is used for synthesis,and is providing PC,SEVEN SEGMENT DISPLAY
-- the synthesis file directories are used to initialize the memories
-- more outputs are provided to prevent the synthesizer from omitting logic :)
-- MAKE SURE YOU GOT VHDL2008
library ieee;
use ieee.std_logic_1164.all;

entity RV32IMF_PROJECT is
generic(
data_width:integer:=32;
address_width:integer:=5;
instruction_memory_address_width:integer:=8;------------------------------------------
data_memory_address_width:integer:=8;-------------------------------------------------

instruction_simulation_file_directory:string:= 
"C:\Users\DELL\Desktop\xpack_RISCV_gcc\instructions.txt";

instruction_synthesis_file_directory0:string:=
"C:\Users\DELL\Desktop\xpack_RISCV_gcc\mif_0.mif"

);
port (
--"rd" must be '1' and "wd" must be '0'
	clk,rst,int,programmer_mode,ExtRX:in std_logic;
	IN_DATA:in std_logic_vector(31 downto 0);
	OUT_DATA,instruction_address:out std_logic_vector(31 downto 0);
	txdone,rxdone,comm,programmer_rxdone:out std_logic;
	sev_seg1,sev_seg2,sev_seg3,sev_seg4,sev_seg5,sev_seg6,sev_seg7,sev_seg8:out std_logic_vector(6 downto 0)--MSB iS a
);end RV32IMF_PROJECT;
architecture arch of RV32IMF_PROJECT is 

component ram_byteaddressable32 is 
generic( 
	addresses : integer :=8;
	init_file_directory : string:="C:\Users\DELL\Desktop\xpack_RISCV_gcc\instructions.txt"
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

component RAM_simulation is 
generic(data_width:integer :=32 ;
		address_width:integer:=5;
		simulation_file_directory: string:="C:/Users/brazz/OneDrive/Bureau/FPGA/RV32IMF/data.txt"
);
port(
		clk,RD,wd:in std_logic;
		address:in std_logic_vector(address_width-1 downto 0);
		D:in std_logic_vector(data_width-1 downto 0);
		Q:out std_logic_vector(data_width-1 downto 0)
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

signal CPU_output,current_instruction,data_toread,data_towrite,data_pointer,instruction_pointer:std_logic_vector(31 downto 0);
signal RD,WD:std_logic;
signal special_load_store: std_logic_vector(2 downto 0);
constant zero: std_logic_vector(31 downto 0):=(others=>'0');

begin

-- ram contains both data and code :) read whole word and always for instructions,data depends on the instruction one
RAM0: ram_byteaddressable32 generic map(instruction_memory_address_width,instruction_simulation_file_directory) 
port map(clk,'0','1',RD,WD,data_towrite,special_load_store,"010",special_load_store,
data_pointer(instruction_memory_address_width-1 downto 0),instruction_pointer(instruction_memory_address_width-1 downto 0),
data_pointer(instruction_memory_address_width-1 downto 0),current_instruction,data_toread);

THE_CORE:RV32IMF 
generic map(32,address_width,instruction_memory_address_width,data_memory_address_width,23,8,7)
port map(clk,rst,int,IN_DATA,current_instruction,data_toread,RD,WD,special_load_store,CPU_output,instruction_pointer,data_pointer,data_towrite);



instruction_address<=instruction_pointer;
--seven segment display set up, but outputs must be assigned
SEVSEG1:sevseg port map(CPU_output(3 downto 0),sev_seg1);
SEVSEG2:sevseg port map(CPU_output(7 downto 4),sev_seg2);
SEVSEG3:sevseg port map(CPU_output(11 downto 8),sev_seg3);
SEVSEG4:sevseg port map(CPU_output(15 downto 12),sev_seg4);
SEVSEG5:sevseg port map(CPU_output(19 downto 16),sev_seg5);
--SEVSEG6:sevseg port map(CPU_output(23 downto 20),sev_seg6);
--SEVSEG7:sevseg port map(CPU_output(27 downto 24),sev_seg7);
--SEVSEG8:sevseg port map(CPU_output(31 downto 28),sev_seg8);
--changed this to see the addresses when loading to fpga :)
SEVSEG6:sevseg port map(instruction_pointer(3 downto 0),sev_seg6);
SEVSEG7:sevseg port map(instruction_pointer(7 downto 4),sev_seg7);
SEVSEG8:sevseg port map("00"&instruction_pointer(9 downto 8),sev_seg8);


--OUT_DATA<=zero(31 downto instruction_memory_address_width+2)&instruction_pointer(instruction_memory_address_width-1 downto 0)&"00";
OUT_DATA<=CPU_output;

end arch;
