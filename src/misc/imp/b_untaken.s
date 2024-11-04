.align 3
.globl misc
misc:
    li a0,10000000
    li a1,1
0:
    beqz a1,1f
    beqz a1,1f
    beqz a1,1f
    beqz a1,1f
    beqz a1,1f
    beqz a1,1f
    beqz a1,1f
    beqz a1,1f
    beqz a1,1f
    beqz a1,1f
    beqz a1,1f
    beqz a1,1f
    beqz a1,1f
    beqz a1,1f
    beqz a1,1f
    beqz a1,1f
    beqz a1,1f
    beqz a1,1f
    beqz a1,1f
    beqz a1,1f
    addi a0,a0,-1
    bnez a0,0b
    ret
1:  unimp
