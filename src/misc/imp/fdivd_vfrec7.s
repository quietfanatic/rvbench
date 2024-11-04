.section .rodata
one: .double 1.0
.text
.globl misc
misc:
1:  auipc a0,%pcrel_hi(one)
    fld fa0,%pcrel_lo(1b)(a0)
    li a0,10000000
    vsetivli zero,1,e64,m1,ta,ma
0:
    vfmv.s.f v1,fa0
    vfrec7.v v1,v1
    vfmv.f.s fa0,v1
    fmul.d fa0,fa0,fa0
    vfmv.s.f v1,fa0
    vfrec7.v v1,v1
    vfmv.f.s fa0,v1
    fmul.d fa0,fa0,fa0
    vfmv.s.f v1,fa0
    vfrec7.v v1,v1
    vfmv.f.s fa0,v1
    fmul.d fa0,fa0,fa0
    vfmv.s.f v1,fa0
    vfrec7.v v1,v1
    vfmv.f.s fa0,v1
    fmul.d fa0,fa0,fa0
    vfmv.s.f v1,fa0
    vfrec7.v v1,v1
    vfmv.f.s fa0,v1
    fmul.d fa0,fa0,fa0
    vfmv.s.f v1,fa0
    vfrec7.v v1,v1
    vfmv.f.s fa0,v1
    fmul.d fa0,fa0,fa0
    vfmv.s.f v1,fa0
    vfrec7.v v1,v1
    vfmv.f.s fa0,v1
    fmul.d fa0,fa0,fa0
    vfmv.s.f v1,fa0
    vfrec7.v v1,v1
    vfmv.f.s fa0,v1
    fmul.d fa0,fa0,fa0
    vfmv.s.f v1,fa0
    vfrec7.v v1,v1
    vfmv.f.s fa0,v1
    fmul.d fa0,fa0,fa0
    vfmv.s.f v1,fa0
    vfrec7.v v1,v1
    vfmv.f.s fa0,v1
    fmul.d fa0,fa0,fa0
    addi a0,a0,-1
    bnez a0,0b
    ret
