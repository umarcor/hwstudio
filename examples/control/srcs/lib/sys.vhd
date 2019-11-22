library ieee;
context ieee.ieee_std_context;

entity sys is
  port ( CLK, RST: in std_logic;
         R: in std_logic_vector(7 downto 0)
	   );
end entity;

---

library ieee;
context ieee.ieee_std_context;

architecture arch of sys is
  signal i, u, o, p: std_logic_vector(7 downto 0);
  signal cnt_c, cnt_p: unsigned(7 downto 0);
  signal en_c, en_o, en_p, en_i: std_logic;
begin

m_c: entity work.pid
  port map ( CLK, RST, en_c, R, i, u );

m_o: entity work.actuator
  port map ( CLK, RST, en_o, u, o );

m_p: entity work.plant
  port map ( CLK, RST, en_p, o, p );

m_i: entity work.hold
  port map ( CLK, RST, en_i, p, i );

p_clks: process(CLK) begin if rising_edge(CLK) then
  if RST then
    cnt_c <= (others=>'0');
    cnt_p <= (others=>'0');
  else
    cnt_c <= (others=>'0') when cnt_c?=9 else cnt_c+1;
    cnt_p <= (others=>'0') when cnt_c?=90 else cnt_p+1;
  end if;
end if; end process;

en_c <= cnt_c?=1;
en_o <= '1';
en_p <= cnt_p?=1;
en_i <= '1';

end arch;