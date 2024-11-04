.globl misc
misc:
    li a0,10000000
    li a1,1
0:
    div a2,a0,a1
    div a3,a0,a1
    div a4,a0,a1
    div a5,a0,a1
    div t0,a0,a1
    div t1,a0,a1
    div t2,a0,a1
    div t3,a0,a1
    div t4,a0,a1
    div t5,a0,a1
    div a2,a0,a1
    div a3,a0,a1
    div a4,a0,a1
    div a5,a0,a1
    div t0,a0,a1
    div t1,a0,a1
    div t2,a0,a1
    div t3,a0,a1
    div t4,a0,a1
    div t5,a0,a1
    addi a0,a0,-1
    bnez a0,0b
    ret
