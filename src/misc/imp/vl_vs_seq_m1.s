.data
.align 4
src: .zero 256
dst0: .zero 256
dst1: .zero 256

.text
.align 3
.globl misc
misc:
    li t0,10000000
    lla a0,dst0
    lla a1,dst1
    lla a3,src
    li a2,32
    vsetvli zero,a2,e8,m1,ta,ma
0:
    vle8.v v8,(a3)
    vse8.v v8,(a0)
    vle8.v v8,(a3)
    vse8.v v8,(a0)
    vle8.v v8,(a3)
    vse8.v v8,(a0)
    vle8.v v8,(a3)
    vse8.v v8,(a0)
    vle8.v v8,(a3)
    vse8.v v8,(a0)
    vle8.v v8,(a3)
    vse8.v v8,(a0)
    vle8.v v8,(a3)
    vse8.v v8,(a0)
    vle8.v v8,(a3)
    vse8.v v8,(a0)
    vle8.v v8,(a3)
    vse8.v v8,(a0)
    vle8.v v8,(a3)
    vse8.v v8,(a0)
    addi t0,t0,-1
    bnez t0,0b
    ret
