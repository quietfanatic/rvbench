.p2align 3
.globl my_memcmp
my_memcmp:
    vsetvli a4,a2,e8,m1,ta,ma
    vle8.v v8,(a0)
    vle8.v v16,(a1)
    vmsne.vv v0,v8,v16
    vfirst.m a3,v0
    bltz a3,0f
1:  add a0,a0,a3
    add a1,a1,a3
    lbu a0,(a0)
    lbu a1,(a1)
    sub a0,a0,a1
    ret
0:  bne a4,a2,4f
2:  li a0,0
    ret
4:  add a0,a0,a4
    sub a2,a2,a4
    add a1,a1,a4
    vsetvli a4,a2,e8,m2,ta,ma
    vle8.v v8,(a0)
    vle8.v v16,(a1)
    vmsne.vv v0,v8,v16
    vfirst.m a3,v0
    bgez a3,1b
    beq a4,a2,2b
    add a0,a0,a4
    sub a2,a2,a4
    add a1,a1,a4
    vsetvli a4,a2,e8,m4,ta,ma
3:  vle8.v v8,(a0)
    vle8.v v16,(a1)
    vmsne.vv v0,v8,v16
    vfirst.m a3,v0
    bgez a3,1b
    beq a4,a2,2b
    add a0,a0,a4
    sub a2,a2,a4
    add a1,a1,a4
    vsetvli a4,a2,e8,m8,ta,ma
    j 3b
