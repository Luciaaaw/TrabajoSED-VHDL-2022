library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity GestionEntradas is
    Port (
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
end GestionEntradas;

architecture Behavioral of GestionEntradas is
    
    signal sync_auxL: std_logic;
    signal sync_auxR: std_logic;
    signal sync_auxU: std_logic;
    signal sync_auxD: std_logic;
    signal sync_auxC: std_logic;
    signal sync_auxReset: std_logic;
    
    
    COMPONENT SYNCHRNZR
       PORT (
              async_in : IN std_logic;
              clk: IN std_logic;
              sync_out : OUT std_logic
       );
    END COMPONENT;

    COMPONENT EDGEDTCTR
       PORT (
              sync_in : IN std_logic;
              clk: IN std_logic;
              edge : OUT std_logic
       );
    END COMPONENT;
    
begin
    SYNCHRNZR1: SYNCHRNZR PORT MAP(
        ASYNC_IN=>B_L,
        CLK=>clk,
        SYNC_OUT=>sync_auxL
    );

    EDGEDTCTR1: EDGEDTCTR PORT MAP(
        clk=>clk,
        SYNC_IN=>sync_auxL,
        EDGE=>B_L_out
    );

    SYNCHRNZR2: SYNCHRNZR PORT MAP(
        ASYNC_IN=>B_R,
        CLK=>clk,
        SYNC_OUT=>sync_auxR
    );

    EDGEDTCTR2: EDGEDTCTR PORT MAP(
        clk=>clk,
        SYNC_IN=>sync_auxR,
        EDGE=>B_R_out
    );

    SYNCHRNZR3: SYNCHRNZR PORT MAP(
        ASYNC_IN=>B_U,
        CLK=>clk,
        SYNC_OUT=>sync_auxU
    );

    EDGEDTCTR3: EDGEDTCTR PORT MAP(
        clk=>clk,
        SYNC_IN=>sync_auxU,
        EDGE=>B_U_out
    );

    SYNCHRNZR4: SYNCHRNZR PORT MAP(
        ASYNC_IN=>B_D,
        CLK=>clk,
        SYNC_OUT=>sync_auxD
    );

    EDGEDTCTR4: EDGEDTCTR PORT MAP(
        clk=>clk,
        SYNC_IN=>sync_auxD,
        EDGE=>B_D_out
    );

    SYNCHRNZR5: SYNCHRNZR PORT MAP(
        ASYNC_IN=>B_C,
        CLK=>clk,
        SYNC_OUT=>sync_auxC
    );

    EDGEDTCTR5: EDGEDTCTR PORT MAP(
        clk=>clk,
        SYNC_IN=>sync_auxC,
        EDGE=>B_C_out
    );
    
    SYNCHRNZR6: SYNCHRNZR PORT MAP(
        ASYNC_IN=>reset,
        CLK=>clk,
        SYNC_OUT=>sync_auxReset
    );

    EDGEDTCTR6: EDGEDTCTR PORT MAP(
        clk=>clk,
        SYNC_IN=>sync_auxReset,
        EDGE=>reset_out
    );
    
    
end Behavioral;
