library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity tb_zero_check is
end entity tb_zero_check;

architecture test of tb_zero_check is
    constant N: natural := 32;
    signal a: std_ulogic_vector(N-1 downto 0) := (others => '0');
    signal zero,nzero: std_ulogic;
begin
    dut: entity work.zero_check
        generic map(
            N => N
        )
        port map(
            a => a,
            zero => zero,
            nzero => nzero
        );

    stimulus: process

    begin
        loop_test: for i in 0 to N-1 loop
            a(i) <= '1';
            wait for 1 ns;
            assert(zero='0' and nzero='1')report "TEST " & integer'image(2*i+1) & " FAIL" severity failure;

            a(i) <= '0';
            wait for 1 ns;
            assert(zero='1' and nzero='0')report "TEST " & integer'image(2*i+2) & " FAIL" severity failure;
        end loop;
        report "ALL TESTS PASSED" severity note;
        wait;
    end process;
end architecture;