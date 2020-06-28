LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;



ENTITY GCD_REG IS
GENERIC ( DLEN :NATURAL:=8);
PORT ( 
      clk    : IN  STD_LOGIC;
      rst_n  : IN  STD_LOGIC;
      Load   : IN  STD_LOGIC;
      d      : IN  STD_LOGIC_VECTOR(DLEN-1 DOWNTO 0);
      q      : OUT STD_LOGIC_VECTOR(DLEN-1 DOWNTO 0)
      );
END GCD_REG;

ARCHITECTURE RTL OF GCD_REG IS
 
BEGIN  
 
 LOAD_P:PROCESS(clk)
 BEGIN
  if ( clk'event and clk ='1') then
     if (rst_n ='0') then
              
     else
        if (Load ='1') then
            q <= d;
        end if;
     end if;
  end if;
 END PROCESS LOAD_P;   


END RTL;
