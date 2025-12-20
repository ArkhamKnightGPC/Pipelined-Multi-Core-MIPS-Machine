library ieee;
use ieee.std_logic_1164.all;
entity tb_au is
end entity tb_au;

architecture test of tb_au is
    constant N: natural := 32;
    signal a,b,s: std_ulogic_vector(N-1 downto 0);
    signal u,sub,ovf,neg: std_ulogic;
begin
    dut: entity work.au
        generic map(
            N => N
        )
        port map(
            a => a,
            b => b,
            u => u,
            sub => sub,
            s => s,
            ovf => ovf,
            neg => neg
        );
    stimulus: process
    begin
        a <= x"11111111";
        b <= x"EEEEEEEE";
        u <= '1'; --unsigned
        sub <= '0'; --addition

        wait for 1 ns;
        assert(s=x"FFFFFFFF" and ovf='0' and neg='0')report "TEST 1 FAIL" severity failure;

        u <= '0'; --signed addition
        wait for 1 ns;
        assert(s=x"FFFFFFFF" and ovf='0' and neg='1')report "TEST 2 FAIL" severity failure;

        sub <= '1';--signed subtraction
        wait for 1 ns;
        assert(s=x"22222223" and ovf='0' and neg='0')report "TEST 3 FAIL" severity failure;

        u <= '1';--unsigned subtraction
        wait for 1 ns;
        assert(s=x"22222223" and ovf='0' and neg='1')report "TEST 4 FAIL" severity failure;

        report "ALL TESTS PASSED" severity note;
        wait;
    end process;
end architecture;