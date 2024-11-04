.p2align 3
.globl my_memcmp
my_memcmp:
2:  vsetvli a4,a2,e8,m1,ta,ma
    vle8.v v8,(a0)
    vle8.v v16,(a1)
    vmsne.vv v0,v8,v16
    vfirst.m a3,v0
    bgez a3,0f
    bne a4,a2,1f
    li a0,0
    ret
1:  add a0,a0,a4
    sub a2,a2,a4
    add a1,a1,a4
    j 2b
0:   # Sadly it's easier to load from memory than index a vector
    add a0,a0,a3
    add a1,a1,a3
    lbu a0,(a0)
    lbu a1,(a1)
    sub a0,a0,a1
    ret
