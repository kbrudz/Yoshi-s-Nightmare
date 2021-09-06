----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:37:32 08/25/2009 
-- Design Name: 
-- Module Name:    PS2 - Behavioral 
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

entity PS2 is
    Port ( clk, resetn : in  STD_LOGIC;
           -- clear : in  STD_LOGIC; 
           ps2c : in  STD_LOGIC;
           ps2d : in  STD_LOGIC;
           data_valid : out  STD_LOGIC;
           TX_data    : out  STD_LOGIC_VECTOR(7 downto 0);
           start, left, right, up : out  STD_LOGIC);
end PS2;

architecture Behavioral of PS2 is
component debouncer
    Generic(n : integer := 4);
    Port ( clk : in  STD_LOGIC;
           D : in  STD_LOGIC;
           Q : out  STD_LOGIC;
           Edge_H : out  STD_LOGIC;
           Edge_L : out  STD_LOGIC);
end component;
component Key2Ascii
    Port ( din : in  STD_LOGIC_VECTOR (7 downto 0);
           ascii_code : out  STD_LOGIC_VECTOR (7 downto 0));
end component;
signal data_reg, ascii_code : std_logic_vector(7 downto 0);
signal keycode : std_logic_vector(15 downto 0);
signal nPS2C, PS2CLK, PS2DATA, CLK_50MHZ : std_logic;
signal cnt : integer range 0 to 10 := 0;    
signal flag : std_logic := '0';
signal data : std_logic_vector(7 downto 0);
begin
debouner_PS2CLK : debouncer
 Port Map( clk => clk,
           D => ps2c,
           Q => PS2CLK,
           Edge_H => open,
           Edge_L => nPS2C);
debouner_PS2DATA : debouncer
 Port Map( clk => clk,
           D => ps2d,
           Q => PS2DATA,
           Edge_H => open,
           Edge_L => open);
Key2Ascii_inst : Key2Ascii     
    Port Map( din => keycode(15 downto 8),
              ascii_code => ascii_code);
process(clk)
begin
if rising_edge(clk) then
    flag <= '0';
    if(nPS2C='1')then
        case(cnt)is
        when 0 => null;--Start bit
        when 1 => data_reg(0)<=PS2DATA;
        when 2 => data_reg(1)<=PS2DATA;
        when 3 => data_reg(2)<=PS2DATA;
        when 4 => data_reg(3)<=PS2DATA;
        when 5 => data_reg(4)<=PS2DATA;
        when 6 => data_reg(5)<=PS2DATA;
        when 7 => data_reg(6)<=PS2DATA;
        when 8 => data_reg(7)<=PS2DATA;
        when 9 => null;
        when 10=> null;
        end case;
        if(resetn='0')then
            cnt <= 0;
        elsif(cnt=10)then 
            flag <= '1';
            cnt<=0;
        else
            cnt<=cnt+1;
        end if;
    end if;
end if;
end process;
process(clk)
begin
if rising_edge(clk) then
    data_valid <= '0';
    if(resetn='0')then
        keycode <= (others=>'0');
        data    <= (others=>'0');
        data_valid <= '0';
    elsif(keycode(7 downto 0)=x"F0")then
            data_valid <= '1';
            keycode <= (others=>'0');
            data <= ascii_code;
    end if;
    if(flag='1')then
        keycode <= keycode(7 downto 0) & data_reg;
    end if;
--    if(clear='1')then
--        data_valid <= '0';
--    end if;
end if;
end process;
TX_data <= data;
start <= '1' when data="01010011" else '0';
up    <= '1' when data="01010111" else '0'; 
left  <= '1' when data="01000001" else '0';  
right <= '1' when data="01000100" else '0';
--process(flag)
--begin
--if rising_edge(flag) then
--    dout <= data_reg;
--end if;
--end process;
--process(clk)
--begin
--if rising_edge(clk) then
--    CLK_50MHZ <= not CLK_50MHZ;
--end if;
--end process;
--process(CLK_50MHZ)
--begin
--if rising_edge(CLK_50MHZ) then
----    if(resetn='0') then
----        data_reg <= (others=>'0');
----        data_valid <= '0';
----    else
--        data_valid <= '0';
--        if(bit_cnt=22)then
--            bit_cnt <
--            if(data_reg(8 downto 1)=x"F0") then
--                data_reg <= (others=>'0');
--                dout <= data_reg(19 downto 12);
--                data_valid <= '1';
--            end if;
--        end if;
--        if(nPS2C='1')then
--            bit_cnt <= bit_cnt + 1; 
--            data_reg <=PS2DATA & data_reg(21 downto 1);
--        end if;
--    end if;
----end if;
--end process;
end Behavioral;