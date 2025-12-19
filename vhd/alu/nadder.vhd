library ieee;
use ieee.std_logic_1164.all;
entity nadder is
    generic(
        N: natural := 32
    );
    port(
        a:    in  std_ulogic_vector(N-1 downto 0);
        b:    in  std_ulogic_vector(N-1 downto 0);
        cin:  in  std_ulogic;
        s:    out std_ulogic_vector(N-1 downto 0);
        cout: out std_ulogic
    );
end entity nadder;

architecture rtl of nadder is
    signal carry_internal: std_ulogic_vector(N-1 downto 0);
begin
    base_case: entity work.full_adder
        port map(
            a => a(0),
            b => b(0),
            cin => cin,
            s => s(0),
            cout => carry_internal(0)
        );
    fa_loop: for i in 1 to N-1 generate
        inductive_step: entity work.full_adder
            port map(
                a => a(i),
                b => b(i),
                cin => carry_internal(i-1),
                s => s(i),
                cout => carry_internal(i)
            );
    end generate;
    cout <= carry_internal(N-1);
end architecture;