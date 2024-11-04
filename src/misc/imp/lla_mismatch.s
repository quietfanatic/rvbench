.bss
foo: .zero 8


.text
.globl misc
misc:
    auipc a1,%pcrel_hi(foo)
    auipc a2,%pcrel_hi(foo)
    li a0,10000000
0:
1:  auipc a1,%pcrel_hi(foo)
    addi a1,a2,%pcrel_lo(1b)
1:  auipc a2,%pcrel_hi(foo)
    addi a2,a1,%pcrel_lo(1b)
1:  auipc a1,%pcrel_hi(foo)
    addi a1,a2,%pcrel_lo(1b)
1:  auipc a2,%pcrel_hi(foo)
    addi a2,a1,%pcrel_lo(1b)
1:  auipc a1,%pcrel_hi(foo)
    addi a1,a2,%pcrel_lo(1b)
1:  auipc a2,%pcrel_hi(foo)
    addi a2,a1,%pcrel_lo(1b)
1:  auipc a1,%pcrel_hi(foo)
    addi a1,a2,%pcrel_lo(1b)
1:  auipc a2,%pcrel_hi(foo)
    addi a2,a1,%pcrel_lo(1b)
1:  auipc a1,%pcrel_hi(foo)
    addi a1,a2,%pcrel_lo(1b)
1:  auipc a2,%pcrel_hi(foo)
    addi a2,a1,%pcrel_lo(1b)
1:  auipc a1,%pcrel_hi(foo)
    addi a1,a2,%pcrel_lo(1b)
1:  auipc a2,%pcrel_hi(foo)
    addi a2,a1,%pcrel_lo(1b)
1:  auipc a1,%pcrel_hi(foo)
    addi a1,a2,%pcrel_lo(1b)
1:  auipc a2,%pcrel_hi(foo)
    addi a2,a1,%pcrel_lo(1b)
1:  auipc a1,%pcrel_hi(foo)
    addi a1,a2,%pcrel_lo(1b)
1:  auipc a2,%pcrel_hi(foo)
    addi a2,a1,%pcrel_lo(1b)
1:  auipc a1,%pcrel_hi(foo)
    addi a1,a2,%pcrel_lo(1b)
1:  auipc a2,%pcrel_hi(foo)
    addi a2,a1,%pcrel_lo(1b)
1:  auipc a1,%pcrel_hi(foo)
    addi a1,a2,%pcrel_lo(1b)
1:  auipc a2,%pcrel_hi(foo)
    addi a2,a1,%pcrel_lo(1b)
    addi a0,a0,-1
    bnez a0,0b
    ret
