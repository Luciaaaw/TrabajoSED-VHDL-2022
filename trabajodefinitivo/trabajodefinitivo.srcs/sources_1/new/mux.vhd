library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    Port (
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
end mux;

architecture Behavioral of mux is
    
begin
    process(Enable_C,Enable_T,Enable_A,Enable_S)
    begin
        if Enable_C='1' then 
            code1<=code1_A;
            code2<=code2_A;
            code3<=code3_A;
            code4<=code4_A;
            code5<=code5_A;
            code6<=code6_A;
            code7<=code7_A;
            code8<=code8_A;
        elsif Enable_T='1' then 
            code1<=code1_B;
            code2<=code2_B;
            code3<=code3_B;
            code4<=code4_B;
            code5<=code5_B;
            code6<=code6_B;
            code7<=code7_B;
            code8<=code8_B;
        elsif Enable_A='1' then
            code1<=code1_C;
            code2<=code2_C;
            code3<=code3_C;
            code4<=code4_C;
            code5<=code5_C;
            code6<=code6_C;
            code7<=code7_C;
            code8<=code8_C;
        elsif Enable_S='1' then
            code1<=code1_ME;
            code2<=code2_ME;
            code3<=code3_ME;
            code4<=code4_ME;
            code5<=code5_ME;
            code6<=code6_ME;
            code7<=code7_ME;
            code8<=code8_ME;
        end if;
    end process;
end Behavioral;
