library ieee;
context ieee.ieee_std_context;

entity actuator is
  port (
    CLK: in  std_logic;
    RST: in  std_logic;
    EN:  in  std_logic;
    I:   in  std_logic_vector(7 downto 0);
    O:   out std_logic_vector(7 downto 0)
  );
end entity;

architecture arch of actuator is

begin

O <= I;

end arch;