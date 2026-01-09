# 32-bit MIPS ISA

Architecture defines 3 user visible data structures:
- **pc** the program counter;
- **gpr** the general purpose register file with 32 registers, each 32 bits wide; and
- **m** the processor memory. It is [byte-addressable](https://en.wikipedia.org/wiki/Byte_addressing) and addresses have 32 bits.

## Table of contents
- [I-type instructions](#i-type-instructions)
    - [Data transfer instructions](#data-transfer)
    - [Arithmetic, logical and test-set operations](#arithmetic-logical-and-test-set-operations)
    - [Branch instructions](#branch-instructions)
- [R-type instructions](#r-type-instructions)
    - [Shift instructions](#shift-instructions)
    - [Arithmetic, logical operations](#arithmetic-logical-operations)
    - [Test set operations](#test-set-operations)
    - [Jump register instructions](#jump-register-instructions)
- [J-type instructions](#j-type-instructions)
    - [Jump instructions](#jump-instructions)

---

### I-type instructions

Syntax
- opcode **opc** = I[31:26]
- **rs** = I[25:21]
- **rt** = I[20:16]
- Immediate constant **imm** = I[15:0]

#### Data transfer instructions

| opcode     | instruction |
| :---       |    :----:   |
| 100 000    |      lb     |
| 100 001    |      lh     |
| 100 011    |      lw     |
| 100 000    |      lbu    |
| 100 001    |      lhu    |
| 100 000    |      sb     |
| 100 001    |      sh     |
| 100 000    |      sw     |

#### Arithmetic, logical and test-set operations

| opcode     | instruction |
| :---       |    :----:   |
| 001 000    |     addi    |
| 001 001    |     addiu   |
| 001 010    |     slti    |
| 001 011    |     sltiu   |
| 001 100    |     andi    |
| 001 101    |     ori     |
| 001 110    |    xori     |
| 001 111    |     lui     |

#### Branch instructions

| opcode     |  rt   | instruction |
| :---       | :---: |    :----:   |
| 000 001    | 00000 |     bltz    |
| 000 001    | 00001 |     bgez    |
| 000 100    |       |     beq     |
| 000 101    |       |     bne     |
| 000 110    | 00000 |     blez    |
| 000 111    | 00000 |     bgtz    |

### R-type instructions

Syntax
- op-code **opc** = I[31:26]
- **rs** = I[25:21]
- **rt** = I[20:16]
- **rd** = I[15:11]
- **sa** = I[10:6]
- **fun** = I[5:0]

#### Shift instructions

| opcode     |  fun    | instruction |
| :---       | :---:   |    :----:   |
| 000 000    | 000 000 |     sll     |
| 000 000    | 000 010 |     srl     |
| 000 000    | 000 011 |     sra     |
| 000 000    | 000 100 |     sllv    |
| 000 000    | 000 110 |     srlv    |
| 000 000    | 000 111 |     srav    |

#### Arithmetic, logical operations

| opcode     |  fun    | instruction |
| :---       | :---:   |    :----:   |
| 000 000    | 100 000 |     add     |
| 000 000    | 100 001 |     addu    |
| 000 000    | 100 010 |     sub     |
| 000 000    | 100 011 |     subu    |
| 000 000    | 100 100 |     and     |
| 000 000    | 100 101 |     or      |
| 000 000    | 100 110 |     xor     |
| 000 000    | 100 111 |     nor     |

#### Test set operations

| opcode     |  fun    | instruction |
| :---       | :---:   |    :----:   |
| 000 000    | 101 010 |     slt     |
| 000 000    | 100 011 |     sltu    |

#### Jump register instructions

| opcode     |  fun    | instruction |
| :---       | :---:   |    :----:   |
| 000 000    | 001 000 |     jr      |
| 000 000    | 001 001 |     jalr    |

### J-type instructions

Syntax
- opcode **opc** = I[31:26]
- instruction index **iindex** = I[25:0]

#### Jump instructions

| opcode     | instruction |
| :---       |    :----:   |
| 000 010    |     j       |
| 000 011    |     ja      |