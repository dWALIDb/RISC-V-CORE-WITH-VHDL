-- no parity
-- 8 bits 1 stop bit and 1 start bit
-- write to tx buffer with WD_TX read from rx buffer with RX_RD
-- provide address also :)
-- could use count_tx and count_rx to know if messages are sent or pending
-- cs used to enable chip to write/ recieve data  active low
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart is 
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
);end uart;

architecture arch of uart is 

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

component Tx is 
generic(
	baud_rate: integer:=115200;
	frequency: integer:=50 --in Mhz
);
port(
	clk,rst,send: in std_logic;
	D:in std_logic_vector(7 downto 0);
	O,ready,done:out std_logic
);end component;

signal done_recieve,done_transmit:std_logic;
signal tx_data,rx_data:std_logic_vector(7 downto 0);
signal wrst_tx,wrst_rx,wsend: std_logic;
begin 

tx_done<=done_transmit;
rx_done<=done_recieve;

process(clk,rst)
begin 
-- reset is active high... a long convention made by me for me
-- at least it is consistent along the design files :) 
if rst='1' then tx_data<=(others=>'0');
elsif clk'event and clk='1' then 
	if(cs='0' and wd='1' and func_select="01")then tx_data<=tx_in;
	end if;
	if(cs='0' and wd='1' and func_select="00")then 
	wrst_tx<=rst_tx;wrst_rx<=rst_rx;wsend<=send;
	end if;
end if;
end process;
-- interrupt CPU on every recieved byte
process(done_recieve,int_ack)
begin 
if (rst='1' or int_ack='1')then int<='0';
elsif(done_recieve'event and done_recieve='0') then 
		int<='1';
		end if;
end process;
--

trans:tx generic map(baud_rate,frequency) port map(clk,rst OR wrst_tx,wsend,tx_data,tx_out,tx_ready,done_transmit);
rec:rx generic map(baud_rate,frequency) port map(clk,rst or wrst_rx,rx_in,done_recieve,rx_ready,rx_OUT);

end arch;