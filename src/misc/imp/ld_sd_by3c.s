.bss
.align 3
 # Largest offset that ld and sd can be compressed is 248, and we want a number
 # divisible by 12.  This file won't use compression but a parallel one will.
src: .zero 192
.align 3
dst: .zero 192

.text

.align 3
.globl misc
misc:
     # These should all take 8 bytes, aligning the loop to 8 bytes
    li t0,10000000
    lla a4,src
    lla a5,dst
0:  ld a0,0(a4)
    ld a1,8(a4)
    ld a2,16(a4)
    sd a0,0(a5)
    sd a1,8(a5)
    sd a2,16(a5)
    ld a0,24(a4)
    ld a1,32(a4)
    ld a2,40(a4)
    sd a0,24(a5)
    sd a1,32(a5)
    sd a2,40(a5)
    ld a0,48(a4)
    ld a1,56(a4)
    ld a2,64(a4)
    sd a0,48(a5)
    sd a1,56(a5)
    sd a2,64(a5)
    ld a0,72(a4)
    ld a1,80(a4)
    ld a2,88(a4)
    sd a0,72(a5)
    sd a1,80(a5)
    sd a2,88(a5)
    ld a0,96(a4)
    ld a1,104(a4)
    ld a2,112(a4)
    sd a0,96(a5)
    sd a1,104(a5)
    sd a2,112(a5)
    ld a0,120(a4)
    ld a1,128(a4)
    ld a2,136(a4)
    sd a0,120(a5)
    sd a1,128(a5)
    sd a2,136(a5)
    ld a0,144(a4)
    ld a1,152(a4)
    ld a2,160(a4)
    sd a0,144(a5)
    sd a1,152(a5)
    sd a2,160(a5)
    ld a0,168(a4)
    ld a1,176(a4)
    ld a2,184(a4)
    sd a0,168(a5)
    sd a1,176(a5)
    sd a2,184(a5)
    addi t0,t0,-1
    bnez t0,0b
    ret

