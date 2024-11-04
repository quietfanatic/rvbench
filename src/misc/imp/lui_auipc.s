.bss
foo: .zero 8

.text
.globl misc
misc:
    li a0,10000000
0:
    lui a1,2
    auipc a1,2
    lui a2,2
    auipc a2,2
    lui a1,2
    auipc a1,2
    lui a2,2
    auipc a2,2
    lui a1,2
    auipc a1,2
    lui a2,2
    auipc a2,2
    lui a1,2
    auipc a1,2
    lui a2,2
    auipc a2,2
    lui a1,2
    auipc a1,2
    lui a2,2
    auipc a2,2
    lui a1,2
    auipc a1,2
    lui a2,2
    auipc a2,2
    lui a1,2
    auipc a1,2
    lui a2,2
    auipc a2,2
    lui a1,2
    auipc a1,2
    lui a2,2
    auipc a2,2
    lui a1,2
    auipc a1,2
    lui a2,2
    auipc a2,2
    lui a1,2
    auipc a1,2
    lui a2,2
    auipc a2,2
    addi a0,a0,-1
    bnez a0,0b
    ret
