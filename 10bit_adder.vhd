
-- 8 bit ripple carry adder. it can de improved by using 4 bit ripple carry adder and make a carry select adder
library ieee;
use ieee.std_logic_1164.all;
entity  Full_Adder  is
port (X     : in  std_logic;
      Y     : in  std_logic;
      C_in  : in  std_logic;
      Sum   : out std_logic ;
      C_out : out std_logic);
end;
------------------------------------------------------
architecture  struc  of  Full_Adder  is
begin
Sum <= X xor Y xor C_in;
C_out <= (X and Y) or (X and C_in) or (Y and C_in);
end struc;

-------------------------------
library ieee;
use ieee.std_logic_1164.all;
entity  RCA  is
port (	RA      : in  std_logic_vector (9 downto 0);
		RB      : in  std_logic_vector (9 downto 0);
		C_out   : out std_logic ;
		Add_out : out std_logic_vector (9 downto 0));
end;
------------------------------------------------------
architecture rtl of RCA is
signal c_temp : std_logic_vector(9 downto 0);
component Full_Adder
	port(
			X: in std_logic;
			Y: in std_logic;
			C_in : in std_logic;
			Sum: out std_logic;
			C_out: out std_logic);
end component;

begin
c_temp(0) <= '0'; -- carry in of RCA is 0
Adders: for i in 9 downto 0 generate
-- assemble first 9 adders from 0 to 8
Low: if i/=9 generate
FA: Full_Adder port map(RA(i), RB(i), c_temp(i), Add_out(i), c_temp(i+1));
	end generate;
-- assemble last adder
High: if i=9 generate
FA: Full_Adder port map (RA(9), RB(9), c_temp(9), Add_out(9), C_out);
	end generate;

end generate;

end rtl;



