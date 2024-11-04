.bss
foo: .zero 10000
.text

.align 3
.globl misc
misc:
    li a0,10000000
    lla a3,foo
    mv a1,a3
0:
    ld a2,(a1)
    addi a1,a1,8
    addi a4,a4,1
    ld a2,(a1)
    addi a1,a1,8
    addi a4,a4,1
    ld a2,(a1)
    addi a1,a1,8
    addi a4,a4,1
    ld a2,(a1)
    addi a1,a1,8
    addi a4,a4,1
    ld a2,(a1)
    addi a1,a1,8
    addi a4,a4,1
    ld a2,(a1)
    addi a1,a1,8
    addi a4,a4,1
    ld a2,(a1)
    addi a1,a1,8
    addi a4,a4,1
    ld a2,(a1)
    addi a1,a1,8
    addi a4,a4,1
    ld a2,(a1)
    addi a1,a1,8
    addi a4,a4,1
    ld a2,(a1)
    addi a1,a1,8
    addi a4,a4,1
    addi a0,a0,-1
    mv a1,a3
    bnez a0,0b
    ret
