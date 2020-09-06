LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

LIBRARY WORK;
USE WORK.COMMON_PKG.ALL;


PACKAGE GCD_PKG IS

COMPONENT GCD_CONTROL_UNIT IS
PORT ( 
      clk    : IN  STD_LOGIC;
      rst_n  : IN  STD_LOGIC;
      start  : IN  STD_LOGIC;
      eq     : IN  STD_LOGIC;
      lt     : IN  STD_LOGIC;
      xsel   : OUT STD_LOGIC;
      ysel   : OUT STD_LOGIC;
      xload  : OUT STD_LOGIC;
      yload  : OUT STD_LOGIC;
      gload  : OUT STD_LOGIC;
      donev  : OUT STD_LOGIC;
      ready  : OUT STD_LOGIC
      );
END COMPONENT GCD_CONTROL_UNIT;


COMPONENT GCD_DATAPATH IS
PORT ( 
      clk    : IN  STD_LOGIC;
      rst_n  : IN  STD_LOGIC;
      xsel   : IN  STD_LOGIC;
      ysel   : IN  STD_LOGIC;
      xload  : IN  STD_LOGIC;
      yload  : IN  STD_LOGIC;
      gload  : IN  STD_LOGIC;
      xin    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
      yin    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
      eq     : OUT STD_LOGIC;
      lt     : OUT STD_LOGIC;
      result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
      );
END COMPONENT GCD_DATAPATH;

END PACKAGE GCD_PKG;
