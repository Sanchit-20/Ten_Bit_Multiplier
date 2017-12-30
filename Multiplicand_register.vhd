----------
--2 input nand gate
----------

library ieee;
use ieee.std_logic_1164.all;

entity NAND_2 is
port (	IN1 : in std_logic;
		IN2 : in std_logic;
		OUT1 : out std_logic);
end;
-----------
architecture struct of NAND_2 is
begin 
		OUT1 <= NOT(IN1 AND IN2);
end struct;
------------


-----------
--3 inut nand gate
-----------

library ieee;
use ieee.std_logic_1164.all;

entity NAND_3 is 
port (		IN1 : in std_logic;
		IN2 : in std_logic;
		IN3 : in std_logic;
		OUT1 : out std_logic);
end;
-----------
architecture struct of NAND_3 is
begin
		OUT1 <= NOT(IN1 AND IN2 AND IN3);
end struct;
-----------

library ieee;
use ieee.std_logic_1164.all;

entity DFF is
port (	reset: in std_logic;
		clk:   in std_logic;
		D:     in std_logic;
		Q:     out std_logic);
end;
------------
architecture struc of DFF is

signal NAND_temp : std_logic_vector(6 downto 1);

component NAND_2
port(	IN1:  in std_logic;
		IN2: in std_logic;
		OUT1: out std_logic);
end component;

component NAND_3
port (	IN1: in std_logic;
		IN2: in std_logic;
		IN3: in std_logic;
		OUT1: out std_logic
		);
end component;
 
begin
NAND1: NAND_2 port map (NAND_temp(4), NAND_temp(2), NAND_temp(1));
NAND2: NAND_3 port map (NAND_temp(1), clk, reset, NAND_temp(2));
NAND3: NAND_3 port map (NAND_temp(2), clk, NAND_temp(4), NAND_temp(3));
NAND4: NAND_3 port map (NAND_temp(3), D, reset, NAND_temp(4));
NAND5: NAND_2 port map (NAND_temp(2), NAND_temp(6), NAND_temp(5));
NAND6: NAND_3 port map (NAND_temp(5), NAND_temp(3), reset, NAND_temp(6));
Q <= NAND_temp(5);
end struc;
----------
library ieee;
use ieee.std_logic_1164.all;
entity  Multiplicand  is
port (reset    : in  std_logic ;
      A_in     : in  std_logic_vector (9 downto 0);
      LOAD_cmd : in  std_logic ;
      RA       : out std_logic_vector (9 downto 0));
end;
------------------------------------------------------
architecture  struc  of  Multiplicand  is
component DFF
      port (
            reset  : in  std_logic;
            clk    : in  std_logic;
            D      : in  std_logic;
            Q      : out std_logic
            );
end component;
begin
DFFs: for i in 9 downto 0 generate
    DFFReg:DFF port map (reset, LOAD_cmd, A_in(i), RA(i));
end generate;
end struc;
