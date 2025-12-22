library ieee;
use ieee.std_logic_1164.all;
entity tb_logical_unit is
end entity tb_logical_unit;

architecture test of tb_logical_unit is
    constant N: natural := 32;
    signal a,b,res: std_ulogic_vector(N-1 downto 0);
    signal af: std_ulogic_vector(1 downto 0);
    signal i: std_ulogic;
begin
    dut: entity work.logical_unit
        generic map(
            N => N
        )
        port map(
            a => a,
            b => b,
            af => af,
            i => i,
            res => res
        );
    stimulus: process
    begin
        a <= x"AAAA5555";
        b <= x"99996666";
        af <= "00"; -- logical AND
        i <= '0';
        wait for 1 ns;
        assert(res = x"88884444")report "TEST 1 FAIL" severity failure;

        af <= "01"; -- logical OR
        wait for 1 ns;
        assert(res = x"BBBB7777")report "TEST 2 FAIL" severity failure;

        af <= "10"; -- logical XOR
        wait for 1 ns;
        assert(res = x"33333333")report "TEST 3 FAIL" severity failure;

        af <= "11"; -- logical NOR
        wait for 1 ns;
        assert(res = x"44448888")report "TEST 4 FAIL" severity failure;

        i <= '1'; -- b LSBS
        wait for 1 ns;
        assert(res = x"66660000")report "TEST 5 FAIL" severity failure;

        report "ALL TESTS PASSED" severity note;
        wait;
    end process;
end architecture;