.section .rodata
one: .double 1.0
.text
.globl misc
misc:
1:  auipc a0,%pcrel_hi(one)
    fld fa0,%pcrel_lo(1b)(a0)
    fld fa1,%pcrel_lo(1b)(a0)
    li a0,10000000
0:
    fmul.d fa0,fa0,fa0
    fmul.d fa1,fa1,fa1
    fmul.d fa0,fa0,fa0
    fmul.d fa1,fa1,fa1
    fmul.d fa0,fa0,fa0
    fmul.d fa1,fa1,fa1
    fmul.d fa0,fa0,fa0
    fmul.d fa1,fa1,fa1
    fmul.d fa0,fa0,fa0
    fmul.d fa1,fa1,fa1
    fmul.d fa0,fa0,fa0
    fmul.d fa1,fa1,fa1
    fmul.d fa0,fa0,fa0
    fmul.d fa1,fa1,fa1
    fmul.d fa0,fa0,fa0
    fmul.d fa1,fa1,fa1
    fmul.d fa0,fa0,fa0
    fmul.d fa1,fa1,fa1
    fmul.d fa0,fa0,fa0
    fmul.d fa1,fa1,fa1
    addi a0,a0,-1
    bnez a0,0b
    ret
