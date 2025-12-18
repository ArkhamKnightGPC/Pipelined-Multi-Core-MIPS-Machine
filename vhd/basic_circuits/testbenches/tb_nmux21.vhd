library ieee;
use ieee.std_logic_1164.all;
entity tb_nmux21 is
end entity tb_nmux21;

architecture tb of tb_nmux21 is
    constant N: natural := 32;
    signal a,b,z: std_ulogic_vector(N-1 downto 0);
    signal s: std_ulogic;
begin

    dut: entity work.nmux21
        generic map(
            N => N
        )
        port map(
            a => a,
            b => b,
            s => s,
            z => z
        );

    stimulus: process
    begin
        a <= x"AAAAAAAA";
        b <= x"BBBBBBBB";
        s <= '0';

        wait for 1 ns;
        assert(z = a)report "TEST s=0 FAIL" severity failure;
        report "TEST s=0 PASS" severity note;

        s <= '1';
        wait for 1 ns;
        assert(z = b)report "TEST s=1 FAIL" severity failure;
        report "TEST s=1 PASS" severity note;

        wait;
    end process;
end architecture tb;