.data
.align 3
src0: .zero 32
src1: .zero 32

.text
.align 3
.globl misc
misc:
    li t0,10000000
    lla a0,src0
    lla a1,src1
    li a2,32
    vsetvli zero,a2,e8,m1,ta,ma
0:
    vle8.v v8,(a0)
    vle8.v v16,(a1)
    vle8.v v8,(a0)
    vle8.v v16,(a1)
    vle8.v v8,(a0)
    vle8.v v16,(a1)
    vle8.v v8,(a0)
    vle8.v v16,(a1)
    vle8.v v8,(a0)
    vle8.v v16,(a1)
    addi t0,t0,-1
    bnez t0,0b
    ret
