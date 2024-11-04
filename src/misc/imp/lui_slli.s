.bss
foo: .zero 8

.text
.globl misc
misc:
    li a0,10000000
0:
1:  lui a1,2
    slli a1,a1,4
1:  lui a2,2
    slli a2,a2,4
1:  lui a1,2
    slli a1,a1,4
1:  lui a2,2
    slli a2,a2,4
1:  lui a1,2
    slli a1,a1,4
1:  lui a2,2
    slli a2,a2,4
1:  lui a1,2
    slli a1,a1,4
1:  lui a2,2
    slli a2,a2,4
1:  lui a1,2
    slli a1,a1,4
1:  lui a2,2
    slli a2,a2,4
1:  lui a1,2
    slli a1,a1,4
1:  lui a2,2
    slli a2,a2,4
1:  lui a1,2
    slli a1,a1,4
1:  lui a2,2
    slli a2,a2,4
1:  lui a1,2
    slli a1,a1,4
1:  lui a2,2
    slli a2,a2,4
1:  lui a1,2
    slli a1,a1,4
1:  lui a2,2
    slli a2,a2,4
1:  lui a1,2
    slli a1,a1,4
1:  lui a2,2
    slli a2,a2,4
    addi a0,a0,-1
    bnez a0,0b
    ret
