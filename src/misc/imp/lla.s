.bss
foo: .zero 8

.text
.globl misc
misc:
    li a0,10000000
0:
    lla a1,foo
    lla a2,foo
    lla a1,foo
    lla a2,foo
    lla a1,foo
    lla a2,foo
    lla a1,foo
    lla a2,foo
    lla a1,foo
    lla a2,foo
    lla a1,foo
    lla a2,foo
    lla a1,foo
    lla a2,foo
    lla a1,foo
    lla a2,foo
    lla a1,foo
    lla a2,foo
    lla a1,foo
    lla a2,foo
    addi a0,a0,-1
    bnez a0,0b
    ret
