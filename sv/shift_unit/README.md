# Shift unit

The shift unit provides constructions to implement 3 different types of shifts.
The designs presented incrementally build these operations.

|            op             |                def                |
|           :---            |               :---:               |
| cyclical left shift       | $slc(a,i) = a[n-i-1:0]a[n-1:n-i]$ |
| cyclical right shift      | $src(a,i) = a[i-1:0]a[n-1:i]$     |
| arithmetic right shift    | $sra(a,i) = a_{n-1}^ia[n-1:i]$    |

## (n,b)-cyclic left shifter (bslc.sv)

- (n,b)-SLC performs cyclical left shifts $slc(a,b)$
- **b** is fixed as a module parameter and **2^b** denotes the *shift distance*
- input **s** is an enable signal

## n-cyclic left shifter (slc.sv)

- constructed with a stack of (n,b)-SLCs
- n-SLC performs cyclic left shift for all shift distances

## n-cyclic right-left shifter SRLC (srlc.sv)

- n-SRLC performs both left and right cyclical shifts
- control input **f** determines *shift direction*: **0** for left shift and **1** for right shift.

## n-shift unit (su.sv)

- control input **sf** determines type of shift

|  sf   |    sures    |
| :---  |    :---:    |
|   00  | $slc(a, b)$ |
|   10  | $src(a, b)$ |
|   11  | $sra(a, b)$ |

