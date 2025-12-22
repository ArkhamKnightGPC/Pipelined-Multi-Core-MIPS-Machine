library ieee;
use ieee.std_logic_1164.all;
entity alu is
    generic(
        N: natural := 32
    );
    port(
        a:      in std_ulogic_vector(N-1 downto 0);
        b:      in std_ulogic_vector(N-1 downto 0);
        af:     in std_ulogic_vector(3 downto 0);
        i:      in std_ulogic;
        alures: out std_ulogic_vector(N-1 downto 0);
        ovfalu: out std_ulogic
    );
end entity alu;

architecture rtl of alu is
    signal arith_out, logic_out, sel_arith_logic, cmp_res: std_ulogic_vector(N-1 downto 0);
    signal ovf, neg, u, sub, cmp: std_ulogic;
    signal zeros: std_ulogic_vector(N-2 downto 0) := (others => '0');
begin
    u <= af(0);
    sub <= af(1);
    arith_ops: entity work.au
        generic map(
            N => N
        )
        port map(
            a => a,
            b => b,
            u => u,
            sub => sub,
            s => arith_out,
            ovf => ovf,
            neg => neg
        );
    logic_ops: entity work.logical_unit
        generic map(
            N => N
        )
        port map(
            a => a,
            b => b,
            af => af(1 downto 0),
            i => i,
            res => logic_out
        );
    g1: entity work.nmux21
        generic map(
            N => N
        )
        port map(
            a => arith_out,
            b => logic_out,
            s => af(2),
            z => sel_arith_logic
        );
    cmp <= neg;
    cmp_res <= zeros&cmp;
    g2: entity work.nmux21
        generic map(
            N => N
        )
        port map(
            a => sel_arith_logic,
            b => cmp_res,
            s => af(3),
            z => alures
        );
    ovfalu <= ovf and (not af(3)) and (not af(2));
end architecture;