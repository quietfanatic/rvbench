.p2align 3
.globl my_memcmp
my_memcmp:
    beqz a2,1f
    add a2,a2,a0
0:  lbu a3,(a0)
    addi a0,a0,1
    lbu a4,(a1)
    addi a1,a1,1
    bne a3,a4,2f
    bne a0,a2,0b
1:  li a0,0
    ret
2:  sub a0,a3,a4
    ret
