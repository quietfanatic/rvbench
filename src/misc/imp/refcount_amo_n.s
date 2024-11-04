.bss
stuff: .zero 2048

.text

.globl misc
misc:
    li a0,10000000
    lla s0,stuff
0:
    li a1,1
    addi a2,s0,0
    amoadd.w zero,a1,(a2)
    li a1,1
    addi a2,s0,4
    amoadd.w zero,a1,(a2)
    li a1,1
    addi a2,s0,8
    amoadd.w zero,a1,(a2)
    li a1,1
    addi a2,s0,12
    amoadd.w zero,a1,(a2)
    li a1,1
    addi a2,s0,16
    amoadd.w zero,a1,(a2)
    li a1,1
    addi a2,s0,0
    amoadd.w zero,a1,(a2)
    li a1,1
    addi a2,s0,4
    amoadd.w zero,a1,(a2)
    li a1,1
    addi a2,s0,8
    amoadd.w zero,a1,(a2)
    li a1,1
    addi a2,s0,12
    amoadd.w zero,a1,(a2)
    li a1,1
    addi a2,s0,16
    amoadd.w zero,a1,(a2)
    addi a0,a0,-1
    bnez a0,0b
    ret
