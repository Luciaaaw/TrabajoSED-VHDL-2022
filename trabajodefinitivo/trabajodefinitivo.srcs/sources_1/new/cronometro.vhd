library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity cronometro is
    generic(
        width:positive:=3
        );
    Port (
        CLK : in std_logic;
        code1 : out std_logic_vector(width downto 0);
        code2 : out std_logic_vector(width downto 0);
        code3 : out std_logic_vector(width downto 0);
        code4 : out std_logic_vector(width downto 0);
        code5 : out std_logic_vector(width downto 0);
        code6 : out std_logic_vector(width downto 0);
        code7 : out std_logic_vector(width downto 0);
        code8 : out std_logic_vector(width downto 0);
        Enable_C : in std_logic;
        Start : in std_logic;
        Pause : in std_logic;
        Reset : in std_logic
     );
end cronometro;

architecture Behavioral of cronometro is
    
    signal Start_s : std_logic :='0';
    signal Reset_s : std_logic :='0';
    
    signal clk_1hz : std_logic;
    
    COMPONENT clk1hz
       PORT (
              CLK: in  STD_LOGIC;
              clk_1hz : out STD_LOGIC
            );
       END COMPONENT;
       
    begin
    Inst_clk1hz: clk1hz 
    PORT MAP (
        CLK => CLK,
        CLK_1hz => clk_1hz
    );
    
    maquinaestados : process (Enable_C,Start,Pause,Reset)
    begin
        if Enable_C = '1' and Start = '1' and Pause = '0'then
            Start_s<='1';
            Reset_s<='0';
        elsif Pause='1' then
            Start_s<='0';
            Reset_s<='0';
        elsif Reset = '1'then
            Reset_s<='1';
        end if;
    end process;
    
    
    
    
    process (clk_1hz, Start_s, Reset_s)
    subtype V is integer range 0 to 15;
    variable unit_sec : V :=0;
    variable unit_min : V :=0;
    variable dec_sec : V :=0;
    variable dec_min : V :=0;
    begin
        
        if Reset_s='1' then
                unit_sec:=0;
                dec_sec:=0;
                unit_min:=0;
                dec_min:=0;
        elsif rising_edge(clk_1hz) and Start_s='1' then
            unit_sec:=unit_sec+1;
            if unit_sec=10 then
            unit_sec:=0;
            dec_sec:=dec_sec+1;
                if dec_sec=6 then
                    dec_sec:=0;
                    unit_min:=unit_min+1;
                    if unit_min=10 then
                        unit_min:=0;
                        dec_min:=dec_min+1;
                        if dec_min=9 then
                            dec_min:=0;
                            unit_min:=0;
                            dec_sec:=0;
                            unit_sec:=0;
                        end if;
                    end if;
                end if;
                
            end if;
            
        end if;
        
        code1 <= std_logic_vector(to_unsigned(unit_sec,code8'length));
        code2 <= std_logic_vector(to_unsigned(dec_sec,code7'length));
        code3 <= std_logic_vector(to_unsigned(unit_min,code6'length));
        code4 <= std_logic_vector(to_unsigned(dec_min,code5'length));
    end process;
    
    Marca_cron : process (Enable_C)
    begin
    if Enable_C='1' then
        code8<="1010";
        code7<="1011";
        code6<="1111";
        code5<="1111";
    end if;
    end process;
    
    
end Behavioral;