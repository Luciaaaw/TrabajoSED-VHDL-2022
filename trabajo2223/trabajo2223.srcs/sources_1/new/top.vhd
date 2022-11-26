library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
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
end top;

architecture Behavioral of top is

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




    
    signal code1_A : std_logic_vector(3 downto 0);
    signal code2_A : std_logic_vector(3 downto 0);
    signal code3_A : std_logic_vector(3 downto 0);
    signal code4_A : std_logic_vector(3 downto 0);
    signal code5_A : std_logic_vector(3 downto 0);
    signal code6_A : std_logic_vector(3 downto 0);
    signal code7_A : std_logic_vector(3 downto 0);
    signal code8_A : std_logic_vector(3 downto 0);

    
    signal code1_aux : std_logic_vector(3 downto 0);
    signal code2_aux : std_logic_vector(3 downto 0);
    signal code3_aux : std_logic_vector(3 downto 0);
    signal code4_aux : std_logic_vector(3 downto 0);
    signal code5_aux : std_logic_vector(3 downto 0);
    signal code6_aux : std_logic_vector(3 downto 0);
    signal code7_aux : std_logic_vector(3 downto 0);
    signal code8_aux : std_logic_vector(3 downto 0);
    
    

    COMPONENT GestionEntradas
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
    

    COMPONENT Modo_Crono
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
            Enable_A : in std_logic;
            Start : in std_logic;
            Pause : in std_logic;
            Reset : in std_logic
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

    GestorEntradas1 : GestionEntradas PORT MAP(
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
      
    Modo_Crono1 : Modo_Crono PORT MAP(
        CLK=>clk,
        code1=>code1_aux,
        code2=>code2_aux,
        code3=>code3_aux,
        code4=>code4_aux,
        code5=>code5_aux,
        code6=>code6_aux,
        code7=>code7_aux,
        code8=>code8_aux,
        Enable_A=>'1',
        Start=>B_C_aux,
        Pause=>B_D_aux,
        Reset=>B_L_aux
    );
     
    GestorDisplay1 : GestorDisplay PORT MAP(
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