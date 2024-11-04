.section .rodata
tiny: .word 14
one: .float 1.0
.text
.globl misc
misc:
1:  auipc a0,%pcrel_hi(one)
    flw fa0,%pcrel_lo(1b)(a0)
    auipc a1,%pcrel_hi(tiny)
    flw fa1,%pcrel_lo(1b)(a1)
    li a0,10000000
0:
    fmul.s fa2,fa1,fa0
    fmul.s fa2,fa1,fa0
    fmul.s fa2,fa1,fa0
    fmul.s fa2,fa1,fa0
    fmul.s fa2,fa1,fa0
    fmul.s fa2,fa1,fa0
    fmul.s fa2,fa1,fa0
    fmul.s fa2,fa1,fa0
    fmul.s fa2,fa1,fa0
    fmul.s fa2,fa1,fa0
    addi a0,a0,-1
    bnez a0,0b
     # Make sure the denorm didn't get flushed to zero
    fmv.x.s a1,fa1
    beqz a1,2f
    ret
2:  unimp
