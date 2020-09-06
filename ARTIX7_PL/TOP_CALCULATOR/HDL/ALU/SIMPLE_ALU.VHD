LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;



ENTITY SIMPLE_ALU IS
GENERIC (SIZE :NATURAL := 16);
PORT ( 
    clk    : IN  STD_LOGIC;
    rst_n  : IN  STD_LOGIC;
    start  : IN  STD_LOGIC;
    xin    : IN  STD_LOGIC_VECTOR(SIZE-1 DOWNTO 0);
    yin    : IN  STD_LOGIC_VECTOR(SIZE-1 DOWNTO 0);
    opcode : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
    ready  : OUT STD_LOGIC;
    done   : OUT STD_LOGIC;
    result : OUT STD_LOGIC_VECTOR (2*SIZE-1 DOWNTO 0)
);
END SIMPLE_ALU;

ARCHITECTURE RTL OF SIMPLE_ALU IS
SIGNAL tmp_result : STD_LOGIC_VECTOR (2*SIZE-1 DOWNTO 0); 
SIGNAL tmp_done   : STD_LOGIC;
SIGNAL tmp_ready  : STD_LOGIC;

BEGIN 
    
   SYNC_ALU: PROCESS(clk)
   BEGIN 
        if (clk'event and clk='1') then
            if(rst_n ='0') then
               tmp_done   <= '0';
               tmp_ready  <= '1';
            else
                -- Handle control signal                
                if(tmp_done ='1')then 
                   tmp_ready  <= '1';
                else
                   tmp_ready  <= '0';
                end if;
                
                -- Handle ALU 
                if (start ='1') then
                    case (opcode) is
                        when "001"  => 
                                    tmp_result <= std_logic_vector(resize (signed(xin) + signed(yin), tmp_result'length));
                                    tmp_done   <= '1';                                  
                        when "010"  => 
                                    tmp_result <= std_logic_vector(resize (signed(xin) - signed(yin), tmp_result'length));
                                    tmp_done   <= '1';
                        when "011"  => 
                                    tmp_result <= std_logic_vector(resize (signed(xin) * signed(yin), tmp_result'length));
                                    tmp_done   <= '1';
                        when others => NULL;
                    end case;
                else
                    tmp_done   <= '0'; 
                end if;
            end if;
        end if;
   END PROCESS SYNC_ALU;

-- final assignment 
result <= tmp_result;
done   <= tmp_done  ;
ready  <= tmp_ready ;
END RTL; 
