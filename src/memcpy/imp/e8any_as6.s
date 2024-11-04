
.align 3
.globl my_memcpy
my_memcpy:
     # See if the whole transfer fits in one v reg group
    vsetvli a4,a2,e8,m1,ta,ma
    bne a4,a2,0f
1:  vle8.v v8,(a1)
2:  vse8.v v8,(a0)
    ret
0:  vsetvli a4,a2,e8,m2,ta,ma
    beq a4,a2,1b
    vsetvli a4,a2,e8,m4,ta,ma
    beq a4,a2,1b
    vsetvli a4,a2,e8,m8,ta,ma
    vle8.v v8,(a1)  # Start load while we do some calculations
    beq a4,a2,2b
     # If it's gonna take more than 1 transfer, start later ones at a 16-byte
     # boundary.
    andi a5,a0,15
    vse8.v v8,(a0)
    sub a4,a4,a5
    mv a3,a0
3:  add a1,a1,a4
    sub a2,a2,a4
    add a3,a3,a4
    vsetvli a4,a2,e8,m8,ta,ma
    vle8.v v8,(a1)
    vse8.v v8,(a3)
    bne a4,a2,3b
    ret
