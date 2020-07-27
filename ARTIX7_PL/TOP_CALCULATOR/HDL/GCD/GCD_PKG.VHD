LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

LIBRARY WORK;
USE WORK.COMMON_PKG.ALL;


PACKAGE GCD_PKG IS

COMPONENT GCD_CONTROL_UNIT IS
PORT ( 
      clk    : in  std_logic;
      rst_n  : in  std_logic;
      start  : in  std_logic;
      eq     : in  std_logic;
      lt     : in  std_logic;
      xsel   : out std_logic;
      ysel   : out std_logic;
      xload  : out std_logic;
      yload  : out std_logic;
      gload  : out std_logic;
      donev  : out std_logic;
      ready  : out std_logic
      );
END COMPONENT GCD_CONTROL_UNIT;


COMPONENT GCD_DATAPATH IS
PORT ( 
      clk    : in  std_logic;
      rst_n  : in  std_logic;
      xsel   : in  std_logic;
      ysel   : in  std_logic;
      xload  : in  std_logic;
      yload  : in  std_logic;
      gload  : in  std_logic;
      xin    : in  std_logic_vector(31 downto 0);
      yin    : in  std_logic_vector(31 downto 0);
      eq     : out std_logic;
      lt     : out std_logic;
      result : out std_logic_vector(31 downto 0)
      );
END COMPONENT GCD_DATAPATH;

END PACKAGE GCD_PKG;
