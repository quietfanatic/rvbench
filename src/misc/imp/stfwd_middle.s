.bss
.align 3
stuff: .zero 16

.text

.align 3
.globl misc
misc:
    li t0,10000000
    lla a4,stuff
0:  sd a0,0(a4)
    lw a0,2(a4)
    sd a0,0(a4)
    lw a0,2(a4)
    sd a0,0(a4)
    lw a0,2(a4)
    sd a0,0(a4)
    lw a0,2(a4)
    sd a0,0(a4)
    lw a0,2(a4)
    sd a0,0(a4)
    lw a0,2(a4)
    sd a0,0(a4)
    lw a0,2(a4)
    sd a0,0(a4)
    lw a0,2(a4)
    sd a0,0(a4)
    lw a0,2(a4)
    sd a0,0(a4)
    lw a0,2(a4)
    addi t0,t0,-1
    bnez t0,0b
    ret
