
.p2align 3
.globl my_memcpy
my_memcpy:
    mv a3,a0
1:  vsetvli a4,a2,e8,m1,ta,ma
    vle8.v v8,(a1)
    add a1,a1,a4
    sub a2,a2,a4
    vse8.v v8,(a3)
    add a3,a3,a4
    bnez a2,1b
    ret
