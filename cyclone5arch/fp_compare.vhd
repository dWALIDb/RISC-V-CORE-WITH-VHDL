--module determines if  A exponent is greater when A is positive
--or A exponent is less when both A and B are negative, this leads to determining by exponent 
--else compare mantissa in similar manner to determine the larger mantissa and getting the output 
-- the min is done the other way around 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fp_compare is 
generic(
	operand_width:integer:=32;
	mantissa_width:integer:=23;
	exponent_width:integer:=8
);
port(
	A,B:in std_logic_vector(operand_width-1 downto 0);
	a_eq_b,a_lt_b,a_gt_b: out std_logic;
	max,min:out std_logic_vector(operand_width-1 downto 0)
);
end fp_compare;
architecture arch of fp_compare is
signal larger_positive,larger_negative,larger_mantissa_positive,larger_mantissa_negative:std_logic;
signal equal_exponent,greater_exponent,greater_mantissa,exponent_decision,mantissa_decision:std_logic; --assuming for A else we output B
signal output_max,output_min:std_logic_vector(operand_width-1 downto 0);

-- Component extractions for A
    signal sign_A : std_logic;
    signal exp_A  : unsigned(exponent_width-1 downto 0);
    signal mant_A : unsigned(mantissa_width-1 downto 0);
    
    -- Component extractions for B
    signal sign_B : std_logic;
    signal exp_B  : unsigned(exponent_width-1 downto 0);
    signal mant_B : unsigned(mantissa_width-1 downto 0);
    
    -- Combined magnitudes (Bits 30 down to 0) to compare absolute size quickly
    signal mag_A  : unsigned(operand_width-1 downto 0);
    signal mag_B  : unsigned(operand_width-1 downto 0);

begin 
larger_positive<='1' when (greater_exponent='1' and A(operand_width-1)='0') else '0';

larger_negative<='1' when (greater_exponent='0' and A(operand_width-1)='1' and B(operand_width-1)='1') else '0';

larger_mantissa_positive<='1' when (equal_exponent='1' and greater_mantissa='1' and A(operand_width-1)='0') else '0';

larger_mantissa_negative<='1' when (equal_exponent='1' and greater_mantissa='0' and A(operand_width-1)='1' and B(operand_width-1)='1') else '0';

equal_exponent<='1' when a(operand_width-2 downto operand_width-exponent_width-1)=B(operand_width-2 downto operand_width-exponent_width-1) else '0';

greater_exponent<='1' when a(operand_width-2 downto operand_width-exponent_width-1)>B(operand_width-2 downto operand_width-exponent_width-1) else '0';

greater_mantissa<='1' when a(mantissa_width-1 downto 0)>B(mantissa_width-1 downto 0) else '0';

exponent_decision<='1' when ((larger_negative='1' or larger_positive='1') and equal_exponent='0') else '0';

mantissa_decision<='1' when ((larger_mantissa_negative='1' OR larger_mantissa_positive='1') and equal_exponent='1') else '0';

output_max<=A when exponent_decision='1' or (mantissa_decision='1' AND exponent_decision='0') or A(operand_width-1)='0' else B;

output_min<=A when exponent_decision='0' and  mantissa_decision='0' and A(operand_width-1)='1' else B;


-- Slice out the IEEE 754 fields
    sign_A <= A(operand_width-1);
    exp_A  <= unsigned(A(operand_width-2 downto mantissa_width));
    mant_A <= unsigned(A(mantissa_width-1 downto 0));
    
    sign_B <= B(operand_width-1);
    exp_B  <= unsigned(B(operand_width-2 downto mantissa_width));
    mant_B <= unsigned(B(mantissa_width-1 downto 0));

    -- Grab the full magnitude (Exponent + Mantissa) as one continuous vector
    mag_A  <= unsigned(A(operand_width-1 downto 0));
    mag_B  <= unsigned(B(operand_width-1 downto 0));

    process(sign_A, sign_B, mag_A, mag_B)
    begin
        -- Reset outputs
        a_eq_b <= '0';
        a_lt_b <= '0';
        a_gt_b <= '0';

        -- 1. Edge Case: Check for Positive and Negative Zero equality (+0.0 == -0.0)
        if (mag_A = 0) and (mag_B = 0) then
            a_eq_b <= '1';
            
        -- 2. Signs are different
        elsif sign_A /= sign_B then
            if sign_A = '1' then
                a_lt_b <= '1'; -- A is negative, B is positive -> A < B
            else
                a_gt_b <= '1'; -- A is positive, B is negative -> A > B
            end if;
            
        -- 3. Both numbers are Positive
        elsif sign_A = '0' then
            if mag_A = mag_B then
                a_eq_b <= '1';
            elsif mag_A < mag_B then
                a_lt_b <= '1';
            else
                a_gt_b <= '1';
            end if;
            
        -- 4. Both numbers are Negative (Magnitudes invert algebra: larger magnitude means smaller number)
        else 
            if mag_A = mag_B then
                a_eq_b <= '1';
            elsif mag_A > mag_B then
                a_lt_b <= '1'; -- e.g., -5.0 has a larger magnitude than -2.0, so -5.0 < -2.0
            else
                a_gt_b <= '1';
            end if;
        end if;
    end process;

min<=output_min;

max<=output_max;
end arch;