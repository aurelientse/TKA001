LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.GCD_PKG.ALL;



ENTITY GCD_TOP IS
GENERIC (DLEN :NATURAL:= 32);
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
END GCD_TOP;

ARCHITECTURE RTL OF GCD_TOP IS
 
  
SIGNAL xloadflag , yloadflag, rloadflag : STD_LOGIC;
SIGNAL eqflag, ltflag :STD_LOGIC;
SIGNAL xmux_sel, ymux_sel :STD_LOGIC;

BEGIN  
 
 GCG_DATAPATH_INST     : GCD_DATAPATH 
                         PORT MAP (
                                   clk    => clk,
                                   rst_n  => rst_n,
                                   xsel   => xmux_sel,
                                   ysel   => ymux_sel,
                                   xload  => xloadflag ,
                                   yload  => yloadflag ,
                                   gload  => rloadflag ,
                                   xin    => xin,
                                   yin    => yin,
                                   eq     => eqflag, 
                                   lt     => ltflag,
                                   result => result           
                                   );
 
 GCD_CONTROL_UNIT_INST : GCD_CONTROL_UNIT 
                         PORT MAP (
                                   clk   => clk,
                                   rst_n => rst_n,
                                   start => start,
                                   eq    => eqflag, 
                                   lt    => ltflag, 
                                   xsel  => xmux_sel,
                                   xload => xloadflag ,
                                   ysel  => ymux_sel,
                                   yload => yloadflag ,
                                   gload => rloadflag ,
                                   donev => done,
                                   ready => ready
                                   );
 

END RTL;
