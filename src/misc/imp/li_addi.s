.globl misc
misc:
    li a0,10000000
0:
    li a1,12345678
    addi a1,a1,1
    li a2,87654321
    addi a2,a2,1
    li a1,12345678
    addi a1,a1,1
    li a2,87654321
    addi a2,a2,1
    li a1,12345678
    addi a1,a1,1
    li a2,87654321
    addi a2,a2,1
    li a1,12345678
    addi a1,a1,1
    li a2,87654321
    addi a2,a2,1
    li a1,12345678
    addi a1,a1,1
    li a2,87654321
    addi a2,a2,1
    li a1,12345678
    addi a1,a1,1
    li a2,87654321
    addi a2,a2,1
    li a1,12345678
    addi a1,a1,1
    li a2,87654321
    addi a2,a2,1
    li a1,12345678
    addi a1,a1,1
    li a2,87654321
    addi a2,a2,1
    li a1,12345678
    addi a1,a1,1
    li a2,87654321
    addi a2,a2,1
    li a1,12345678
    addi a1,a1,1
    li a2,87654321
    addi a2,a2,1
    addi a0,a0,-1
    bnez a0,0b
    ret
