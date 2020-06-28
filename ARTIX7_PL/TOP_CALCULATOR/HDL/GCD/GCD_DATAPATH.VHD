LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.GCD_DATAPATH_PKG.ALL;



ENTITY GCD_DATAPATH IS
GENERIC (DLEN :NATURAL:=32);
PORT ( 
      clk    : in  std_logic;
      rst_n  : in  std_logic;
      xsel   : in  std_logic;
      ysel   : in  std_logic;
      xload  : in  std_logic;
      yload  : in  std_logic;
      gload  : in  std_logic;
      xin    : in  std_logic_vector(DLEN-1 downto 0);
      yin    : in  std_logic_vector(DLEN-1 downto 0);
      eq     : out std_logic;
      lt     : out std_logic;
      result : out std_logic_vector(DLEN-1 downto 0)
      );
END GCD_DATAPATH;


ARCHITECTURE DATAPATH OF GCD_DATAPATH IS
 

SIGNAL x, y, x1, y1, xmy, ymx :std_logic_vector(DLEN-1 downto 0):=(others =>'0');


BEGIN  

 xmy <= std_logic_vector ( signed(x)- signed(y) );
 ymx <= std_logic_vector ( signed(y)- signed(x) );

 
 
 EQUAL:PROCESS(x, y)
 BEGIN
  if ( signed (x) = signed (y) ) then
       eq <='1';
       lt <='0';
  else
       eq <='0';
       if ( signed(x) < signed (y)) then
            lt <= '1';
       else
            lt <= '0';
       end if;
  end if;
 END PROCESS EQUAL;   
   
 
 
 -- 
 X_MUX : GCD_MUX  GENERIC MAP ( DLEN => DLEN ) 
                PORT MAP (
                                a => xmy,
                                b => xin,
                                s => xsel,
                                x => x1);
                                
 Y_MUX : GCD_MUX  GENERIC MAP ( DLEN => DLEN) 
                  PORT MAP ( 
                                a => ymx,
                                b => yin,
                                s => ysel,
                                x => y1);

 
 X_REG : GCD_REG GENERIC MAP (DLEN => DLEN)
                 PORT MAP (
                              clk   => clk,
                              rst_n => rst_n,
                              Load  => xload,
                              d     => x1,
                              q     => x );
                    
 Y_REG : GCD_REG GENERIC MAP ( DLEN => DLEN)
                 PORT MAP (
                              clk   => clk,
                              rst_n => rst_n,
                              Load  => yload,
                              d     => y1,
                              q     => y );
                             
  R_REG : GCD_REG GENERIC MAP ( DLEN => DLEN)
                  PORT MAP (
                              clk   => clk,
                              rst_n => rst_n,
                              Load  => gload,
                              d     => x,
                              q     => result);
END DATAPATH;
