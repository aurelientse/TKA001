LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


PACKAGE CALCULATOR_PKG IS

COMPONENT GCD_TOP IS
GENERIC (DLEN :NATURAL:=32);
PORT ( 
      clk    : in  std_logic;
      rst_n  : in  std_logic;
      start  : in  std_logic;
      xin    : IN  STD_LOGIC_VECTOR(DLEN-1 DOWNTO 0);
      yin    : IN  STD_LOGIC_VECTOR(DLEN-1 DOWNTO 0);
      ready  : OUT STD_LOGIC;
      done   : OUT STD_LOGIC;
      result : OUT STD_LOGIC_VECTOR (DLEN-1 DOWNTO 0)
      );
END COMPONENT GCD_TOP;

END PACKAGE CALCULATOR_PKG;
