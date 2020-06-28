LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.CALCULATOR_PKG.ALL;


ENTITY CALCULATOR IS
PORT ( 
      clk    : in  std_logic;
      rst_n  : in  std_logic;
      start  : in  std_logic;
      value_a: in  std_logic_vector(31 downto 0);
      value_b: in  std_logic_vector(31 downto 0);
      done   : out  std_logic;
      ready  : out std_logic;
      result : out std_logic_vector(31 downto 0)
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
