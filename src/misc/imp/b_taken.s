.align 3
.globl misc
misc:
    li a0,10000000
    li a1,1
0:
    bnez a1,1f
1:  bnez a1,1f
1:  bnez a1,1f
1:  bnez a1,1f
1:  bnez a1,1f
1:  bnez a1,1f
1:  bnez a1,1f
1:  bnez a1,1f
1:  bnez a1,1f
1:  bnez a1,1f
1:  bnez a1,1f
1:  bnez a1,1f
1:  bnez a1,1f
1:  bnez a1,1f
1:  bnez a1,1f
1:  bnez a1,1f
1:  bnez a1,1f
1:  bnez a1,1f
1:  bnez a1,1f
1:  bnez a1,1f
1:  addi a0,a0,-1
    bnez a0,0b
    ret
