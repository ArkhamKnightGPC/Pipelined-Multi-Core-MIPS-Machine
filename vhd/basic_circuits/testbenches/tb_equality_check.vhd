library ieee;
use ieee.std_logic_1164.all;
entity tb_equality_check is
end entity tb_equality_check;

architecture test of tb_equality_check is
    constant N: natural := 32;
    signal a,b: std_ulogic_vector(N-1 downto 0) := (others => '0');
    signal eq,neq: std_ulogic;
begin
    dut: entity work.equality_check
        generic map(
            N => N
        )
        port map(
            a => a,
            b => b,
            eq => eq,
            neq => neq
        );
    stimulus: process
    begin
        test_loop: for i in 0 to N-1 loop
            a(i) <= '1';
            b(i) <= '1';
            wait for 1 ns;
            assert(eq = '1' and neq = '0')report "TEST " & integer'image(3*i+1) & "FAIL" severity failure;
            b(i) <= '0';
            wait for 1 ns;
            assert(eq = '0' and neq = '1')report "TEST " & integer'image(3*i+2) & "FAIL" severity failure;
            a(i) <= '0';
            wait for 1 ns;
            assert(eq = '1' and neq = '0')report "TEST " & integer'image(3*i+3) & "FAIL" severity failure;
        end loop;
        report "ALL TESTS PASSED" severity note;
        wait;
    end process;
end architecture;
