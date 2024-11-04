.bss
foo: .zero 8

.text

.globl misc
misc:
    li a0,10000000
0:
    li a1,12345678
    li a2,87654321
    li a1,12345678
    li a2,87654321
    li a1,12345678
    li a2,87654321
    li a1,12345678
    li a2,87654321
    li a1,12345678
    li a2,87654321
    li a1,12345678
    li a2,87654321
    li a1,12345678
    li a2,87654321
    li a1,12345678
    li a2,87654321
    li a1,12345678
    li a2,87654321
    li a1,12345678
    li a2,87654321
    addi a0,a0,-1
    bnez a0,0b
    ret
