
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
     # If it's gonna take more than 1 transfer, do later ones starting at a 16
     # byte alignment
    andi a5,a0,15
    sub a5,a4,a5
    vle8.v v8,(a1)
    add a1,a1,a5
    sub a2,a2,a5
    vse8.v v8,(a0)
    add a3,a0,a5
     # For a tighter inner loop, calculate an end pointer
    add a6,a0,a2
    sub a5,a6,a5
3:  vle8.v v8,(a1)  # The Loop
    add a1,a1,a4
    vse8.v v8,(a3)
    add a3,a3,a4
    blt a3,a5,3b
     # Now do final transfer
    sub a2,a6,a3
    vsetvli zero,a2,e8,m8,ta,ma
    vle8.v v8,(a1)
    vse8.v v8,(a3)
    ret
