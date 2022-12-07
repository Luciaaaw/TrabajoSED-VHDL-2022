library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP is
    Port ( 
        CLK : in std_logic;
        B_L : in std_logic;
        B_R : in std_logic;
        B_U : in std_logic;
        B_D : in std_logic;
        B_C : in std_logic;
        reset : in std_logic;
        refrescar_anodo : out std_logic_vector(7 downto 0); --vector que pone a 1 el ánodo correspondiente para actualizar
        salida_disp : out std_logic_vector(6 downto 0); --salida de los displays
        led : out std_logic
    );
end TOP;

architecture Behavioral of TOP is

    signal sync_auxL: std_logic;
    signal sync_auxR: std_logic;
    signal sync_auxU: std_logic;
    signal sync_auxD: std_logic;
    signal sync_auxC: std_logic;
    
    signal B_L_aux: std_logic;
    signal B_R_aux: std_logic;
    signal B_U_aux: std_logic;
    signal B_D_aux: std_logic;
    signal B_C_aux: std_logic;
    signal Reset_aux: std_logic;
    
    signal Enable_C: std_logic;
    signal Enable_T: std_logic;
    signal Enable_A: std_logic;
    signal Enable_S: std_logic;

    signal code1_ME : std_logic_vector(3 downto 0);
    signal code2_ME : std_logic_vector(3 downto 0);
    signal code3_ME : std_logic_vector(3 downto 0);
    signal code4_ME : std_logic_vector(3 downto 0);
    signal code5_ME : std_logic_vector(3 downto 0);
    signal code6_ME : std_logic_vector(3 downto 0);
    signal code7_ME : std_logic_vector(3 downto 0);
    signal code8_ME : std_logic_vector(3 downto 0);
    
    signal code1_A : std_logic_vector(3 downto 0);
    signal code2_A : std_logic_vector(3 downto 0);
    signal code3_A : std_logic_vector(3 downto 0);
    signal code4_A : std_logic_vector(3 downto 0);
    signal code5_A : std_logic_vector(3 downto 0);
    signal code6_A : std_logic_vector(3 downto 0);
    signal code7_A : std_logic_vector(3 downto 0);
    signal code8_A : std_logic_vector(3 downto 0);
    
    signal code1_B : std_logic_vector(3 downto 0);
    signal code2_B : std_logic_vector(3 downto 0);
    signal code3_B : std_logic_vector(3 downto 0);
    signal code4_B : std_logic_vector(3 downto 0);
    signal code5_B : std_logic_vector(3 downto 0);
    signal code6_B : std_logic_vector(3 downto 0);
    signal code7_B : std_logic_vector(3 downto 0);
    signal code8_B : std_logic_vector(3 downto 0);
    
    signal code1_C : std_logic_vector(3 downto 0);
    signal code2_C : std_logic_vector(3 downto 0);
    signal code3_C : std_logic_vector(3 downto 0);
    signal code4_C : std_logic_vector(3 downto 0);
    signal code5_C : std_logic_vector(3 downto 0);
    signal code6_C : std_logic_vector(3 downto 0);
    signal code7_C : std_logic_vector(3 downto 0);
    signal code8_C : std_logic_vector(3 downto 0);
    
    signal code1_aux : std_logic_vector(3 downto 0);
    signal code2_aux : std_logic_vector(3 downto 0);
    signal code3_aux : std_logic_vector(3 downto 0);
    signal code4_aux : std_logic_vector(3 downto 0);
    signal code5_aux : std_logic_vector(3 downto 0);
    signal code6_aux : std_logic_vector(3 downto 0);
    signal code7_aux : std_logic_vector(3 downto 0);
    signal code8_aux : std_logic_vector(3 downto 0);
    
    

    COMPONENT GestorEntradas
       PORT (
            CLK : in std_logic;
            B_L : in std_logic;
            B_R : in std_logic;
            B_U : in std_logic;
            B_D : in std_logic;
            B_C : in std_logic;
            reset : in std_logic;
            B_L_out : out std_logic;
            B_R_out : out std_logic;
            B_U_out : out std_logic;
            B_D_out : out std_logic;
            B_C_out : out std_logic;
            reset_out : out std_logic
       );
    END COMPONENT;
    
    COMPONENT fsm
       PORT (
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
    END COMPONENT;

    COMPONENT cronometro
       PORT (
            CLK : in std_logic;
            code1 : out std_logic_vector(3 downto 0);
            code2 : out std_logic_vector(3 downto 0);
            code3 : out std_logic_vector(3 downto 0);
            code4 : out std_logic_vector(3 downto 0);
            code5 : out std_logic_vector(3 downto 0);
            code6 : out std_logic_vector(3 downto 0);
            code7 : out std_logic_vector(3 downto 0);
            code8 : out std_logic_vector(3 downto 0);
            Enable_C : in std_logic;
            Start : in std_logic;
            Pause : in std_logic;
            Reset : in std_logic
       );
    END COMPONENT;
    
    COMPONENT temporizador
       PORT (
            CLK : in std_logic;
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
            Enable_T : in std_logic;
            led : out std_logic
       );
    END COMPONENT;
    
    COMPONENT ajedrez
       PORT (
            CLK : in std_logic;
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
            Enable_A : in std_logic
            --led : out std_logic
       );
    END COMPONENT;
    
    COMPONENT mux 
    PORT (
        Enable_C : in std_logic;
        Enable_T : in std_logic;
        Enable_A : in std_logic;
        Enable_S : in std_logic;
        
        code1_ME : in std_logic_vector(3 downto 0);
        code2_ME : in std_logic_vector(3 downto 0);
        code3_ME : in std_logic_vector(3 downto 0);
        code4_ME : in std_logic_vector(3 downto 0);
        code5_ME : in std_logic_vector(3 downto 0);
        code6_ME : in std_logic_vector(3 downto 0);
        code7_ME : in std_logic_vector(3 downto 0);
        code8_ME : in std_logic_vector(3 downto 0);
    
        code1_A : in std_logic_vector(3 downto 0);
        code2_A : in std_logic_vector(3 downto 0);
        code3_A : in std_logic_vector(3 downto 0);
        code4_A : in std_logic_vector(3 downto 0);
        code5_A : in std_logic_vector(3 downto 0);
        code6_A : in std_logic_vector(3 downto 0);
        code7_A : in std_logic_vector(3 downto 0);
        code8_A : in std_logic_vector(3 downto 0);
    
        code1_B : in std_logic_vector(3 downto 0);
        code2_B : in std_logic_vector(3 downto 0);
        code3_B : in std_logic_vector(3 downto 0);
        code4_B : in std_logic_vector(3 downto 0);
        code5_B : in std_logic_vector(3 downto 0);
        code6_B : in std_logic_vector(3 downto 0);
        code7_B : in std_logic_vector(3 downto 0);
        code8_B : in std_logic_vector(3 downto 0);
    
        code1_C : in std_logic_vector(3 downto 0);
        code2_C : in std_logic_vector(3 downto 0);
        code3_C : in std_logic_vector(3 downto 0);
        code4_C : in std_logic_vector(3 downto 0);
        code5_C : in std_logic_vector(3 downto 0);
        code6_C : in std_logic_vector(3 downto 0);
        code7_C : in std_logic_vector(3 downto 0);
        code8_C : in std_logic_vector(3 downto 0);
        
        code1 : out std_logic_vector(3 downto 0);
        code2 : out std_logic_vector(3 downto 0);
        code3 : out std_logic_vector(3 downto 0);
        code4 : out std_logic_vector(3 downto 0);
        code5 : out std_logic_vector(3 downto 0);
        code6 : out std_logic_vector(3 downto 0);
        code7 : out std_logic_vector(3 downto 0);
        code8 : out std_logic_vector(3 downto 0)
    );
    END COMPONENT;
    

    COMPONENT GestorDisplay
       PORT (
        CLK : in std_logic;
        code1 : in std_logic_vector(3 downto 0);
        code2 : in std_logic_vector(3 downto 0);
        code3 : in std_logic_vector(3 downto 0);
        code4 : in std_logic_vector(3 downto 0);
        code5 : in std_logic_vector(3 downto 0);
        code6 : in std_logic_vector(3 downto 0);
        code7 : in std_logic_vector(3 downto 0);
        code8 : in std_logic_vector(3 downto 0);
        refrescar_anodo : out std_logic_vector(7 downto 0);
        salida_disp : out std_logic_vector(6 downto 0)
       );
    END COMPONENT;      
       
begin

    Entradas : GestorEntradas PORT MAP(
        CLK => CLK,
        B_L => B_L,
        B_R => B_R,
        B_U => B_U,
        B_D => B_D,
        B_C => B_C,
        reset => reset,
        B_L_out => B_L_aux,
        B_R_out => B_R_aux,
        B_U_out => B_U_aux,
        B_D_out => B_D_aux,
        B_C_out => B_C_aux,
        reset_out => Reset_aux
    );
    
    MaquinaEstados : fsm PORT MAP(
        clk=>clk,
        B1=>B_U_aux,
        B2=>B_D_aux,
        B3=>B_R_aux,
        B4=>B_L_aux,
        B5=>B_C_aux,
        code1=>code1_ME,
        code2=>code2_ME,
        code3=>code3_ME,
        code4=>code4_ME,
        code5=>code5_ME,
        code6=>code6_ME,
        code7=>code7_ME,
        code8=>code8_ME,
        Reset=>Reset,
        Enable_C=>Enable_C,
        Enable_T=>Enable_T,
        Enable_A=>Enable_A,
        Enable_S=>Enable_S
    );
    
    Modo_Cronometro : cronometro PORT MAP(
        CLK=>clk,
        code1=>code1_A,
        code2=>code2_A,
        code3=>code3_A,
        code4=>code4_A,
        code5=>code5_A,
        code6=>code6_A,
        code7=>code7_A,
        code8=>code8_A,
        Enable_C=>Enable_C,
        Start=>B_C_aux,
        Pause=>B_D_aux,
        Reset=>B_L_aux
    );
    
    Modo_Temporizador : temporizador PORT MAP(
        CLK=>clk,
        code1=>code1_B,
        code2=>code2_B,
        code3=>code3_B,
        code4=>code4_B,
        code5=>code5_B,
        code6=>code6_B,
        code7=>code7_B,
        code8=>code8_B,
        Enable_T=>Enable_T,
        led=>led,
        B1=>B_U_aux,
        B2=>B_D_aux,
        B3=>B_R_aux,
        B4=>B_L_aux,
        B5=>B_C_aux
    );
    
    Modo_Ajedrez : ajedrez PORT MAP(
        CLK=>clk,
        code1=>code1_C,
        code2=>code2_C,
        code3=>code3_C,
        code4=>code4_C,
        code5=>code5_C,
        code6=>code6_C,
        code7=>code7_C,
        code8=>code8_C,
        Enable_A=>Enable_A,
        --led=>led,
        B1=>B_U_aux,
        B2=>B_D_aux,
        B3=>B_R_aux,
        B4=>B_L_aux,
        B5=>B_C_aux
    );
    
    Mux1 : mux PORT MAP(
        Enable_C=>Enable_C,
        Enable_T=>Enable_T,
        Enable_A=>Enable_A,
        Enable_S=>Enable_S,
        
        code1_ME=>code1_ME,
        code2_ME=>code2_ME,
        code3_ME=>code3_ME,
        code4_ME=>code4_ME,
        code5_ME=>code5_ME,
        code6_ME=>code6_ME,
        code7_ME=>code7_ME,
        code8_ME=>code8_ME,
        
        code1_A=>code1_A,
        code2_A=>code2_A,
        code3_A=>code3_A,
        code4_A=>code4_A,
        code5_A=>code5_A,
        code6_A=>code6_A,
        code7_A=>code7_A,
        code8_A=>code8_A,
        
        code1_B=>code1_B,
        code2_B=>code2_B,
        code3_B=>code3_B,
        code4_B=>code4_B,
        code5_B=>code5_B,
        code6_B=>code6_B,
        code7_B=>code7_B,
        code8_B=>code8_B,
        
        code1_C=>code1_C,
        code2_C=>code2_C,
        code3_C=>code3_C,
        code4_C=>code4_C,
        code5_C=>code5_C,
        code6_C=>code6_C,
        code7_C=>code7_C,
        code8_C=>code8_C,
        
        code1=>code1_aux,
        code2=>code2_aux,
        code3=>code3_aux,
        code4=>code4_aux,
        code5=>code5_aux,
        code6=>code6_aux,
        code7=>code7_aux,
        code8=>code8_aux
    );
    
    
    Display : GestorDisplay PORT MAP(
        CLK=>clk,
        code1=>code1_aux,
        code2=>code2_aux,
        code3=>code3_aux,
        code4=>code4_aux,
        code5=>code5_aux,
        code6=>code6_aux,
        code7=>code7_aux,
        code8=>code8_aux,
        refrescar_anodo=>refrescar_anodo,
        salida_disp=>salida_disp
     );




end Behavioral;

