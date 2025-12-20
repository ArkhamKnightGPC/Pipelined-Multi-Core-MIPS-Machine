# ALU circuits

Important notes on certain design choices.
- [Arithmetic unit (au.sv)](#arithmetic-unit-ausv)
- [Arithmetic logical unit (alu.sv)](#arithmetic-logical-unit-alusv)

## Arithmetic unit (au.sv)

- control input **u** indicates unsigned/binary operands(if u=0) or signed/two's complement operands (if u=1).
- control input **sub** indicates whether input **b** should de subtracted or added to input **a**
- overflow bit **ovf** is computed only for u=1

## Arithmetic logical unit (alu.sv)

- width **N** is assumed to be even.
- control inputs **af[3:0]** and **i** encode the ALU operation to be performed
- overflow can happen only in AU operations

|    af   |   i   |            alures                     |
| :---    | :---: |            :----:                     |
|  0000   |       |   $a + b$ (signed)                    |
|  0001   |       |   $a + b$ (unsigned)                  |
|  0010   |       |   $a - b$ (signed)                    |
|  0011   |       |   $a - b$ (unsigned)                  |
|  0100   |       |   $a \land b$                         |
|  0101   |       |   $a \lor b$                          |
|  0110   |       |   $a \oplus b$                        |
|  0111   |   0   |   $\overline{a \lor b}$               |
|  0111   |   1   |   $b[\frac{n}{2}-1:0]0^\frac{n}{2}$   |
|  1010   |       |   $0^{n-1}(a < b ? 1 : 0)$ (signed)   |
|  1011   |       |   $0^{n-1}(a < b ? 1 : 0)$ (unsigned) |
