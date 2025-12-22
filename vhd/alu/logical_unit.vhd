library ieee;
use ieee.std_logic_1164.all;
entity logical_unit is
    generic(
        N: natural := 64
    );
    port(
        a:   in  std_ulogic_vector(N-1 downto 0);
        b:   in  std_ulogic_vector(N-1 downto 0);
        af:  in  std_ulogic_vector(1 downto 0);
        i:   in  std_ulogic;
        res: out std_ulogic_vector(N-1 downto 0)
    );
end entity logical_unit;

architecture rtl of logical_unit is
    signal a_and_b, a_or_b, a_xor_b, a_nor_b, b_lsbs: std_ulogic_vector(N-1 downto 0);
    signal sel_and_or, sel_nor_lsbs, sel_nor_lsbs_xor: std_ulogic_vector(N-1 downto 0);
    signal zeros: std_ulogic_vector(N/2 - 1 downto 0) := (others => '0');
begin
    a_and_b <= a and b;
    a_or_b <= a or b;
    a_xor_b <= a xor b;
    a_nor_b <= not a_or_b;
    b_lsbs <= b(N/2 - 1 downto 0)&zeros;

    g1: entity work.nmux21
        generic map(
            N => N
        )
        port map(
            a => a_and_b,
            b => a_or_b,
            s => af(0),
            z => sel_and_or
        );
    g2: entity work.nmux21
        generic map(
            N => N
        )
        port map(
            a => a_nor_b,
            b => b_lsbs,
            s => i,
            z => sel_nor_lsbs
        );
    g3: entity work.nmux21
        generic map(
            N => N
        )
        port map(
            a => a_xor_b,
            b => sel_nor_lsbs,
            s => af(0),
            z => sel_nor_lsbs_xor
        );
    g4: entity work.nmux21
        generic map(
            N => N
        )
        port map(
            a => sel_and_or,
            b => sel_nor_lsbs_xor,
            s => af(1),
            z => res
        );
end architecture;
