# Tests whether nop can pair with a similar instruction that references a
# different register
.globl misc
misc:
    li a0,1000000
.macro nope
    addi t6,t6,0
.endm
0:  nop; nope; nop; nope; nop; nope; nop; nope; nop; nope
    nop; nope; nop; nope; nop; nope; nop; nope; nop; nope
    nop; nope; nop; nope; nop; nope; nop; nope; nop; nope
    nop; nope; nop; nope; nop; nope; nop; nope; nop; nope
    nop; nope; nop; nope; nop; nope; nop; nope; nop; nope
    nop; nope; nop; nope; nop; nope; nop; nope; nop; nope
    nop; nope; nop; nope; nop; nope; nop; nope; nop; nope
    nop; nope; nop; nope; nop; nope; nop; nope; nop; nope
    nop; nope; nop; nope; nop; nope; nop; nope; nop; nope
    nop; nope; nop; nope; nop; nope; nop; nope; nop; nope
    addi a0,a0,-1
    bnez a0,0b
    ret
