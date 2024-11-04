
.align 3
.globl my_memcpy
my_memcpy:
    mv a3,a0
     # See if the whole transfer fits in one v reg group
4:  vsetvli a4,a2,e8,m1,ta,ma
    bne a4,a2,0f
1:  vle8.v v8,(a1)
    vse8.v v8,(a3)
    ret
0:  vsetvli a4,a2,e8,m2,ta,ma
    beq a4,a2,1b
    vsetvli a4,a2,e8,m4,ta,ma
    beq a4,a2,1b
    vsetvli a4,a2,e8,m8,ta,ma
    beq a4,a2,1b
     # If it's gonna take more than 1 transfer, shorten first transfer so that
     # later ones have their dst aligned to 16 bytes
    andi a5,a3,15
    sub a4,a4,a5
    vsetvli zero,a4,e8,m8,ta,ma
3:  vle8.v v8,(a1)
    add a1,a1,a4
    sub a2,a2,a4
    vse8.v v8,(a3)
    add a3,a3,a4
    j 4b
