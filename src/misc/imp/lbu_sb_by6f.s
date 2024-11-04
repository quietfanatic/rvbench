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
    lla s0,src
    lla s1,dst
0:  lbu a0,0(s0)
    lbu a1,8(s0)
    lbu a2,16(s0)
    lbu a3,24(s0)
    lbu a4,32(s0)
    lbu a5,40(s0)
    sb a0,0(s1)
    sb a1,8(s1)
    sb a2,16(s1)
    sb a3,24(s1)
    sb a4,32(s1)
    sb a5,40(s1)
    lbu a0,48(s0)
    lbu a1,56(s0)
    lbu a2,64(s0)
    lbu a3,72(s0)
    lbu a4,80(s0)
    lbu a5,88(s0)
    sb a0,48(s1)
    sb a1,56(s1)
    sb a2,64(s1)
    sb a3,72(s1)
    sb a4,80(s1)
    sb a5,88(s1)
    lbu a0,96(s0)
    lbu a1,104(s0)
    lbu a2,112(s0)
    lbu a3,120(s0)
    lbu a4,128(s0)
    lbu a5,136(s0)
    sb a0,96(s1)
    sb a1,104(s1)
    sb a2,112(s1)
    sb a3,120(s1)
    sb a4,128(s1)
    sb a5,136(s1)
    lbu a0,144(s0)
    lbu a1,152(s0)
    lbu a2,160(s0)
    lbu a3,168(s0)
    lbu a4,176(s0)
    lbu a5,184(s0)
    sb a0,144(s1)
    sb a1,152(s1)
    sb a2,160(s1)
    sb a3,168(s1)
    sb a4,176(s1)
    sb a5,184(s1)
    addi t0,t0,-1
    bnez t0,0b
    ret


