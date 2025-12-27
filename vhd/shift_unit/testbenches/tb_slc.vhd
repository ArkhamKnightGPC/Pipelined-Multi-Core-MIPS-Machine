library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
entity tb_slc is
end entity tb_slc;

architecture test of tb_slc is
    constant N: natural := 32;
    constant K: natural := integer(ceil(log2(Real(N))));
    signal a, r: std_ulogic_vector(N-1 downto 0);
    signal b: std_ulogic_vector(K-1 downto 0);
begin
    dut: entity work.slc
        generic map(
            N => N
        )
        port map(
            a => a,
            b => b,
            r => r
        );

    stimulus: process
    begin
        a <= x"00000001";
        b <= "00001";
        wait for 1 ns;
        assert(r = x"00000002")report "TEST 1 FAIL" severity failure;

        b <= "00011";
        wait for 1 ns;
        assert(r = x"00000008")report "TEST 2 FAIL" severity failure;

        b <= "00111";
        wait for 1 ns;
        assert(r = x"00000080")report "TEST 3 FAIL" severity failure;

        b <= "01111";
        wait for 1 ns;
        assert(r = x"00008000")report "TEST 4 FAIL" severity failure;

        b <= "11111";
        wait for 1 ns;
        assert(r = x"80000000")report "TEST 5 FAIL" severity failure;

        report "ALL TESTS PASSED" severity note;
        wait;
    end process;
end architecture;