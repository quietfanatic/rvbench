
.p2align 3
.globl my_memcpy
my_memcpy:
    vsetvli a4,a2,e8,m1,ta,ma
    vle8.v v8,(a1)
    vse8.v v8,(a0)
    bne a4,a2,0f
    ret
0:  add a1,a1,a4
    sub a2,a2,a4
    add a3,a0,a4
    j 1f
    .p2align 3
2:  add a1,a1,a4
    sub a2,a2,a4
    add a3,a3,a4
1:  vsetvli a4,a2,e8,m1,ta,ma
    vle8.v v8,(a1)
    vse8.v v8,(a3)
    bne a4,a2,2b
    ret
