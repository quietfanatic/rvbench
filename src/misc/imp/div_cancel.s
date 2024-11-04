.globl misc
misc:
    li a0,10000000
    li a1,1
0:
    div a3,a1,a1
    addi a3,a0,0
    div a3,a1,a1
    addi a3,a0,0
    div a3,a1,a1
    addi a3,a0,0
    div a3,a1,a1
    addi a3,a0,0
    div a3,a1,a1
    addi a3,a0,0
    div a3,a1,a1
    addi a3,a0,0
    div a3,a1,a1
    addi a3,a0,0
    div a3,a1,a1
    addi a3,a0,0
    div a3,a1,a1
    addi a3,a0,0
    div a3,a1,a1
    addi a3,a0,0
    addi a0,a0,-1
    bnez a0,0b
    ret
