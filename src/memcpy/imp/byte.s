.text

.p2align 3
.globl my_memcpy
my_memcpy:
    beqz a2,0f
    mv a3,a0
1:  lbu a4,(a1)
    addi a1,a1,1
    addi a2,a2,-1
    sb a4,(a3)
    addi a3,a3,1
    bnez a2,1b
0:  ret
