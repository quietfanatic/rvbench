.align 3
.globl misc
misc:
    li a0,10000000
    li a4,0x182a9  # Crude LSFR
0:
    andi a2,a4,31 # make output fairly predictable
    srli a5,a4,5
    srli a4,a4,1
    xor a5,a5,a2
    andi a5,a5,1
    slli a5,a5,22
    or a4,a4,a5
1:  mv a3,a1
    beqz a2,1f
    mv a3,a2
1:  mv a3,a1
    beqz a2,1f
    mv a3,a2
1:  mv a3,a1
    beqz a2,1f
    mv a3,a2
1:  mv a3,a1
    beqz a2,1f
    mv a3,a2
1:  mv a3,a1
    beqz a2,1f
    mv a3,a2
1:  mv a3,a1
    beqz a2,1f
    mv a3,a2
1:  mv a3,a1
    beqz a2,1f
    mv a3,a2
1:  mv a3,a1
    beqz a2,1f
    mv a3,a2
1:  mv a3,a1
    beqz a2,1f
    mv a3,a2
1:  mv a3,a1
    beqz a2,1f
    mv a3,a2
1:  addi a0,a0,-1
    bnez a0,0b
    ret
