library ieee;
use ieee.std_logic_1164.all;
entity tb_alu is
end entity tb_alu;

architecture test of tb_alu is
    constant N: natural := 32;
    signal a,b,alures: std_ulogic_vector(N-1 downto 0);
    signal af: std_ulogic_vector(3 downto 0);
    signal ovfalu, i: std_ulogic;
begin
    dut: entity work.alu
        generic map(
            N => N
        )
        port map(
            a => a,
            b => b,
            af => af,
            i => i,
            alures => alures,
            ovfalu => ovfalu
        );
    stimulus: process
    begin
        a <= x"11111111";
        b <= x"EEEEEEEE";
        af <= "0001"; --unsigned ADD
        i <= '0';
        wait for 1 ns;
        assert(alures = x"FFFFFFFF" and ovfalu = '0')report "TEST 1 FAIL" severity failure;

        af <= "0000"; -- signed ADD
        wait for 1 ns;
        assert(alures = x"FFFFFFFF" and ovfalu = '0')report "TEST 2 FAIL" severity failure;

        af <= "0010"; -- signed SUB
        wait for 1 ns;
        assert(alures = x"22222223" and ovfalu = '0')report "TEST 3 FAIL" severity failure;

        af <= "0011"; -- unsigned SUB
        wait for 1 ns;
        assert(alures = x"22222223" and ovfalu = '0')report "TEST 4 FAIL" severity failure;

        a <= x"AAAA5555";
        b <= x"99996666";
        af <= "0100"; -- logical AND
        wait for 1 ns;
        assert(alures = x"88884444" and ovfalu = '0')report "TEST 5 FAIL" severity failure;

        af <= "0101"; -- logical OR
        wait for 1 ns;
        assert(alures = x"BBBB7777" and ovfalu = '0')report "TEST 6 FAIL" severity failure;

        af <= "0110"; -- logical XOR
        wait for 1 ns;
        assert(alures = x"33333333" and ovfalu = '0')report "TEST 7 FAIL" severity failure;

        af <= "0111"; -- logical NOR
        wait for 1 ns;
        assert(alures = x"44448888" and ovfalu = '0')report "TEST 8 FAIL" severity failure;

        i <= '1'; -- b LSBS
        wait for 1 ns;
        assert(alures = x"66660000" and ovfalu = '0')report "TEST 9 FAIL" severity failure;

        i <= '0';
        af <= "0000"; -- overflow test
        a <= x"7FFFFFFF";
        b <= x"7FFFFFFF";
        wait for 1 ns;
        assert(alures = x"FFFFFFFE" and ovfalu = '1')report "TEST 10 FAIL" severity failure;

        report "ALL TESTS PASSED" severity note;
        wait;
    end process;
end architecture;