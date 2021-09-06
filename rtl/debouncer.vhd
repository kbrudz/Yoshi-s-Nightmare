----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:24:23 04/03/2017 
-- Design Name: 
-- Module Name:    debouncer - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debouncer is
    Generic(n : integer := 8);
    Port ( clk : in  STD_LOGIC;
           D : in  STD_LOGIC;
           Q : out  STD_LOGIC;
           Edge_H : out  STD_LOGIC;
           Edge_L : out  STD_LOGIC);
end debouncer;

architecture Behavioral of debouncer is
	signal counter : std_logic_vector(n-1 downto 0):=(others=>'1');
	signal rst_counter : std_logic:='0';
	signal D_reg  : std_logic:='0';
	signal Q_reg1 : std_logic:='0'; 
	signal Q_reg2 : std_logic:='0'; 
begin
process(clk)
begin
if rising_edge(clk)then
	D_reg <= D;
	Q_reg2 <= Q_reg1;
	Edge_H <= not(Q_reg2) and Q_reg1;
    Edge_L <= not(Q_reg1) and Q_reg2;
	if(rst_counter='1')then
		counter <= (others=>'1');
	elsif(counter = 0)then
		Q_reg1 <= D;
	else
		counter <= counter - 1;
	end if;
end if;
end process;
Q <= Q_reg1;
rst_counter <= D_reg xor D;

end Behavioral;

