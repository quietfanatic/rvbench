.bss
foo: .zero 8

.text
.globl misc
misc:
    li a0,10000000
0:
    li a1,-8192
    and a1,a1,a0
    li a2,-8192
    and a2,a2,a0
    li a1,-8192
    and a1,a1,a0
    li a2,-8192
    and a2,a2,a0
    li a1,-8192
    and a1,a1,a0
    li a2,-8192
    and a2,a2,a0
    li a1,-8192
    and a1,a1,a0
    li a2,-8192
    and a2,a2,a0
    li a1,-8192
    and a1,a1,a0
    li a2,-8192
    and a2,a2,a0
    li a1,-8192
    and a1,a1,a0
    li a2,-8192
    and a2,a2,a0
    li a1,-8192
    and a1,a1,a0
    li a2,-8192
    and a2,a2,a0
    li a1,-8192
    and a1,a1,a0
    li a2,-8192
    and a2,a2,a0
    li a1,-8192
    and a1,a1,a0
    li a2,-8192
    and a2,a2,a0
    li a1,-8192
    and a1,a1,a0
    li a2,-8192
    and a2,a2,a0
    addi a0,a0,-1
    bnez a0,0b
    ret
