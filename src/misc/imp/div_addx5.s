.globl misc
misc:
    li a0,10000000
    li a1,1
0:
    div a1,a1,a1
    add a2,a2,a2
    add a3,a3,a3
    add a4,a4,a4
    add a5,a5,a5
    add a6,a6,a6
    div a1,a1,a1
    add a2,a2,a2
    add a3,a3,a3
    add a4,a4,a4
    add a5,a5,a5
    add a6,a6,a6
    div a1,a1,a1
    add a2,a2,a2
    add a3,a3,a3
    add a4,a4,a4
    add a5,a5,a5
    add a6,a6,a6
    div a1,a1,a1
    add a2,a2,a2
    add a3,a3,a3
    add a4,a4,a4
    add a5,a5,a5
    add a6,a6,a6
    div a1,a1,a1
    add a2,a2,a2
    add a3,a3,a3
    add a4,a4,a4
    add a5,a5,a5
    add a6,a6,a6
    div a1,a1,a1
    add a2,a2,a2
    add a3,a3,a3
    add a4,a4,a4
    add a5,a5,a5
    add a6,a6,a6
    div a1,a1,a1
    add a2,a2,a2
    add a3,a3,a3
    add a4,a4,a4
    add a5,a5,a5
    add a6,a6,a6
    div a1,a1,a1
    add a2,a2,a2
    add a3,a3,a3
    add a4,a4,a4
    add a5,a5,a5
    add a6,a6,a6
    div a1,a1,a1
    add a2,a2,a2
    add a3,a3,a3
    add a4,a4,a4
    add a5,a5,a5
    add a6,a6,a6
    div a1,a1,a1
    add a2,a2,a2
    add a3,a3,a3
    add a4,a4,a4
    add a5,a5,a5
    add a6,a6,a6
    addi a0,a0,-1
    bnez a0,0b
    ret
