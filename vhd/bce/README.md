# Branch condition evaluation unit (BCE)

- Input **bf** determines condition to be checked on inputs **a**,**b**.

| bf[3:0] |   bcres    |
|  :---   |   :---:    |
|  0010   | $a < 0$    |
|  0011   | $a \geq 0$ |
|  100X   | $a = b$    |
|  101X   | $a \neq b$ |
|  110X   | $a \leq 0$ |
|  111X   | $a > 0$    |