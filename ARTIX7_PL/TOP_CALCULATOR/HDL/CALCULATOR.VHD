LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;



ENTITY CALCULATOR IS
PORT ( 
      clk    : in std_logic;
      a, b   : in  std_logic_vector(N-1 downto 0);
      sum    : out std_logic_vector(N-1 downto 0);
      ov     : out std_logic
      );
END CALCULATOR;

ARCHITECTURE RTL OF CALCULATOR IS
 
    
BEGIN  
   
   

END RTL;
