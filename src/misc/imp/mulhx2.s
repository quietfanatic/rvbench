.globl misc
misc:
    li a0,10000000
    li a1,1
0:
    mulhu a2,a1,a1
    mulhu a1,a1,a1
    mulhu a2,a1,a1
    mulhu a1,a1,a1
    mulhu a2,a1,a1
    mulhu a1,a1,a1
    mulhu a2,a1,a1
    mulhu a1,a1,a1
    mulhu a2,a1,a1
    mulhu a1,a1,a1
    mulhu a2,a1,a1
    mulhu a1,a1,a1
    mulhu a2,a1,a1
    mulhu a1,a1,a1
    mulhu a2,a1,a1
    mulhu a1,a1,a1
    mulhu a2,a1,a1
    mulhu a1,a1,a1
    mulhu a2,a1,a1
    mulhu a1,a1,a1
    addi a0,a0,-1
    bnez a0,0b
    ret
