library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_signed.all;

entity CuentaAtras is
    Port (
        CLK : in std_logic;
        Enable_count : in std_logic;
        Reset : in std_logic;
        code1_in : in std_logic_vector(3 downto 0);
        code2_in : in std_logic_vector(3 downto 0);
        code3_in : in std_logic_vector(3 downto 0);
        code4_in : in std_logic_vector(3 downto 0);
        code1_out : out std_logic_vector(3 downto 0);--unidades de segundo
        code2_out : out std_logic_vector(3 downto 0);--decenas de segundo
        code3_out : out std_logic_vector(3 downto 0);--unidades de minuto
        code4_out : out std_logic_vector(3 downto 0);--decenas de minuto
        led : out std_logic
     );
end CuentaAtras;

architecture Behavioral of CuentaAtras is
    
    signal Start_s : std_logic :='0';
    signal Reset_s : std_logic :='1';
    signal Set : std_logic :='1';
    
    
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
    
    
    
    
    maquinaestados : process (Enable_count, Reset)
    begin
        if Enable_count = '1' then --Si está activa la habilitación y Pulsamos botón Start
            Start_s<='1'; --Activamos la señal que habilita en el segundo process la cuenta por cada segundo
            Reset_s<='0'; --Desactivamos la señal que resetea el contador al valor inicial
        elsif Enable_count='0' and Reset='0' then 
            Start_s<='0';
            Reset_s<='0';
        elsif Reset = '1'then
            Reset_s<='1';
        end if;
    end process;
    
    
    
    process (clk, Start_s, Reset_s, Enable_count)
    
    subtype V is integer range 0 to 15;
    variable unit_sec : V :=0;
    variable unit_min : V :=0;
    variable dec_sec : V :=0;
    variable dec_min : V :=0;
    begin
        
        if Reset_s='1' then --Reset prioritario
            unit_sec:=to_integer(unsigned(code1_in));
            dec_sec:=to_integer(unsigned(code2_in));
            unit_min:=to_integer(unsigned(code3_in));
            dec_min:=to_integer(unsigned(code4_in));
            led<='0';
        elsif rising_edge(clk) and Start_s='1' then
            if unit_sec=0 and dec_sec=0 and unit_min=0 and dec_min=0 then
                led<='1';
            elsif unit_sec=0 then
                unit_sec:=9;
                if dec_sec=0 then
                    dec_sec:=5;
                    if unit_min=0 then
                        unit_min:=9;
                        if dec_min=0 then 
                            dec_min:=0;
                        else
                            dec_min:=dec_min-1;
                        end if;
                    else
                        unit_min:=unit_min-1;
                    end if;
                else
                    dec_sec:=dec_sec-1;
                end if;
            else 
                unit_sec:=unit_sec-1;
            end if;
          --elsif rising_edge(clk) and Start_s='0' then
           --unit_sec:=unit_sec;
           --dec_sec:=dec_sec;
           --unit_min:=unit_min;
           --dec_min:=dec_min;
        end if;
        
        code1_out <= std_logic_vector(to_unsigned(unit_sec,code1_out'length));
        code2_out <= std_logic_vector(to_unsigned(dec_sec,code2_out'length));
        code3_out <= std_logic_vector(to_unsigned(unit_min,code3_out'length));
        code4_out <= std_logic_vector(to_unsigned(dec_min,code4_out'length));
    end process;


end Behavioral;