.bss
foo: .zero 8


.text
.globl misc
misc:
    li a0,10000000
0:
1:  auipc a1,%pcrel_hi(foo)
    ld a1,%pcrel_lo(1b)(a1)
1:  auipc a2,%pcrel_hi(foo)
    ld a2,%pcrel_lo(1b)(a2)
1:  auipc a1,%pcrel_hi(foo)
    ld a1,%pcrel_lo(1b)(a1)
1:  auipc a2,%pcrel_hi(foo)
    ld a2,%pcrel_lo(1b)(a2)
1:  auipc a1,%pcrel_hi(foo)
    ld a1,%pcrel_lo(1b)(a1)
1:  auipc a2,%pcrel_hi(foo)
    ld a2,%pcrel_lo(1b)(a2)
1:  auipc a1,%pcrel_hi(foo)
    ld a1,%pcrel_lo(1b)(a1)
1:  auipc a2,%pcrel_hi(foo)
    ld a2,%pcrel_lo(1b)(a2)
1:  auipc a1,%pcrel_hi(foo)
    ld a1,%pcrel_lo(1b)(a1)
1:  auipc a2,%pcrel_hi(foo)
    ld a2,%pcrel_lo(1b)(a2)
1:  auipc a1,%pcrel_hi(foo)
    ld a1,%pcrel_lo(1b)(a1)
1:  auipc a2,%pcrel_hi(foo)
    ld a2,%pcrel_lo(1b)(a2)
1:  auipc a1,%pcrel_hi(foo)
    ld a1,%pcrel_lo(1b)(a1)
1:  auipc a2,%pcrel_hi(foo)
    ld a2,%pcrel_lo(1b)(a2)
1:  auipc a1,%pcrel_hi(foo)
    ld a1,%pcrel_lo(1b)(a1)
1:  auipc a2,%pcrel_hi(foo)
    ld a2,%pcrel_lo(1b)(a2)
1:  auipc a1,%pcrel_hi(foo)
    ld a1,%pcrel_lo(1b)(a1)
1:  auipc a2,%pcrel_hi(foo)
    ld a2,%pcrel_lo(1b)(a2)
1:  auipc a1,%pcrel_hi(foo)
    ld a1,%pcrel_lo(1b)(a1)
1:  auipc a2,%pcrel_hi(foo)
    ld a2,%pcrel_lo(1b)(a2)
    addi a0,a0,-1
    bnez a0,0b
    ret
