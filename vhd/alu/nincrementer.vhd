library ieee;
use ieee.std_logic_1164.all;
entity nincrementer is
    generic(
        N: natural := 32
    );
    port(
        a:    in  std_ulogic_vector(N-1 downto 0);
        cin:  in  std_ulogic;
        s:    out std_ulogic_vector(N-1 downto 0);
        cout: out std_ulogic
    );
end entity nincrementer;

architecture rtl of nincrementer is
begin
    add_inc: entity work.nadder
        generic map(
            N => N
        )
        port map(
            a => a,
            b => (others => '0'),
            cin => cin,
            s => s,
            cout => cout
        );
end architecture;