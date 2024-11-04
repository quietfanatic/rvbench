.section .rodata
one: .float16 1.0
.text
.globl misc
misc:
1:  auipc a0,%pcrel_hi(one)
    flh fa0,%pcrel_lo(1b)(a0)
    li a0,10000000
0:
    fmul.h fa0,fa0,fa0
    fmul.h fa0,fa0,fa0
    fmul.h fa0,fa0,fa0
    fmul.h fa0,fa0,fa0
    fmul.h fa0,fa0,fa0
    fmul.h fa0,fa0,fa0
    fmul.h fa0,fa0,fa0
    fmul.h fa0,fa0,fa0
    fmul.h fa0,fa0,fa0
    fmul.h fa0,fa0,fa0
    addi a0,a0,-1
    bnez a0,0b
    ret
