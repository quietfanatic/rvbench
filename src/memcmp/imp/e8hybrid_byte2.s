 # This is like e8hybrid, but checks one byte at the beginning.
.p2align 3
.globl my_memcmp
my_memcmp:
    beqz a2,0f
    lbu a3,(a0)
    lbu a4,(a1)
    beq a3,a4,4f
    sub a0,a3,a4
    ret
4:  vsetvli a4,a2,e8,m1,ta,ma
2:  vle8.v v8,(a0)  # tail (don't loop)
    vle8.v v16,(a1)
    vmsne.vv v0,v8,v16
    vfirst.m a3,v0
    bgez a3,1f
    beq a4,a2,0f
    add a0,a0,a4
    sub a2,a2,a4
    add a1,a1,a4
    vsetvli a4,a2,e8,m1,ta,ma
    beq a4,a2,3f
    vsetvli a4,a2,e8,m2,ta,ma
    beq a4,a2,3f
    vsetvli a4,a2,e8,m4,ta,ma
    beq a4,a2,3f
    vsetvli a4,a2,e8,m8,ta,ma
    bne a4,a2,2b
3:  vle8.v v8,(a0)  # body (do loop)
    vle8.v v16,(a1)
    vmsne.vv v0,v8,v16
    vfirst.m a3,v0
    bgez a3,1f
0:  li a0,0
    ret
1:  add a0,a0,a3
    add a1,a1,a3
    lbu a0,(a0)
    lbu a1,(a1)
    sub a0,a0,a1
    ret
