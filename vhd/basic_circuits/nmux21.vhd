library ieee;
use ieee.std_logic_1164.all;
entity nmux21 is
    generic(
        N: natural := 32
    );
    port(
        a: in  std_ulogic_vector(N-1 downto 0);
        b: in  std_ulogic_vector(N-1 downto 0);
        s: in  std_ulogic;
        z: out std_ulogic_vector(N-1 downto 0)
    );
end entity nmux21;

architecture rtl of nmux21 is
begin
    loop_mux: for i in 0 to N-1 generate
        mux_i: entity work.mux21
            port map(
                a => a(i),
                b => b(i),
                s => s,
                z => z(i)
            );
    end generate;
end architecture rtl;