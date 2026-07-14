library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--library PLL;
--use PLL.all;

entity wrapper_around_RV32IMF is 
port(
	clk,rst,int,serial_rx:in std_logic;
	GP_IN:in std_logic_vector(10 downto 0);
	adc_clk : out std_logic;
	serial_tx,tx_done,rx_done,pwm,LED_BUILTIN_GPIO:out std_logic;
	GP_OUT: out std_logic_vector(5 downto 0)
);
end wrapper_around_RV32IMF;

architecture arch of wrapper_around_RV32IMF is 

component RV32IMF_PROJECT is
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
);end component;

signal 	IN_DATA:std_logic_vector(31 downto 0);
signal 	OUT_DATA,instruction_address,instruction:std_logic_vector(31 downto 0);
signal 	reserved :std_logic_vector(9 downto 0);
signal 	counter : unsigned(63 downto 0);

signal   PWM_COUNTER:unsigned(7 downto 0);
signal 	DUTY_CYCLE: std_logic_vector(7 downto 0);
signal 	CLK_DIV	:	std_logic_vector(7 downto 0);
signal 	selected_pwm_clk : std_logic;

signal 	gp_out_reg	:std_logic_vector(5 downto 0);
signal 	gp_in_reg	:std_logic_vector(10 downto 0);
signal 	gp_edge_capture_clk_source :std_logic_vector(7 downto 0); 
signal   gp_in_edge_capture_clk : std_logic;
signal   gp_in_rising_edge: std_logic_vector(31 downto 0);
signal   gp_in_falling_edge: std_logic_vector(31 downto 0);

begin


---- Instantiate the generated PLL
--u_pll: entity PLL.PLL
--port map (
--refclk => clk,      -- input clock
--rst => rst,    -- active-high reset
--outclk_0     => pll_clk_out,    -- 100 MHz output
--locked => pll_locked       -- PLL lock status
-- );
-- -- Assign PLL output to top-level port
--clk_100MHz <= pll_clk_out;



------------------------------------------__CYCLE_COUNTER__------------------------------------------------
process(clk,rst)
begin

if(rst='1') then counter<=(others=>'0');
elsif(clk'event and clk='1') then counter<=counter+1;
	end if;
end process;
----------------------------------------__PWM__----------------------------------------------------------
-- 8 bit PWM with potential to have different clk sources

-- UNUSED						|CLK_DIV				|DUTY CYCLE						|OP CODE|
-- potentially for channels|8bits				|8bits							|8bits|
process(counter(5),rst,counter,selected_pwm_clk)
begin

if(rst='1') then CLK_DIV<=(others=>'0');DUTY_CYCLE<=(others=>'0');
elsif(counter(5)'event and counter(5)='1') then 
	if(OUT_DATA(7 downto 0)=x"80") then DUTY_CYCLE<=OUT_DATA(15 downto 8);
	elsif(OUT_DATA(7 downto 0)=x"82") then CLK_DIV<=OUT_DATA(23 downto 16);
	end if;
	
end if;
end process;

process(rst,counter,selected_pwm_clk)
begin

if(rst='1') then PWM_COUNTER<=(others=>'0');	
elsif(selected_pwm_clk'event and selected_pwm_clk='1') then 
	PWM_COUNTER<=PWM_COUNTER+1;
end if;
end process;

selected_pwm_clk<=clk when CLK_DIV=x"00" else 
						counter(0) when CLK_DIV=x"01" else
						counter(2) when CLK_DIV=x"02" else
						counter(3) when CLK_DIV=x"04" else
						counter(4) when CLK_DIV=x"08" else
						counter(5) when CLK_DIV=x"10" else
						counter(6) when CLK_DIV=x"20" else
						counter(7) when CLK_DIV=x"40" else
						counter(8) when CLK_DIV=x"80" else counter(9);
						
pwm<='1' when unsigned(PWM_COUNTER)<unsigned(DUTY_CYCLE) else '0';

-----------------------------------------__GPIO__--------------------------------------------------
--small output port to outside world :)
--gpio state|OP CODE|
--NOTICE THAT IT STARTS FROM BIT 8 because [7-0] are opcodes :)

process(counter(5),rst,gp_in,out_data)
begin
if(rst='1')then gp_out_reg<=(others=>'0');gp_in_reg<=(others=>'0');
elsif(counter(5)'event and counter(5)='1') then 
	if(OUT_DATA(7 downto 0)=x"40")then gp_out_reg<=OUT_DATA(13 downto 8);end if;
	if(OUT_DATA(7 downto 0)=x"44")then gp_edge_capture_clk_source<=OUT_DATA(15 downto 8);end if;
	gp_in_reg<=GP_IN;
end if;
end process;
GP_OUT<=gp_out_reg;
LED_BUILTIN_GPIO<=gp_out_reg(0);
----------------------------------------__GPIO_EDGE_CAPTURE__--------------------------------------
--capture cycle counter at rising edge of GP_IN:)
gp_in_edge_capture_clk<=gp_in_reg(0) when gp_edge_capture_clk_source=x"00" else 
								gp_in_reg(1) when gp_edge_capture_clk_source=x"01"else 
								'0';
process(rst,gp_in_edge_capture_clk)
begin
if(rst='1')then gp_in_rising_edge<=(others=>'0');
elsif(gp_in_edge_capture_clk'event and gp_in_edge_capture_clk='1') then 
	gp_in_rising_edge<=std_logic_vector(counter(31 downto 0));
end if;
end process;
--capture cycle counter on falling edge :)
process(rst,gp_in_edge_capture_clk)
begin
if(rst='1')then gp_in_falling_edge<=(others=>'0');
elsif(gp_in_edge_capture_clk'event and gp_in_edge_capture_clk='0') then 
	gp_in_falling_edge<=std_logic_vector(counter(31 downto 0));
end if;
end process;
----------------------------------------__ADC__-----------------------------------------------------

adc_clk<=counter(5);--provides around 781.25KHZ for the ADC
--control signals are used as follows
--GP_out(1) -> A
--GP_out(2) -> B
--GP_out(3) -> C
--GP_out(4) -> ALE
--GP_out(5) -> START
-- adc output assumed to be always enabled :)
--GP_IN(2) -> digital_adc_bit0
--GP_IN(3) -> digital_adc_bit1
--GP_IN(4) -> digital_adc_bit2
--GP_IN(5) -> digital_adc_bit3
--GP_IN(6) -> digital_adc_bit4
--GP_IN(7) -> digital_adc_bit5
--GP_IN(8) -> digital_adc_bit6
--GP_IN(9) -> digital_adc_bit7
--GP_IN(10) -> End of Conversion
-----------------------------------------__CPU__----------------------------------------------------
IN_DATA<= std_logic_vector(counter(31 downto 0))   when OUT_DATA(7 downto 0)=x"00" else 
			 std_logic_vector(counter(63 downto 32))  when OUT_DATA(7 downto 0)=x"01"else 
			 x"000000"&DUTY_CYCLE							when OUT_DATA(7 downto 0)=x"81"else
			 x"00000"&"0"&gp_in_reg   						when OUT_DATA(7 downto 0)=x"41"else 
			 gp_in_rising_edge								when OUT_DATA(7 downto 0)=x"42"else 
			 gp_in_falling_edge								when OUT_DATA(7 downto 0)=x"43"else
			 (others=>'0');

RV32IMF_MCU: RV32IMF_PROJECT port map(clk,rst,int,serial_rx,IN_DATA,OUT_DATA,instruction_address,instruction
									,serial_tx,tx_done,rx_done,reserved);


end arch;
