.bss
.align 3
 # Largest offset that ld and sd can be compressed is 248, and we want a number
 # divisible by 12.  This file won't use compression but a parallel one will.
src: .zero 192
.align 3
dst: .zero 192

.text

.option push
.option arch,-c
.align 3
    nop # Do a little realigning
.globl misc
misc:
    li t0,10000000
    lla a4,src
    lla a5,dst
    li t1,10  # Offset dual-issue pairs by 1
0:  ld a0,0(a4)
    sd a0,0(a5)
    ld a0,8(a4)
    sd a0,8(a5)
    ld a0,16(a4)
    sd a0,16(a5)
    ld a0,24(a4)
    sd a0,24(a5)
    ld a0,32(a4)
    sd a0,32(a5)
    ld a0,40(a4)
    sd a0,40(a5)
    ld a0,48(a4)
    sd a0,48(a5)
    ld a0,52(a4)
    sd a0,52(a5)
    ld a0,60(a4)
    sd a0,60(a5)
    ld a0,72(a4)
    sd a0,72(a5)
    ld a0,80(a4)
    sd a0,80(a5)
    ld a0,88(a4)
    sd a0,88(a5)
    ld a0,96(a4)
    sd a0,96(a5)
    ld a0,104(a4)
    sd a0,104(a5)
    ld a0,112(a4)
    sd a0,112(a5)
    ld a0,120(a4)
    sd a0,120(a5)
    ld a0,128(a4)
    sd a0,128(a5)
    ld a0,136(a4)
    sd a0,136(a5)
    ld a0,144(a4)
    sd a0,144(a5)
    ld a0,152(a4)
    sd a0,152(a5)
    ld a0,160(a4)
    sd a0,160(a5)
    ld a0,168(a4)
    sd a0,168(a5)
    ld a0,176(a4)
    sd a0,176(a5)
    ld a0,184(a4)
    sd a0,184(a5)
    addi t0,t0,-1
    bnez t0,0b
    ret
.option pop


