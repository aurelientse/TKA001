LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.CALCULATOR_PKG.ALL;


ENTITY CALCULATOR IS
GENERIC (SIZE : NATURAL := 16);
PORT ( 
      clk    : IN  STD_LOGIC;
      rst_n  : IN  STD_LOGIC;
      start  : IN  STD_LOGIC;
      value_a: IN  STD_LOGIC_VECTOR(SIZE-1 DOWNTO 0);
      value_b: IN  STD_LOGIC_VECTOR(SIZE-1 DOWNTO 0);
      opcode : IN  STD_LOGIC_VECTOR(2  DOWNTO 0);
      done   : OUT STD_LOGIC;
      ready  : OUT STD_LOGIC;
      result : OUT STD_LOGIC_VECTOR(2*SIZE-1 DOWNTO 0)
      );
END CALCULATOR;

ARCHITECTURE RTL OF CALCULATOR IS
 


BEGIN 


      --GCD_INST : GCD_TOP GENERIC MAP ( SIZE => SIZE)
                         --PORT MAP    (
                                     -- clk    => clk,
                                     -- rst_n  => rst_n,
                                     -- start  => start,
                                     -- xin    => value_a,
                                     -- yin    => value_b,
                                     -- ready  => ready,
                                     -- done   => done,
                                     -- result => result 
                                    --);
                  

      --DIV_INST : DIV_TOP GENERIC MAP ( SIZE => SIZE)
        --                 PORT MAP    (
          --                          clk    => clk,
            --                        rst_n  => rst_n,
              --                      start  => start,
                --                    xin    => value_a,
                  --                  yin    => value_b,
                    --                ready  => ready,
                      --              done   => done,
                        --            result => result 
                          --    );


     -- SQR_INST : SQR_TOP GENERIC MAP ( SIZE => SIZE)
       --                  PORT MAP    (
         --                           clk    => clk,
           --                         rst_n  => rst_n,
             --                       start  => start,
               --                     xin    => value_a,
                 --                   yin    => value_b,
                   --                 ready  => ready,
                     --               done   => done,
                       --             result => result 
                         --     );  

                              
      ALU_INST : SIMPLE_ALU GENERIC MAP ( SIZE => SIZE)
                        PORT MAP    (
                                    clk    => clk,
                                    rst_n  => rst_n,
                                    start  => start,
                                    xin    => value_a,
                                    yin    => value_b,
                                    opcode => opcode,
                                    ready  => ready,
                                    done   => done,
                                    result => result 
                              ); 
                  

END RTL;
