library ieee;
use ieee.std_logic_1164.all;
entity au is
    generic(
        N: natural := 32
    );
    port(
        a:   in  std_ulogic_vector(N-1 downto 0);
        b:   in  std_ulogic_vector(N-1 downto 0);
        u:   in  std_ulogic;
        sub: in  std_ulogic;
        s:   out std_ulogic_vector(N-1 downto 0);
        ovf: out std_ulogic;
        neg: out std_ulogic
    );
end entity au;

architecture rtl of au is
    signal b_checked: std_ulogic_vector(N-1 downto 0);
    signal cout: std_ulogic;
begin
    b_checked <= b xor sub;
    add_sub: entity work.nadder
        generic map(
            N => N
        )
        port map(
            a => a,
            b => b_checked,
            cin => sub,
            s => s,
            cout => cout
        );
    neg <= ((not u) and (a(N-1) xor b_checked(N-1) xor cout)) or (u and sub and (not cout));
    ovf <= (not u) and (s(N-1) and cout);
end architecture;