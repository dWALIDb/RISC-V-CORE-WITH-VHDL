-- this file is used for synthesis,and is providing PC,SEVEN SEGMENT DISPLAY
-- the synthesis file directories are used to initialize the memories
-- more outputs are provided to prevent the synthesizer from omitting logic :)
-- MAKE SURE YOU GOT VHDL2008
-- with agressive compilation optimization
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RV32IMF_PROJECT is
generic(
data_width:integer:=32;
address_width:integer:=5;

--UART USES BIT 15 as chip select
instruction_memory_address_width:integer:=16;--bare in mind that 2 lsbs are not used to address ram(word addressable shenanigans)

instruction_file_directory0:string:=
"C:\Users\DELL\Desktop\master_proj\C_python_setp\mif_0.mif"
);
port (
--"rd" must be '1' and "wd" must be '0'
	clk,rst,int,serial_rx:in std_logic;
	IN_DATA:in std_logic_vector(31 downto 0);
	OUT_DATA,instruction_address,instruction:out std_logic_vector(31 downto 0);
	serial_tx,tx_done,rx_done:out std_logic;
	reserved : out std_logic_vector(9 downto 0)
--	sev_seg1,sev_seg2,sev_seg3,sev_seg4,sev_seg5,sev_seg6,sev_seg7,sev_seg8:out std_logic_vector(6 downto 0)--MSB iS a
);end RV32IMF_PROJECT;
architecture arch of RV32IMF_PROJECT is 

component ram_byteaddressable32 is 
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

--	generic (address_width : INTEGER;
--	INIT_FILE:STRING
--	);
--port (
--        clk        : in  std_logic;
--        we,re1,re2         : in  std_logic;
--        byte_en    : in  std_logic_vector(3 downto 0);
--        addr_wr    : in  std_logic_vector(address_width-1 downto 0);  -- 10-bit byte address
--        din        : in  std_logic_vector(31 downto 0);
--        addr_rd1   : in  std_logic_vector(address_width-1 downto 0);
--        addr_rd2   : in  std_logic_vector(address_width-1 downto 0);
--        dout1      : out std_logic_vector(31 downto 0);
--        dout2      : out std_logic_vector(31 downto 0)
--    );
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
	O_DATA,instruction_pointer,data_pointer,data_towrite:out std_logic_vector(data_width-1 downto 0);
	int_ack : out std_logic
);
end component;

component Rx is 
generic(
	baud_rate: integer:=9600;
	frequency: integer:=50 --in Mhz
);
port(
	clk,rst: in std_logic;
	D:in std_logic;
	done,ready:out std_logic;
	O:out std_logic_vector(7 downto 0)
);end component;


component uart is 
generic(
	baud_rate: integer:=115200;
	frequency: integer:=50 --in Mhz
	);
port(
	clk,rst,rst_tx,rst_rx,send,cs,rd,wd,int_ack: in std_logic;
	func_select: in std_logic_vector(1 downto 0);
	tx_done,rx_done,tx_ready,rx_ready:out std_logic;
	tx_in:in std_logic_vector(7 downto 0);
	tx_out:out std_logic;
	rx_in :in std_logic;
	rx_out:out std_logic_vector(7 downto 0);
	int :out std_logic
);end component;


component load_store_unit is 
port (
--mapps cpu out/in to ram in/out according to riscv funct3 field and BRAM byte enables :)
		rd,wd: in std_logic;
		current_byte: in std_logic_vector(1 downto 0);
		funct3:in std_logic_vector(2 downto 0);
		ram_out:in std_logic_vector(31 downto 0);
		cpu_out: in std_logic_vector(31 downto 0);
		byte_en:out std_logic_vector(3 downto 0);
		cpu_in: out std_logic_vector(31 downto 0);
		ram_in:out std_logic_vector(31 downto 0)
);
end component;

signal CPU_output,current_instruction,data_toread,data_towrite : std_logic_vector(31 downto 0);
signal data_pointer,instruction_pointer,ram_in,ram_out,cpu_data_in,cpu_data_out: std_logic_vector(31 downto 0);

signal RD,WD:std_logic;
signal special_load_store: std_logic_vector(2 downto 0);

constant zero: std_logic_vector(31 downto 0):=(others=>'0');

signal byte_en,byte_en1 : std_logic_vector(3 downto 0);
signal uart_cs,loopback: std_logic;
signal uart_out:std_logic_vector(7 downto 0);
signal uart_stat:std_logic_vector(1 downto 0);

signal int_ack,int_uart:std_logic;

begin
------------------------------------------__LSUs__---------------------------------------------------------------
LSU0: load_store_unit port map(RD,WD,data_pointer(1 downto 0),special_load_store,ram_out,data_towrite,byte_en,
data_toread,ram_in);

---------------------------------------------__RAMs__--------------------------------------------------							
RAM0: ram_byteaddressable32 generic map(instruction_memory_address_width,instruction_file_directory0) 
port map(clk,(WD and (uart_cs)),(RD and (uart_cs)),'1',byte_en,data_pointer,
ram_in,data_pointer,instruction_pointer,ram_out,current_instruction);

-------------------------------------__UART__-----------------------------------------------------------------
uart_cs<='0'when data_pointer=x"80000000" or data_pointer=x"80000001" or data_pointer=x"80000002" else '1';--address 0x00080000 and so on else cs='1'

UART_DEVICE: uart generic map(115200,50) port map(clk,rst,data_towrite(0),data_towrite(1),data_towrite(4),
uart_cs,RD,WD,int_ack,data_pointer(1 downto 0),tx_done,rx_done,uart_stat(0),uart_stat(1),data_towrite(7 downto 0),
serial_tx,serial_rx,uart_out,int_uart);

-------------------------------------__CPU CORE__-------------------------------------------------------------------
cpu_data_in<= data_toread when uart_cs='1' else
				x"000000"&uart_out when uart_cs='0' and data_pointer(1 downto 0)="10"else
				x"0000000"&uart_stat&"00"  when uart_cs='0' and data_pointer(1 downto 0)="00"
				else (others=>'0');

data_towrite<=cpu_data_out;

--im using same memory for instructions and data,riscv compiler with custom linker script handle the addresses
THE_CORE:RV32IMF generic map(32,address_width,instruction_memory_address_width,instruction_memory_address_width,23,8,7)
port map(clk,rst,int or int_uart,IN_DATA,current_instruction,cpu_data_in,RD,WD,special_load_store,CPU_output,instruction_pointer,
data_pointer,cpu_data_out,int_ack);

instruction_address<=data_pointer(31 downto 24)&instruction_pointer(31 downto 24)&uart_out&uart_stat&current_instruction(5 downto 0);

reserved<=byte_en(2 downto 0)&special_load_store&RD&WD&int_ack&int_uart;

--seven segment display set up, but outputs must be assigned
--SEVSEG1:sevseg port map(CPU_output(3 downto 0),sev_seg1);
--SEVSEG2:sevseg port map(CPU_output(7 downto 4),sev_seg2);
--SEVSEG3:sevseg port map(CPU_output(11 downto 8),sev_seg3);
--SEVSEG4:sevseg port map(CPU_output(15 downto 12),sev_seg4);
--SEVSEG5:sevseg port map(CPU_output(19 downto 16),sev_seg5);
--SEVSEG6:sevseg port map(CPU_output(23 downto 20),sev_seg6);
--SEVSEG7:sevseg port map(CPU_output(27 downto 24),sev_seg7);
--SEVSEG8:sevseg port map(CPU_output(31 downto 28),sev_seg8);
--changed this to see the addresses when loading to fpga :)
--SEVSEG6:sevseg port map(instruction_pointer(3 downto 0),sev_seg6);
--SEVSEG7:sevseg port map(instruction_pointer(7 downto 4),sev_seg7);
--SEVSEG8:sevseg port map("00"&instruction_pointer(9 downto 8),sev_seg8);


--OUT_DATA<=zero(31 downto instruction_memory_address_width+2)&instruction_pointer(instruction_memory_address_width-1 downto 0)&"00";
OUT_DATA<=cpu_data_out(7 downto 0)&cpu_data_in(7 downto 0)&ram_in(7 downto 0)&CPU_output(7 downto 0);
instruction<=current_instruction;
end arch;
