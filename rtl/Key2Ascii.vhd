----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:29:34 09/25/2009 
-- Design Name: 
-- Module Name:    Key2Ascii - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Key2Ascii is
    Port ( din : in  STD_LOGIC_VECTOR (7 downto 0);
           ascii_code : out  STD_LOGIC_VECTOR (7 downto 0));
end Key2Ascii;

architecture Behavioral of Key2Ascii is

begin
with din select
ascii_code<=
"00110000" when "01000101", -- 0
"00110001" when "00010110", -- 1
"00110010" when "00011110", -- 2
"00110011" when "00100110", -- 3
"00110100" when "00100101", -- 4
"00110101" when "00101110", -- 5
"00110110" when "00110110", -- 6
"00110111" when "00111101", -- 7
"00111000" when "00111110", -- 8
"00111001" when "01000110", -- 9

"01000001" when "00011100", -- A
"01000010" when "00110010", -- B
"01000011" when "00100001", -- C
"01000100" when "00100011", -- D
"01000101" when "00100100", -- E
"01000110" when "00101011", -- F
"01000111" when "00110100", -- G
"01001000" when "00110011", -- H
"01001001" when "01000011", -- I
"01001010" when "00111011", -- J
"01001011" when "01000010", -- K
"01001100" when "01001011", -- L
"01001101" when "00111010", -- M
"01001110" when "00110001", -- N
"01001111" when "01000100", -- 0
"01010000" when "01001101", -- P
"01010001" when "00010101", -- Q
"01010010" when "00101101", -- R
"01010011" when "00011011", -- S
"01010100" when "00101100", -- T
"01010101" when "00111100", -- U
"01010110" when "00101010", -- V
"01010111" when "00011101", -- W
"01011000" when "00100010", -- X
"01011001" when "00110101", -- Y
"01011010" when "00011010", -- Z

"01100000" when "00001110", -- '
"00101101" when "01001110", -- -
"00111101" when "01010101", -- =
"01011011" when "01010100", -- [
"01011101" when "01011011", -- ]
"01011100" when "01011101", -- \
"00111011" when "01001100", -- ;
"00100111" when "01010010", -- `
"00101100" when "01000001", -- ,
"00101110" when "01001001", -- .
"00101111" when "01001010", -- /

"00100000" when "00101001", -- ( space )
"00001101" when "01011010", -- ( enter , cr )
"00001000" when "01100110", -- ( backs pace )

"00101010" when others; -- *
end Behavioral;

