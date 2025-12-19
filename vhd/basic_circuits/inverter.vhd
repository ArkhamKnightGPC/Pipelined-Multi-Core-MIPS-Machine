library ieee;
use ieee.std_logic_1164.all;
entity inverter is
    generic(
        N: natural := 32
    );
    port(
        a: in  std_ulogic_vector(N-1 downto 0);
        z: out std_ulogic_vector(N-1 downto 0)
    );
end entity inverter;

architecture rtl of inverter is
begin
    loop_inv: for i in 0 to N-1 generate
        z(i) <= not a(i);
    end generate;
end architecture;