library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
entity tb_bce is
end entity tb_bce;

architecture test of tb_bce is
    constant N: natural := 32;
    constant zero: std_ulogic_vector(N-1 downto 0) := (others => '0');
    signal a,b: std_ulogic_vector(N-1 downto 0);
    signal bf: std_ulogic_vector(3 downto 0);
    signal bcres: std_ulogic;
begin
    dut: entity work.bce
        generic map(
            N => N
        )
        port map(
            a => a,
            b => b,
            bf => bf,
            bcres => bcres
        );

    stimulus: process
        variable seed1, seed2 : positive := 1;
        variable rand         : real;
        function golden(
            a_golden: std_ulogic_vector(N-1 downto 0);
            b_golden: std_ulogic_vector(N-1 downto 0);
            bf_golden: std_ulogic_vector(3 downto 0)
        ) return std_ulogic is
            variable bcres_golden: std_ulogic;
        begin
            if bf_golden = "0010" then
                bcres_golden := a_golden(N-1);
            elsif bf_golden = "0011" then
                bcres_golden := not a_golden(N-1);
            elsif bf_golden = "1000" or bf_golden = "1001" then
                bcres_golden := '1' when (a_golden = b_golden) else '0';
            elsif bf_golden = "1010" or bf_golden = "1011" then
                bcres_golden := '0' when (a_golden = b_golden) else '1';
            elsif bf_golden = "1100" or bf_golden = "1101" then
                bcres_golden := '1' when ((a_golden(N-1)='1') or (a_golden = zero)) else '0';
            elsif bf_golden = "1110" or bf_golden = "1111" then
                bcres_golden := '0' when ((a_golden(N-1)='1') or (a_golden = zero)) else '1';
            else
                bcres_golden := '0';
            end if;
            return bcres_golden;
        end function;
    begin
        a <= (others => '0');
        b <= (others => '0');
        bf <= "0000";
        wait for 1 ns;

        for t in 1 to 20 loop
            for i in 0 to N-1 loop
                uniform(seed1, seed2, rand);
                a(i) <= '1' when rand > 0.5 else '0';
                uniform(seed1, seed2, rand);
                b(i) <= '1' when rand > 0.5 else '0';
            end loop;
            for i in 0 to 3 loop
                uniform(seed1, seed2, rand);
                bf(i) <= '1' when rand > 0.5 else '0';
            end loop;
            wait for 1 ns;
            assert (bcres = golden(a,b,bf)) report "TEST " & integer'image(t) & " FAILED" severity error;
        end loop;
        report "ALL TESTS PASSED" severity note;
        wait;
    end process;
end architecture;