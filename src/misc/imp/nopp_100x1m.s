 # Tests whether instructions that write to the same register can pair together.
.globl misc
misc:
    li a0,1000000
.macro nopp
    mv zero,t6
.endm
0:  nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp
    nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp
    nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp
    nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp
    nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp
    nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp
    nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp
    nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp
    nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp
    nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp; nopp
    addi a0,a0,-1
    bnez a0,0b
    ret
