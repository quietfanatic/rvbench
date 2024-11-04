.align 3
.globl misc
misc:
    li a0,10000000
    li a1,1
    li a2,1
0:
1:  addi a5,a5,1
    addi a3,a3,1
    addi a1,a1,1
    bnez a1,1f
    nop
    nop
    nop
1:  addi a6,a6,1
    addi a4,a4,1
    addi a2,a2,1
    bnez a2,1f
    nop
    nop
    nop
1:  addi a5,a5,1
    addi a3,a3,1
    addi a1,a1,1
    bnez a1,1f
    nop
    nop
    nop
1:  addi a6,a6,1
    addi a4,a4,1
    addi a2,a2,1
    bnez a2,1f
    nop
    nop
    nop
1:  addi a5,a5,1
    addi a3,a3,1
    addi a1,a1,1
    bnez a1,1f
    nop
    nop
    nop
1:  addi a6,a6,1
    addi a4,a4,1
    addi a2,a2,1
    bnez a2,1f
    nop
    nop
    nop
1:  addi a5,a5,1
    addi a3,a3,1
    addi a1,a1,1
    bnez a1,1f
    nop
    nop
    nop
1:  addi a6,a6,1
    addi a4,a4,1
    addi a2,a2,1
    bnez a2,1f
    nop
    nop
    nop
1:  addi a5,a5,1
    addi a3,a3,1
    addi a1,a1,1
    bnez a1,1f
    nop
    nop
    nop
1:  addi a6,a6,1
    addi a4,a4,1
    addi a2,a2,1
    bnez a2,1f
    nop
    nop
    nop
1:  addi a5,a5,1
    addi a3,a3,1
    addi a1,a1,1
    bnez a1,1f
    nop
    nop
    nop
1:  addi a6,a6,1
    addi a4,a4,1
    addi a2,a2,1
    bnez a2,1f
    nop
    nop
    nop
1:  addi a5,a5,1
    addi a3,a3,1
    addi a1,a1,1
    bnez a1,1f
    nop
    nop
    nop
1:  addi a6,a6,1
    addi a4,a4,1
    addi a2,a2,1
    bnez a2,1f
    nop
    nop
    nop
1:  addi a5,a5,1
    addi a3,a3,1
    addi a1,a1,1
    bnez a1,1f
    nop
    nop
    nop
1:  addi a6,a6,1
    addi a4,a4,1
    addi a2,a2,1
    bnez a2,1f
    nop
    nop
    nop
1:  addi a5,a5,1
    addi a3,a3,1
    addi a1,a1,1
    bnez a1,1f
    nop
    nop
    nop
1:  addi a6,a6,1
    addi a4,a4,1
    addi a2,a2,1
    bnez a2,1f
    nop
    nop
    nop
1:  addi a5,a5,1
    addi a3,a3,1
    addi a1,a1,1
    bnez a1,1f
    nop
    nop
    nop
1:  addi a6,a6,1
    addi a4,a4,1
    addi a2,a2,1
    bnez a2,1f
    nop
    nop
    nop
1:  addi a0,a0,-1
    bnez a0,0b
    ret
