
.p2align
.globl my_memcpy
my_memcpy:
    vsetvli a4,a2,e8,m1,ta,ma
    bne a4,a2,0f
1:  vle8.v v8,(a1)
    vse8.v v8,(a0)
    ret
0:  vsetvli a4,a2,e8,m2,ta,ma
    beq a4,a2,1b
    vsetvli a4,a2,e8,m4,ta,ma
    beq a4,a2,1b
    mv a3,a0
      .p2align
2:  vsetvli a4,a2,e8,m8,ta,ma
    vle8.v v8,(a1)
    add a1,a1,a4
    sub a2,a2,a4
    vse8.v v8,(a3)
    add a3,a3,a4
    bnez a2,2b
    ret
