LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.CALCULATOR_PKG.ALL;


ENTITY CALCULATOR IS
PORT ( 
      clk    : IN  STD_LOGIC;
      rst_n  : IN  STD_LOGIC;
      start  : IN  STD_LOGIC;
      value_a: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
      value_b: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
      done   : OUT STD_LOGIC;
      ready  : OUT STD_LOGIC;
      result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
      );
END CALCULATOR;

ARCHITECTURE RTL OF CALCULATOR IS
 


BEGIN  
 
 GCD_INST : GCD_TOP 
             GENERIC MAP ( DLEN => 32)
             PORT MAP
                  (
                     clk    => clk,
                     rst_n  => rst_n,
                     start  => start,
                     xin    => value_a,
                     yin    => value_b,
                     ready  => ready,
                     done   => done,
                     result => result 
                  );
                  
                  

END RTL;
