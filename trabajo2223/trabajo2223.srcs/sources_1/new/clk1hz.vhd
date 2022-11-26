library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity clk1Hz is
    Port (
        CLK: in  STD_LOGIC;
        CLK_1hz : out STD_LOGIC
    );
end clk1Hz;
 
architecture Behavioral of clk1Hz is
    signal temp: STD_LOGIC;
    signal count: integer range 0 to 49999999 := 0;
begin
    divisor_frec: process (CLK) begin        
        if rising_edge(CLK) then
            if (count = 49999999) then
                temp <= NOT(temp);
                count <= 0;
            else
                count <= count+1;
            end if;
        end if;
    end process;
    
    CLK_1hz <= temp;
    
end Behavioral;