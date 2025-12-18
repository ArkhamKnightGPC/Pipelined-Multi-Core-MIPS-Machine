library ieee;
use ieee.std_logic_1164.all;
entity half_adder is
    port(
        a:    in  std_ulogic;
        b:    in  std_ulogic;
        s:    in  std_ulogic;
        cout: out std_ulogic
    );
end entity half_adder;

architecture rtl of half_adder is
begin
    s <= a xor b;
    cout <= a and b;
end architecture rtl;