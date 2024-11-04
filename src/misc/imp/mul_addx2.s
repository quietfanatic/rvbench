.globl misc
misc:
    li a0,10000000
    li a1,1
0:
    mul a1,a1,a1
    add a2,a2,a2
    add a3,a3,a3
    mul a1,a1,a1
    add a2,a2,a2
    add a3,a3,a3
    mul a1,a1,a1
    add a2,a2,a2
    add a3,a3,a3
    mul a1,a1,a1
    add a2,a2,a2
    add a3,a3,a3
    mul a1,a1,a1
    add a2,a2,a2
    add a3,a3,a3
    mul a1,a1,a1
    add a2,a2,a2
    add a3,a3,a3
    mul a1,a1,a1
    add a2,a2,a2
    add a3,a3,a3
    mul a1,a1,a1
    add a2,a2,a2
    add a3,a3,a3
    mul a1,a1,a1
    add a2,a2,a2
    add a3,a3,a3
    mul a1,a1,a1
    add a2,a2,a2
    add a3,a3,a3
    addi a0,a0,-1
    bnez a0,0b
    ret
