.section .rodata
one: .float 1.0
.text
.globl misc
misc:
1:  auipc a0,%pcrel_hi(one)
    flw fa0,%pcrel_lo(1b)(a0)
    li a1,1
    li a0,10000000
0:
    fmul.s fa0,fa0,fa0
    mulw a1,a1,a1
    fmul.s fa0,fa0,fa0
    mulw a1,a1,a1
    fmul.s fa0,fa0,fa0
    mulw a1,a1,a1
    fmul.s fa0,fa0,fa0
    mulw a1,a1,a1
    fmul.s fa0,fa0,fa0
    mulw a1,a1,a1
    fmul.s fa0,fa0,fa0
    mulw a1,a1,a1
    fmul.s fa0,fa0,fa0
    mulw a1,a1,a1
    fmul.s fa0,fa0,fa0
    mulw a1,a1,a1
    fmul.s fa0,fa0,fa0
    mulw a1,a1,a1
    fmul.s fa0,fa0,fa0
    mulw a1,a1,a1
    addi a0,a0,-1
    bnez a0,0b
    ret
