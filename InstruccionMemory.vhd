
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

--int k = 6


entity InstruccionMemory is
    Port ( address : in  STD_LOGIC_VECTOR (31 downto 0);
           rst : in  STD_LOGIC;
           instruction : out  STD_LOGIC_VECTOR (31 downto 0));
end InstruccionMemory;

architecture syn of InstruccionMemory is
    type rom_type is array (0 to 63) of std_logic_vector (31 downto 0);                 
    signal ROM : rom_type:= ("10100100000100000010000000000000",--mov 0, %l2
										"10100010000100000010000000000101",--mov 5, %l1
										"10000000101001000110000000000000",-- subcc %l1, 0, %g0
										"00000010100000000000000000000100",--be result	
										"10100000000100000010000000000100",-- mov 4, %l0
										"01000000000000000000000000000100",--call suma				
										"10000000000000000010000000000000",--add %g0, 0, %g0
										"00010000100000000000000000001011",--ba fin
										"10010000000101001000000000000000",--or %l2, %g0, %o0
										"10100110000100000010000000000001",--mov 1, %l3
										"10101000000001000000000000010010",--add %l0, %l2, %l4
										"10100100000100000000000000010100",--or  %g0,%l4,%l2
										"10101010000001001110000000000001",--add % l3, 1, %l5
										"10000000101001000100000000010011",--subcc %l1, %l3, %g0
										"00010010101111111111111111111100",--bne opera	
										"10100110000100000000000000010101",--or %g0, %l5, %l3
										"10000001110000111110000000000001",--jmpl %o7, 2, %g0
										"10000000000000000010000000000000",--add %g0, 0, %g0
                            others => "00000000000000000000000000000000");                                              
begin

    process (rst,Address)
    begin
        if (rst = '1') then
            
            instruction <=  "00000000000000000000000000000000"; 
--				Address =>  "00000000000000000000000000000000";  la salida se pone en 0 mientras reset es 1
-- pero cuando este valor es 0 vuelve y toma el actual del address.
			else
				instruction <= ROM(conv_integer(address));
            
        end if;
    end process;


end syn;

