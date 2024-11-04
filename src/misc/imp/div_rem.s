.globl misc
misc:
    li a0,10000000
    li a1,1
0:
    div a2,a1,a1
    rem a3,a1,a1
    div a2,a1,a1
    rem a3,a1,a1
    div a2,a1,a1
    rem a3,a1,a1
    div a2,a1,a1
    rem a3,a1,a1
    div a2,a1,a1
    rem a3,a1,a1
    div a2,a1,a1
    rem a3,a1,a1
    div a2,a1,a1
    rem a3,a1,a1
    div a2,a1,a1
    rem a3,a1,a1
    div a2,a1,a1
    rem a3,a1,a1
    div a2,a1,a1
    rem a3,a1,a1
    addi a0,a0,-1
    bnez a0,0b
    ret
