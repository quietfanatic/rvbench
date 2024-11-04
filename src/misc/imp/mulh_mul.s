.globl misc
misc:
    li a0,10000000
    li a1,1
0:
    mulhu a2,a1,a1
    mul a3,a1,a1
    mulhu a2,a3,a3
    mul a1,a3,a3
    mulhu a2,a1,a1
    mul a3,a1,a1
    mulhu a2,a3,a3
    mul a1,a3,a3
    mulhu a2,a1,a1
    mul a3,a1,a1
    mulhu a2,a3,a3
    mul a1,a3,a3
    mulhu a2,a1,a1
    mul a3,a1,a1
    mulhu a2,a3,a3
    mul a1,a3,a3
    mulhu a2,a1,a1
    mul a3,a1,a1
    mulhu a2,a3,a3
    mul a1,a3,a3
    addi a0,a0,-1
    bnez a0,0b
    ret
