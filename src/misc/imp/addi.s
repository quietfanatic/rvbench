
.align 3
.globl misc
misc:
    li a0,10000000
    li a1,0
0:
    addi a1,a1,1
    addi a1,a1,1
    addi a1,a1,1
    addi a1,a1,1
    addi a1,a1,1
    addi a1,a1,1
    addi a1,a1,1
    addi a1,a1,1
    addi a1,a1,1
    addi a1,a1,1
    addi a0,a0,-1
    bnez a0,0b
    ret
