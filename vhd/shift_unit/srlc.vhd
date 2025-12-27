library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
entity srlc is
    generic(
        N: natural := 32;
        K: natural := integer(ceil(log2(Real(N))))
    );
    port(
        a: in  std_ulogic_vector(N-1 downto 0);
        b: in  std_ulogic_vector(K-1 downto 0);
        f: in  std_ulogic;
        r: out std_ulogic_vector(N-1 downto 0)
    );
end entity srlc;

architecture rtl of srlc is
    signal not_b, neg_b, shift_dist: std_ulogic_vector(K-1 downto 0);
begin
    not_b <= not b;
    convert_to_neg: entity work.nincrementer
        generic map(
            N => K
        )
        port map(
            a => not_b,
            cin => '1',
            s => neg_b,
            cout => open
        );
    select_b: entity work.nmux21
        generic map(
            N => K
        )
        port map(
            a => b,
            b => neg_b,
            s => f,
            z => shift_dist
        );
    perform_shift: entity work.slc
        generic map(
            N => N
        )
        port map(
            a => a,
            b => shift_dist,
            r => r
        );
end architecture;