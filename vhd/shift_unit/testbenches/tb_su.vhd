library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
entity tb_su is
end entity tb_su;

architecture test of tb_su is
    constant N: natural := 32;
    constant K: natural := integer(ceil(log2(Real(N))));
    signal a, sures: std_ulogic_vector(N-1 downto 0);
    signal sf: std_ulogic_vector(1 downto 0);
    signal b: std_ulogic_vector(K-1 downto 0);
begin
    dut: entity work.su
        generic map(
            N => N
        )
        port map(
            a => a,
            b => b,
            sf => sf,
            sures => sures
        );
    stimulus: process
    begin
        a <= x"01010101";
        b <= "00111";
        sf <= "00";
        wait for 1 ns;
        assert(sures = x"80808080")report "TEST 1 FAIL" severity failure;
        sf <= "10";
        wait for 1 ns;
        assert(sures = x"02020202")report "TEST 2 FAIL" severity failure;
        sf <= "11";
        wait for 1 ns;
        assert(sures = x"00020202")report "TEST 3 FAIL" severity failure;
        report "ALL TESTS PASSED" severity note;
        wait;
    end process;
end architecture;