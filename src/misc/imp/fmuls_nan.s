.section .rodata
bad: .word -1
.text
.globl misc
misc:
1:  auipc a0,%pcrel_hi(bad)
    flw fa0,%pcrel_lo(1b)(a0)
    li a0,10000000
0:
    fmul.s fa1,fa0,fa0
    fmul.s fa1,fa0,fa0
    fmul.s fa1,fa0,fa0
    fmul.s fa1,fa0,fa0
    fmul.s fa1,fa0,fa0
    fmul.s fa1,fa0,fa0
    fmul.s fa1,fa0,fa0
    fmul.s fa1,fa0,fa0
    fmul.s fa1,fa0,fa0
    fmul.s fa1,fa0,fa0
    addi a0,a0,-1
    bnez a0,0b
     # Make sure the result is nan
    feq.s a1,fa1,fa1
    bnez a1,2f
    ret
2:  unimp
