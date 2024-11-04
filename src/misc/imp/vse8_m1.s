.data
.align 3
dst0: .zero 32
dst1: .zero 32

.text
.align 3
.globl misc
misc:
    li t0,10000000
    lla a0,dst0
    lla a1,dst1
    li a2,32
    vsetvli zero,a2,e8,m1,ta,ma
0:
    vse8.v v8,(a0)
    vse8.v v8,(a1)
    vse8.v v8,(a0)
    vse8.v v8,(a1)
    vse8.v v8,(a0)
    vse8.v v8,(a1)
    vse8.v v8,(a0)
    vse8.v v8,(a1)
    vse8.v v8,(a0)
    vse8.v v8,(a1)
    addi t0,t0,-1
    bnez t0,0b
    ret
