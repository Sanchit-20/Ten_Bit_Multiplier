library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity  Controller  is
port (reset     : in std_logic ;
      clk       : in std_logic ;
      START     : in std_logic ;
      LSB       : in std_logic ;
      ADD_cmd   : out std_logic ;
      SHIFT_cmd : out std_logic ;
      LOAD_cmd  : out std_logic ;
      STOP      : out std_logic);
end;
------------------------------------------------------
architecture  rtl  of  Controller  is
signal temp_count : std_logic_vector(3 downto 0);
-- declare states
type state_typ is (IDLE, INIT, TEST, ADD, SHIFT);
signal cur_stat, next_stat : state_typ;
begin
PROCESS(clk, reset, temp_count, cur_stat, next_stat)
BEGIN
	IF RISING_EDGE(clk) THEN
		IF reset = '0' THEN  -- synchronous reset
        		cur_stat <= IDLE;
			temp_count <= "0000";
		ElSE 
		  	IF cur_stat = SHIFT THEN 
				IF temp_count = "1001" THEN
					temp_count <= "0000";
				ElSE
					temp_count <= temp_count + 1;
				END IF;
			END IF;
		cur_stat <= next_stat;
		END IF;
	END IF;
END PROCESS;
next_stat <= INIT WHEN cur_stat = IDLE AND START = '1' ELSE
             IDLE WHEN cur_stat = IDLE AND START = '0' ELSE
             TEST WHEN cur_stat = INIT ELSE
             ADD WHEN cur_stat = TEST AND LSB = '1' ELSE
             SHIFT WHEN cur_stat = TEST AND LSB = '0' ELSE
             SHIFT WHEN cur_stat = ADD ELSE
	     TEST WHEN cur_stat = SHIFT AND temp_count /= "1001" ElSE
             IDLE WHEN cur_stat = SHIFT AND temp_count = "1001";      
 
  STOP <= '1' when cur_stat = IDLE else '0';
  ADD_cmd <= '1' when cur_stat = ADD else '0';
  SHIFT_cmd <= '1' when cur_stat = SHIFT else '0';
  LOAD_cmd <= '1' when cur_stat = INIT else '0';
end rtl;
