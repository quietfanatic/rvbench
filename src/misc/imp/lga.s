.bss
foo: .zero 8

.text
.globl misc
misc:
    li a0,10000000
0:
    lga a1,foo
    lga a2,foo
    lga a1,foo
    lga a2,foo
    lga a1,foo
    lga a2,foo
    lga a1,foo
    lga a2,foo
    lga a1,foo
    lga a2,foo
    lga a1,foo
    lga a2,foo
    lga a1,foo
    lga a2,foo
    lga a1,foo
    lga a2,foo
    lga a1,foo
    lga a2,foo
    lga a1,foo
    lga a2,foo
    addi a0,a0,-1
    bnez a0,0b
    ret
