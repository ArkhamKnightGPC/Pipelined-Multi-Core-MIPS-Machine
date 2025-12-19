library ieee;
use ieee.std_logic_1164.all;
entity tb_nadder is
end entity tb_nadder;

architecture test of tb_nadder is
    constant N: natural := 32;
    signal a,b,s: std_ulogic_vector(N-1 downto 0);
    signal cin,cout: std_ulogic;
begin
    dut: entity work.nadder
        generic map(
            N => N
        )
        port map(
            a => a,
            b => b,
            cin => cin,
            s => s,
            cout => cout
        );
    stimulus: process
    begin
        a <= x"11111111";
        b <= x"EEEEEEEE";
        cin <= '0';
        wait for 1 ns;
        assert(s=x"FFFFFFFF" and cout='0')report "TEST 1 FAIL" severity failure;

        cin <= '1';
        wait for 1 ns;
        assert(s=x"00000000" and cout='1')report "TEST 2 FAIL" severity failure;

        report "ALL TESTS PASSED" severity note;
        wait;
    end process;
end architecture;