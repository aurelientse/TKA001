LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;




ENTITY MUX IS
GENERIC ( DLEN :NATURAL:=8);
PORT ( 
      a   : IN  STD_LOGIC_VECTOR (DLEN-1 DOWNTO 0);
      b   : IN  STD_LOGIC_VECTOR (DLEN-1 DOWNTO 0);
      s   : IN  STD_LOGIC;
      x   : OUT STD_LOGIC_VECTOR(DLEN-1 DOWNTO 0)
      );
END MUX;

ARCHITECTURE RTL OF MUX IS
 


BEGIN  
 
 MUX_CORE:PROCESS(a,b,s)
 BEGIN
  if (s='0') then
      x <= a;
  else
      x <= b; 
  end if;
 END PROCESS MUX_CORE;
 
 
   
  
END RTL;
