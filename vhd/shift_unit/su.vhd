library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
entity su is
    generic(
        N: natural := 32;
        K: natural := integer(ceil(log2(Real(N))))
    );
    port(
        a:     in  std_ulogic_vector(N-1 downto 0);
        b:     in  std_ulogic_vector(K-1 downto 0);
        sf:    in  std_ulogic_vector(1 downto 0);
        sures: out std_ulogic_vector(N-1 downto 0)
    );
end entity su;

architecture rtl of su is
    signal srlc_out, sra_out: std_ulogic_vector(N-1 downto 0);
begin
    logic_shifts: entity work.srlc
        generic map(
            N => N
        )
        port map(
            a => a,
            b => b,
            f => sf(1),
            r => srlc_out
        );
    sra_out <= to_stdlogicvector(to_bitvector(a) sra to_integer(signed(b)));
    select_srlc_sra: entity work.nmux21
        generic map(
            N => N
        )
        port map(
            a => srlc_out,
            b => sra_out,
            s => sf(1) and sf(0),
            z => sures
        );
end architecture;