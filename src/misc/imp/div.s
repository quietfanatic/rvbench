.globl misc
misc:
    li a0,10000000
    li a1,1
0:
    div a1,a1,a1
    div a1,a1,a1
    div a1,a1,a1
    div a1,a1,a1
    div a1,a1,a1
    div a1,a1,a1
    div a1,a1,a1
    div a1,a1,a1
    div a1,a1,a1
    div a1,a1,a1
    addi a0,a0,-1
    bnez a0,0b
    ret
