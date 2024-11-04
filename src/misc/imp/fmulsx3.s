.section .rodata
one: .float 1.0
.text
.globl misc
misc:
1:  auipc a0,%pcrel_hi(one)
    flw fa0,%pcrel_lo(1b)(a0)
    flw fa1,%pcrel_lo(1b)(a0)
    flw fa2,%pcrel_lo(1b)(a0)
    li a0,10000000
0:
    fmul.s fa0,fa0,fa0
    fmul.s fa1,fa1,fa1
    fmul.s fa2,fa2,fa2
    fmul.s fa0,fa0,fa0
    fmul.s fa1,fa1,fa1
    fmul.s fa2,fa2,fa2
    fmul.s fa0,fa0,fa0
    fmul.s fa1,fa1,fa1
    fmul.s fa2,fa2,fa2
    fmul.s fa0,fa0,fa0
    fmul.s fa1,fa1,fa1
    fmul.s fa2,fa2,fa2
    fmul.s fa0,fa0,fa0
    fmul.s fa1,fa1,fa1
    fmul.s fa2,fa2,fa2
    fmul.s fa0,fa0,fa0
    fmul.s fa1,fa1,fa1
    fmul.s fa2,fa2,fa2
    fmul.s fa0,fa0,fa0
    fmul.s fa1,fa1,fa1
    fmul.s fa2,fa2,fa2
    fmul.s fa0,fa0,fa0
    fmul.s fa1,fa1,fa1
    fmul.s fa2,fa2,fa2
    fmul.s fa0,fa0,fa0
    fmul.s fa1,fa1,fa1
    fmul.s fa2,fa2,fa2
    fmul.s fa0,fa0,fa0
    fmul.s fa1,fa1,fa1
    fmul.s fa2,fa2,fa2
    addi a0,a0,-1
    bnez a0,0b
    ret
