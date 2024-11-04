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
    li t0,10000000
    lla a4,src
    lla a5,dst
.option push
.option arch,-c
0:  lw a0,0(a4)
    sw a0,0(a5)
    lw a0,8(a4)
    sw a0,8(a5)
    lw a0,16(a4)
    sw a0,16(a5)
    lw a0,24(a4)
    sw a0,24(a5)
    lw a0,32(a4)
    sw a0,32(a5)
    lw a0,40(a4)
    sw a0,40(a5)
    lw a0,48(a4)
    sw a0,48(a5)
    lw a0,56(a4)
    sw a0,56(a5)
    lw a0,64(a4)
    sw a0,64(a5)
    lw a0,72(a4)
    sw a0,72(a5)
    lw a0,80(a4)
    sw a0,80(a5)
    lw a0,88(a4)
    sw a0,88(a5)
    lw a0,96(a4)
    sw a0,96(a5)
    lw a0,104(a4)
    sw a0,104(a5)
    lw a0,112(a4)
    sw a0,112(a5)
    lw a0,120(a4)
    sw a0,120(a5)
    lw a0,128(a4)
    sw a0,128(a5)
    lw a0,136(a4)
    sw a0,136(a5)
    lw a0,144(a4)
    sw a0,144(a5)
    lw a0,152(a4)
    sw a0,152(a5)
    lw a0,160(a4)
    sw a0,160(a5)
    lw a0,168(a4)
    sw a0,168(a5)
    lw a0,176(a4)
    sw a0,176(a5)
    lw a0,184(a4)
    sw a0,184(a5)
.option pop
    addi t0,t0,-1
    bnez t0,0b
    ret

