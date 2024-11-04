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
0:  lbu a0,0(a4)
    lbu a1,1(a4)
    lbu a2,2(a4)
    lbu a3,3(a4)
    sb a0,0(a5)
    sb a1,1(a5)
    sb a2,2(a5)
    sb a3,3(a5)
    lbu a0,4(a4)
    lbu a1,5(a4)
    lbu a2,6(a4)
    lbu a3,7(a4)
    sb a0,4(a5)
    sb a1,5(a5)
    sb a2,6(a5)
    sb a3,7(a5)
    lbu a0,8(a4)
    lbu a1,9(a4)
    lbu a2,10(a4)
    lbu a3,11(a4)
    sb a0,8(a5)
    sb a1,9(a5)
    sb a2,10(a5)
    sb a3,11(a5)
    lbu a0,12(a4)
    lbu a1,13(a4)
    lbu a2,14(a4)
    lbu a3,15(a4)
    sb a0,12(a5)
    sb a1,13(a5)
    sb a2,14(a5)
    sb a3,15(a5)
    lbu a0,16(a4)
    lbu a1,17(a4)
    lbu a2,18(a4)
    lbu a3,19(a4)
    sb a0,16(a5)
    sb a1,17(a5)
    sb a2,18(a5)
    sb a3,19(a5)
    lbu a0,20(a4)
    lbu a1,21(a4)
    lbu a2,22(a4)
    lbu a3,23(a4)
    sb a0,20(a5)
    sb a1,21(a5)
    sb a2,22(a5)
    sb a3,23(a5)
    addi t0,t0,-1
    bnez t0,0b
    ret

