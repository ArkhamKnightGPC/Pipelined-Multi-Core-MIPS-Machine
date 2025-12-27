library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
entity slc is
    generic(
        N: natural := 32;
        K: natural := integer(ceil(log2(Real(N))))
    );
    port(
        a: in std_ulogic_vector(N-1 downto 0);
        b: in std_ulogic_vector(K-1 downto 0);
        r: out std_ulogic_vector(N-1 downto 0)
    );
end entity slc;

architecture rtl of slc is
    subtype word is std_ulogic_vector(N-1 downto 0);
    type bslc_interconnections is array(0 to K-1) of word;
    signal shift_res: bslc_interconnections;
begin

    bslc_0: entity work.bslc
        generic map(
            N => N,
            b => 1
        )
        port map(
            a => a,
            s => b(0),
            z => shift_res(0)
        );
    bslc_stack: for i in 1 to K-1 generate
        bslc_i: entity work.bslc
            generic map(
                N => N,
                b => 2**i
            )
            port map(
                a => shift_res(i-1),
                s => b(i),
                z => shift_res(i)
            );
    end generate;
    r <= shift_res(K-1);
end architecture;