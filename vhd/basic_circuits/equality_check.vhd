library ieee;
use ieee.std_logic_1164.all;
entity equality_check is
    generic(
        N: natural := 32
    );
    port(
        a:   in  std_ulogic_vector(N-1 downto 0);
        b:   in  std_ulogic_vector(N-1 downto 0);
        eq:  out std_ulogic;
        neq: out std_ulogic
    );
end entity equality_check;

architecture rtl of equality_check is
    signal tmp: std_ulogic_vector(N-1 downto 0);
begin
    tmp <= a xor b;
    eq_check: entity work.zero_check
        generic map(
            N => N
        )
        port map(
            a => tmp,
            zero => eq,
            nzero => neq
        );
end architecture;