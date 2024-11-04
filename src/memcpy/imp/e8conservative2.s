
.p2align 3
.globl my_memcpy
my_memcpy:
     # See if the whole transfer fits in m1, m2, or m8
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
     # Start looping with m8
3:  vsetvli a4,a2,e8,m8,ta,ma
    vle8.v v8,(a1)
    bne a4,a2,2f  # Do stuff while loading is happening
    vse8.v v8,(a3)
    ret
2:  add a1,a1,a4
    sub a2,a2,a4
    vse8.v v8,(a3)
    add a3,a3,a4
     # Only use as much lmul as necessary for the tail
    vsetvli a4,a2,e8,m1,ta,ma
    beq a4,a2,4f
    vsetvli a4,a2,e8,m2,ta,ma
    beq a4,a2,4f
    vsetvli a4,a2,e8,m4,ta,ma
    bne a4,a2,3b
4:  vle8.v v8,(a1)
    vse8.v v8,(a3)
    ret
