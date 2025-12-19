library ieee;
use ieee.std_logic_1164.all;
entity zero_check is
    generic(
        N: natural := 32
    );
    port(
        a:     in  std_ulogic_vector(N-1 downto 0);
        zero:  out std_ulogic;
        nzero: out std_ulogic
    );
end entity zero_check;

architecture rtl of zero_check is
    signal tmp: std_ulogic_vector(N-1 downto 0);
begin

    tmp(0) <= a(0);
    or_loop: for i in 1 to N-1 generate
        tmp(i) <= tmp(i-1) or a(i);
    end generate;

    nzero <= tmp(N-1);
    zero <= not tmp(N-1);
end architecture;