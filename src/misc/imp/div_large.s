.globl misc
misc:
    li a0,10000000
    li a1,10000000
    li t1,3
0:
    div t0,a1,t1
    div t0,a1,t1
    div t0,a1,t1
    div t0,a1,t1
    div t0,a1,t1
    div t0,a1,t1
    div t0,a1,t1
    div t0,a1,t1
    div t0,a1,t1
    div t0,a1,t1
    addi a0,a0,-1
    bnez a0,0b
    ret
