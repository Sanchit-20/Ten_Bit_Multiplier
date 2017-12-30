library ieee;
use ieee.std_logic_1164.all;
entity Multiplier is
  port (
        A_in  : in  std_logic_vector(9 downto 0 );
        B_in  : in  std_logic_vector(9 downto 0 );
        clk   : in  std_logic;
        reset : in  std_logic;
        START : in  std_logic;
        RC    : out std_logic_vector(19 downto 0 );
        STOP  : out std_logic);
end Multiplier;
use work.all;
architecture rtl of Multiplier is
  signal ADD_cmd   : std_logic;
  signal Add_out   : std_logic_vector(9 downto 0 );
  signal C_out     : std_logic;
  signal LOAD_cmd  : std_logic;
  signal LSB       : std_logic;
  signal RA        : std_logic_vector(9 downto 0 );
  signal RB        : std_logic_vector(9 downto 0 );
  signal SHIFT_cmd : std_logic;
  component RCA
      port (
            RA      : in  std_logic_vector(9 downto 0 );
            RB      : in  std_logic_vector(9 downto 0 );
            C_out   : out std_logic;
            Add_out : out std_logic_vector(9 downto 0 )
            );
  end component;
  component Controller
      port (
            reset     : in  std_logic;
            clk       : in  std_logic;
            START     : in  std_logic;
            LSB       : in  std_logic;
            ADD_cmd   : out std_logic;
            SHIFT_cmd : out std_logic;
            LOAD_cmd  : out std_logic;
            STOP      : out std_logic
            );
  end component;
  component Multiplicand
      port (
            reset    : in  std_logic;
            A_in     : in  std_logic_vector(9 downto 0 );
	    LOAD_cmd : in std_logic;
	    RA       : out std_logic_vector(9 downto 0 )
            );
  end component;
  component Multiplier_Result
      port (
            reset     : in  std_logic;
            clk       : in  std_logic;
            B_in      : in  std_logic_vector(9 downto 0 );
            LOAD_cmd  : in  std_logic;
            SHIFT_cmd : in  std_logic;
            ADD_cmd   : in  std_logic;
            Add_out   : in  std_logic_vector(9 downto 0 );
            C_out     : in  std_logic;
            RC        : out std_logic_vector(19 downto 0 );
            LSB       : out std_logic;
            RB        : out std_logic_vector(9 downto 0 )
            );
  end component;
begin
  inst_RCA: RCA
    port map (
              RA => RA(9 downto 0),
              RB => RB(9 downto 0),
              C_out => C_out,
              Add_out => Add_out(9 downto 0)
              );
  inst_Controller: Controller
    port map (
              reset => reset,
              clk => clk,
              START => START,
              LSB => LSB,
              ADD_cmd => ADD_cmd,
              SHIFT_cmd => SHIFT_cmd,
              LOAD_cmd => LOAD_cmd,
              STOP => STOP
              );
  inst_Multiplicand: Multiplicand
    port map (
              reset => reset,
              A_in => A_in(9 downto 0),
              LOAD_cmd => LOAD_cmd,
              RA => RA(9 downto 0)
              );
  inst_Multiplier_Result: Multiplier_Result
    port map (
              reset => reset,
              clk => clk,
              B_in => B_in(9 downto 0),
              LOAD_cmd => LOAD_cmd,
              SHIFT_cmd => SHIFT_cmd,
              ADD_cmd => ADD_cmd,
              Add_out => Add_out(9 downto 0),
              C_out => C_out,
              RC => RC(19 downto 0),
              LSB => LSB,
              RB => RB(9 downto 0)
              );
end rtl;
