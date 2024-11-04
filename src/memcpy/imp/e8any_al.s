
.align 3
.globl my_memcpy
my_memcpy:
     # See if the whole transfer fits in one v reg group
    vsetvli a4,a2,e8,m1,ta,ma
    bne a4,a2,0f
1:  vle8.v v8,(a1)
    vse8.v v8,(a0)
    ret
0:  vsetvli a4,a2,e8,m2,ta,ma
    beq a4,a2,1b
    vsetvli a4,a2,e8,m4,ta,ma
    beq a4,a2,1b
    vsetvli a4,a2,e8,m8,ta,ma
    beq a4,a2,1b
     # Align src to 16 bytes
    li a5,16
    andi a3,a1,15
    sub a5,a5,a3
    vsetvli zero,a5,e8,m8,ta,ma
    vle8.v v8,(a1)
    add a1,a1,a5
    sub a2,a2,a5
    vse8.v v8,(a0)
    add a3,a0,a5
     # Now loop with m8
3:  vsetvli a4,a2,e8,m8,ta,ma
    vle8.v v8,(a1)
    vse8.v v8,(a3)
    bne a4,a2,2f
    ret
2:  add a1,a1,a4
    sub a2,a2,a4
    add a3,a3,a4
    j 3b
