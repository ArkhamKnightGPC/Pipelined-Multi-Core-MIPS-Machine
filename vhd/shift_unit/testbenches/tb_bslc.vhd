library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
entity tb_bslc is
end entity tb_bslc;

architecture test of tb_bslc is
    constant N: natural := 32;
    signal a: std_ulogic_vector(N-1 downto 0);
    signal s: std_ulogic;

    subtype word is std_ulogic_vector(N-1 downto 0);
    type array_words is array(1 to N-1) of word;
    signal bslc_outputs: array_words;
begin
    gen_bslcs: for i in 1 to N-1 generate
        dut_i: entity work.bslc
            generic map(
                N => N,
                b => i
            )
            port map(
                a => a,
                s => s,
                z => bslc_outputs(i)
            );
    end generate;

    stimulus : process
        variable seed1, seed2 : positive := 1;
        variable rand         : real;

        function golden(
            a_golden : std_logic_vector(N-1 downto 0);
            b_golden : integer;
            s_golden : std_logic
        ) return std_logic_vector is
            variable result : std_logic_vector(N-1 downto 0);
        begin
            if s_golden = '0' then
                result := a_golden;
            else
                result := std_logic_vector(
                            (unsigned(a_golden) sll b_golden) or
                            (unsigned(a_golden) srl (N - b_golden))
                        );
            end if;
            return result;
        end function;

    begin
        s <= '0';
        a <= (others => '0');
        wait for 1 ns;
        for b in 1 to N-1 loop
            assert bslc_outputs(b) = golden(a, b, s)
            report "FAIL: s=0 b=" & integer'image(b)
            severity error;
        end loop;

        for t in 1 to 5 loop
            for i in 0 to N-1 loop
                uniform(seed1, seed2, rand);
                a(i) <= '1' when rand > 0.5 else '0';
            end loop;
            s <= '1';
            wait for 1 ns;
            for b in 1 to N-1 loop
                assert bslc_outputs(b) = golden(a, b, s)
                report "FAIL: s=1 b=" & integer'image(b)
                severity error;
            end loop;
        end loop;

        report "ALL TESTS PASSED" severity note;
        wait;
    end process;
end architecture;