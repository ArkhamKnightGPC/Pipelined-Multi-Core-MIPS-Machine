library ieee;
use ieee.std_logic_1164.all;
entity mux21 is
    port(
        a: in  std_ulogic;
        b: in  std_ulogic;
        s: in  std_ulogic;
        z: out std_ulogic
    );
end entity mux21;

architecture rtl of mux21 is
begin
    z <= (a and (not s)) or (b and s);
end architecture rtl;