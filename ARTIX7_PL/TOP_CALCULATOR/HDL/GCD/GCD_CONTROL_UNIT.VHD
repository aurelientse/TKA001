LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;



ENTITY GCD_CONTROL_UNIT IS
PORT ( 
      clk    : in  STD_LOGIC;
      rst_n  : in  STD_LOGIC;
      start  : in  STD_LOGIC;
      eq     : in  std_logic;
      lt     : in  std_logic;
      xsel   : out std_logic;
      xload  : out std_logic;
      ysel   : out std_logic;
      yload  : out std_logic;
      gload  : out std_logic;
      donev  : out std_logic;
      ready  : out std_logic
      );
END GCD_CONTROL_UNIT;

ARCHITECTURE FSM OF GCD_CONTROL_UNIT IS
 
TYPE STATE_T IS (IDLE, INPUT, TEST0, TEST1, UP_XD, UP_YD, DONE);
SIGNAL C_STATE, N_STATE :STATE_T;
  


BEGIN  
 
 SYNC_FSM_UP:PROCESS(clk)
 BEGIN
  if ( clk'event and clk ='1') then
     if (rst_n ='0') then
         C_STATE <= IDLE;
     else
         C_STATE <= N_STATE;
     end if;
  end if;
 END PROCESS SYNC_FSM_UP;   
   
 
   
 ASYNC_FSM0:PROCESS(C_STATE, start, eq, lt)
 BEGIN
  ready  <= '0';

  CASE (C_STATE) IS
                 WHEN IDLE    => ready   <= '1';
                              if (start ='1') then
                                  N_STATE <= INPUT;
                              end if; 
                 WHEN INPUT   =>
                              N_STATE <= TEST0; 
                 WHEN TEST0   => 
                              if (eq ='1') then
                                  N_STATE <= DONE;                         
                              else
                                  N_STATE <= TEST1; 
                              end if; 
                 WHEN TEST1   =>
                              if (lt ='1') then
                                  N_STATE <= UP_YD;
                              else
                                  N_STATE <= UP_XD;
                              end if;
                 WHEN UP_XD   =>  N_STATE <= TEST0; 
                 WHEN UP_YD   =>  N_STATE <= TEST0;     
                 WHEN DONE    =>  N_STATE <= IDLE;                        
                                                                       
  END CASE;  
 END PROCESS ASYNC_FSM0;
 
 
 
 ASYNC_FSM1:PROCESS(C_STATE)
 BEGIN 
  xload  <= '0';  yload  <= '0';
  xsel   <= '0';  ysel   <= '0';
  gload  <= '0';  donev  <= '0';  
  CASE (C_STATE) IS 
                 WHEN INPUT   =>  xload  <= '1';    yload   <= '1';
                                  xsel   <= '1';    ysel    <= '1';  
                                                                                             
                 WHEN UP_XD   =>  xload  <= '1';  
                 
                 WHEN UP_YD   =>  yload  <= '1';    
                  
                 WHEN DONE    =>  gload  <= '1';   donev   <= '1';   
                              
                                    
                 WHEN OTHERS  =>  NULL;                            
  END CASE;  
 END PROCESS ASYNC_FSM1;
 

END FSM;
