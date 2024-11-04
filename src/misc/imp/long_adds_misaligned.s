.align 3
.globl misc
misc:
    li a0,10000000
    nop
0:
    add a1,a2,a3
    add a4,a5,a6
    add a1,a2,a3
    add a4,a5,a6
    add a1,a2,a3
    add a4,a5,a6
    add a1,a2,a3
    add a4,a5,a6
    add a1,a2,a3
    add a4,a5,a6
    add a1,a2,a3
    add a4,a5,a6
    add a1,a2,a3
    add a4,a5,a6
    add a1,a2,a3
    add a4,a5,a6
    add a1,a2,a3
    add a4,a5,a6
    add a1,a2,a3
    add a4,a5,a6
    addi a0,a0,-1
    bnez a0,0b
    ret
