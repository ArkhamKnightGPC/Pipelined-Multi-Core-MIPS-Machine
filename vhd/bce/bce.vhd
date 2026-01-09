library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity bce is
    generic(
        N: natural := 32
    );
    port(
        a:     in  std_ulogic_vector(N-1 downto 0);
        b:     in  std_ulogic_vector(N-1 downto 0);
        bf:    in  std_ulogic_vector(3 downto 0);
        bcres: out std_ulogic
    );
end entity bce;

architecture rtl of bce is
    constant zero: std_ulogic_vector(N-1 downto 0) := (others => '0');
    signal b_or_zero: std_ulogic_vector(N-1 downto 0);
    signal eq,neq,a_lt_zero,a_lte_zero : std_ulogic;
begin
    a_lt_zero <= a(N-1);
    a_lte_zero <= '1' when (a_lt_zero = '1') or (a = zero) else '0';
    b_or_zero <= b and (bf(3) and (not bf(2)));
    compare_ab: entity work.equality_check
        generic map(
            N => N
        )
        port map(
            a => a,
            b => b_or_zero,
            eq => eq,
            neq => neq
        );
    bcres <= ((not bf(3)) and (not bf(2)) and bf(1) and (not bf(0)) and a_lt_zero) or ((not bf(3)) and (not bf(2)) and bf(1) and bf(0) and (not a_lt_zero))
        or (bf(3) and (not bf(2)) and (not bf(1)) and eq) or (bf(3) and (not bf(2)) and bf(1) and neq)
        or (bf(3) and bf(2) and (not bf(1)) and a_lte_zero) or (bf(3) and bf(2) and bf(1) and (not a_lte_zero));
end architecture;