library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity fsm is
    Port ( 
        clk : in std_logic;
        B1 : in std_logic;
        B2 : in std_logic;
        B3 : in std_logic;
        B4 : in std_logic;
        B5 : in std_logic;
        code1 : out std_logic_vector(3 downto 0);
        code2 : out std_logic_vector(3 downto 0);
        code3 : out std_logic_vector(3 downto 0);
        code4 : out std_logic_vector(3 downto 0);
        code5 : out std_logic_vector(3 downto 0);
        code6 : out std_logic_vector(3 downto 0);
        code7 : out std_logic_vector(3 downto 0);
        code8 : out std_logic_vector(3 downto 0);
        Reset : in std_logic;
        Enable_C : out std_logic :='0';
        Enable_T : out std_logic :='0';
        Enable_A : out std_logic :='0';
        Enable_S : out std_logic :='1'
    );
end fsm;

architecture Behavioral of fsm is
 type estados is (cs,ts,as,cf,tf,af);
 signal estadoActual,estadoSiguiente:estados;
    
signal clk_10khz : std_logic;
    COMPONENT clk10khz
       PORT (
              CLK: in  STD_LOGIC;
              clk_1hz : out STD_LOGIC
            );
     END COMPONENT;
    
begin
Inst_clk10khz: clk10khz 
    PORT MAP (
        CLK => CLK,
        CLK_1hz => clk_10khz
    );
    state_reg:process(clk,reset)
    begin
        if reset='1' then 
        estadoActual<=cs;
        elsif rising_edge(clk)then
        estadoActual<=estadoSiguiente;
        end if;
    end process;
    
    gestionmaquinaestados:process(estadoActual,B1,B2,B5)
    begin
        estadoSiguiente<=estadoActual;
        case (estadoActual)is     
        when cs=>
            if B1='1' then
            estadoSiguiente<=ts;
            elsif B2='1' then
            estadosiguiente<=as;
            elsif B5='1' then
            estadoSiguiente<=cf;
            end if;
        when ts=>
            if B1='1' then
            estadoSiguiente<=as;
            elsif B2='1' then
            estadosiguiente<=cs;
            elsif B5='1' then
            estadoSiguiente<=tf;
            end if;
        when as=>
            if B1='1' then
            estadoSiguiente<=cs;
            elsif B2='1' then
            estadosiguiente<=ts;
            elsif B5='1' then
            estadoSiguiente<=af;
            end if;
        when others => estadoSiguiente<=estadoActual;
        end case;
  end process;
    
    SalidasSelModo : process (estadoActual)
    begin
        case(estadoActual) is
        when cs=>
                code1<="1111";
                code2<="1111";
                code3<="1111";
                code4<="1111";
                code5<="1111";
                code6<="1111";
                code7<="1111";
                code8<="1010";
                Enable_C<='0';
                Enable_T<='0';
                Enable_A<='0';
                Enable_S<='1';
        when ts=>
                code1<="1111";
                code2<="1111";
                code3<="1111";
                code4<="1111";
                code5<="1111";
                code6<="1111";
                code7<="1111";
                code8<="1100";
                Enable_C<='0';
                Enable_T<='0';
                Enable_A<='0';
                Enable_S<='1';
         when as=>
                code1<="1111";
                code2<="1111";
                code3<="1111";
                code4<="1111";
                code5<="1111";
                code6<="1111";
                code7<="1111";
                code8<="1110";
                Enable_C<='0';
                Enable_T<='0';
                Enable_A<='0';
                Enable_S<='1';
         when cf=>
                Enable_C<='1';
                Enable_T<='0';
                Enable_A<='0';
                Enable_S<='0';
         when tf=>
                Enable_C<='0';
                Enable_T<='1';
                Enable_A<='0';
                Enable_S<='0';
         when af=>
                Enable_C<='0';
                Enable_T<='0';
                Enable_A<='1';
                Enable_S<='0';
        end case;                  
    end process;
    
end Behavioral;
