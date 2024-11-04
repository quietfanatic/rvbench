
.p2align 3
.globl my_memcpy
my_memcpy:
    vsetvli a4,a2,e8,m1,ta,ma
    bne a4,a2,0f
1:  vle8.v v8,(a1)
    vse8.v v8,(a0)
    ret
0:  vsetvli a4,a2,e8,m2,ta,ma
    beq a4,a2,1b
    vsetvli a5,a2,e8,m4,ta,ma
    beq a5,a2,1b
    vsetvli a4,a2,e8,m8,ta,ma
    beq a4,a2,1b
     # vl might not be quite vlmax here (spec 31.6.3) so use previous vl
    slli a5,a5,1
    mv a3,a0
3:  vl8re8.v v8,(a1)
    add a1,a1,a5
    sub a2,a2,a5
    vs8r.v v8,(a3)
    add a3,a3,a5
    bgt a2,a5,3b
    vsetvli a4,a2,e8,m1,ta,ma
    beq a4,a2,4f
    vsetvli a4,a2,e8,m2,ta,ma
    beq a4,a2,4f
    vsetvli a4,a2,e8,m4,ta,ma
    beq a4,a2,4f
    vsetvli a4,a2,e8,m8,ta,ma
4:  vle8.v v8,(a1)
    vse8.v v8,(a3)
    ret
