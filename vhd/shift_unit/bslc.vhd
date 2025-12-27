library ieee;
use ieee.std_logic_1164.all;
entity bslc is
    generic(
        N: natural := 32;
        b: natural := 1
    );
    port(
        a: in std_ulogic_vector(N-1 downto 0);
        s: in std_ulogic;
        z: out std_ulogic_vector(N-1 downto 0)
    );
end entity bslc;

architecture rtl of bslc is
    signal a_pref: std_ulogic_vector(N-b-1 downto 0);
    signal a_suf: std_ulogic_vector(b-1 downto 0);
    signal a_with_shift: std_ulogic_vector(N-1 downto 0);
begin
    a_pref <= a(N-b-1 downto 0);
    a_suf <= a(N-1 downto N-b);
    a_with_shift <= a_pref & a_suf;
    mux: entity work.nmux21
        generic map(
            N => N
        )
        port map(
            a => a,
            b => a_with_shift,
            s => s,
            z => z
        );
end architecture;