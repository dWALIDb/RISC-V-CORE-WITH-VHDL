library ieee;
use ieee.std_logic_1164.all;

entity load_store_unit is 
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
end entity;

architecture arch of load_store_unit is 

signal reg_rdfunct3,reg_wdfunct3 : std_logic_vector(2 downto 0);

constant zero : std_logic_vector(31 downto 0):=(others=>'0');
begin 

process(rd,wd)
begin
if rd'event and rd='1'then reg_rdfunct3<=funct3;end if;
if wd'event and wd='1'then reg_wdfunct3<=funct3;end if;
end process;

--in code data is in the least byte/half word but our memory writes each byte to specific location, not always in lsbs, hence we scale it as needed
ram_in<= cpu_out when wd='1' and reg_wdfunct3="010" else --SW
							x"000000"&cpu_out(7 downto 0) when reg_wdfunct3="000" and wd='1' and current_byte(1 downto 0)="00" else --SB
							x"0000"&cpu_out(7 downto 0)&x"00" when reg_wdfunct3="000" and wd='1' and current_byte(1 downto 0)="01" else
							x"00"&cpu_out(7 downto 0)&x"0000" when reg_wdfunct3="000" and wd='1' and current_byte(1 downto 0)="10" else
							cpu_out(7 downto 0)&x"000000" when reg_wdfunct3="000" and wd='1' and current_byte(1 downto 0)="11" else
							x"0000"&cpu_out(15 downto 0) when reg_wdfunct3="001" and wd='1' and current_byte(1 downto 0)="00" else --SH
							cpu_out(15 downto 0)&x"0000" when reg_wdfunct3="001" and wd='1' and current_byte(1 downto 0)="10" else 
							x"01020304";

byte_en<="1111" when reg_wdfunct3="010" and wd='1' else --SW
			"0001" when reg_wdfunct3="000" and wd='1' and current_byte(1 downto 0)="00" else --SB
			"0010" when reg_wdfunct3="000" and wd='1' and current_byte(1 downto 0)="01" else
			"0100" when reg_wdfunct3="000" and wd='1' and current_byte(1 downto 0)="10" else
			"1000" when reg_wdfunct3="000" and wd='1' and current_byte(1 downto 0)="11" else
			"0011" when reg_wdfunct3="001" and wd='1' and current_byte(1 downto 0)="00" else --SH
			"1100" when reg_wdfunct3="001" and wd='1' and current_byte(1 downto 0)="10" else 	
			"0000";

--read happens as 32 bits, so we need to get the proper byte/half word depending on value of lower 2 address bits
cpu_in <= ram_out when reg_rdfunct3="010" else --LW
					(31 downto 8=>ram_out(7))&ram_out(7 downto 0) when reg_rdfunct3="000" and rd='1' and current_byte(1 downto 0)="00" else --LB
					(31 downto 8=>ram_out(15))&ram_out(15 downto 8) when reg_rdfunct3="000" and rd='1' and current_byte(1 downto 0)="01" else 
					(31 downto 8=>ram_out(23))&ram_out(23 downto 16) when reg_rdfunct3="000" and rd='1' and current_byte(1 downto 0)="10" else
					(31 downto 8=>ram_out(31))&ram_out(31 downto 24) when reg_rdfunct3="000" and rd='1' and current_byte(1 downto 0)="11" else
					zero(31 downto 8)&ram_out(7 downto 0) when reg_rdfunct3="100" and rd='1' and current_byte(1 downto 0)="00" else --LBU
					zero(31 downto 8)&ram_out(15 downto 8) when reg_rdfunct3="100" and rd='1' and current_byte(1 downto 0)="01" else 
					zero(31 downto 8)&ram_out(23 downto 16) when reg_rdfunct3="100" and rd='1' and current_byte(1 downto 0)="10" else
					zero(31 downto 8)&ram_out(31 downto 24) when reg_rdfunct3="100" and rd='1' and current_byte(1 downto 0)="11" else
					(31 downto 16=>ram_out(15))&ram_out(15 downto 0) when reg_rdfunct3="001" and rd='1' and current_byte(1 downto 0)="00" else --LH
					(31 downto 16=>ram_out(31))&ram_out(31 downto 16) when reg_rdfunct3="001" and rd='1' and current_byte(1 downto 0)="10" else
					zero(31 downto 16)&ram_out(15 downto 0) when reg_rdfunct3="101" and rd='1' and current_byte(1 downto 0)="00" else --LHU
					zero(31 downto 16)&ram_out(31 downto 16) when reg_rdfunct3="101" and rd='1' and current_byte(1 downto 0)="10" else
					x"01020304";

end arch;