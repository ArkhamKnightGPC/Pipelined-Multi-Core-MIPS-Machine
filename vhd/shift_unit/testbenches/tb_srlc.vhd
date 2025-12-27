library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
entity tb_srlc is
end entity tb_srlc;

architecture test of tb_srlc is
    constant N: natural := 32;
    constant K: natural := integer(ceil(log2(Real(N))));
    signal a,r: std_ulogic_vector(N-1 downto 0);
    signal b: std_ulogic_vector(K-1 downto 0);
    signal f: std_ulogic;
begin
    dut: entity work.srlc
        generic map(
            N => N
        )
        port map(
            a => a,
            b => b,
            f => f,
            r => r
        );
    stimulus: process
    begin
        a <= x"00000001";
        b <= "00001";
        f <= '0';
        wait for 1 ns;
        assert(r = x"00000002")report "TEST 1 FAIL" severity failure;
        f <= '1';
        wait for 1 ns;
        assert(r = x"80000000")report "TEST 2 FAIL" severity failure;
        a <= x"01010101";
        b <= "11111";
        f <= '0';
        wait for 1 ns;
        assert(r = x"80808080")report "TEST 3 FAIL" severity failure;
        f <= '1';
        wait for 1 ns;
        assert(r = x"02020202")report "TEST 4 FAIL" severity failure;

        report "ALL TESTS PASSED" severity note;
        wait;
    end process;
end architecture;