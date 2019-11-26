library ieee;
context ieee.ieee_std_context;

entity pid is
  port ( CLK, RST, EN: in std_logic;
         R,I: in std_logic_vector(7 downto 0);
		 O: out std_logic_vector(7 downto 0)
	   );
end entity;

architecture arch of pid is

type t_q is array (natural range 2 downto 0) of signed(7 downto 0);
type t_e is array (natural range 2 downto 0) of signed(7 downto 0);
type t_eq is array (natural range 2 downto 0) of signed(15 downto 0);
type t_u is array (natural range 1 downto 0) of signed(18 downto 0);

constant q: t_q:=("00000100","00000010","00000010");
signal e: t_e;
signal eq: t_eq;
signal u: t_u;

signal s0: signed(16 downto 0);
signal s1: signed(17 downto 0);
signal uraw: signed(19 downto 0);

begin

e(0) <= signed(R)-signed(I);

process(CLK) begin if rising_edge(CLK) then
  if rst then
    u(1) <= (others=>'0');
    e(2) <= (others=>'0');
    e(1) <= (others=>'0');
  elsif EN then
    u(1) <= u(0);
    e(2 downto 1) <= e(1 downto 0);
  end if;
end if;	end process;

ms: for i in 0 to 2 generate
  eq(i) <= e(i) * q(i);
end generate;

s0 <= resize(eq(0),s0'length) + eq(1);
s1 <= resize(s0,s1'length) + eq(2);

uraw <= resize(s1,uraw'length) + u(1);

u(0) <= uraw(18 downto 0) when (uraw(19) xnor uraw(18)) else
     (18 => '0', others=>'1') when (not uraw(19)) else
   (18 => '1', 0 => '1', others=>'0');

O <= std_logic_vector(u(0)(18 downto 11));

end arch;