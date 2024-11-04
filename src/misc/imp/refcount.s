.bss
stuff: .zero 2048

.text

.globl misc
misc:
    li a0,10000000
    lla s0,stuff
    lla s1,stuff+128
0:
    lw a1,(s0)
    addi a1,a1,1
    sw a1,(s0)
    lw a2,64(s0)
    addi a2,a2,1
    sw a2,64(s0)
    lw a3,(s1)
    addi a3,a3,1
    sw a3,(s1)
    lw a4,64(s1)
    addi a4,a4,1
    sw a4,64(s1)
    lw a5,128(s1)
    addi a5,a5,1
    sw a5,128(s1)
    lw a1,(s0)
    addi a1,a1,1
    sw a1,(s0)
    lw a2,64(s0)
    addi a2,a2,1
    sw a2,64(s0)
    lw a3,(s1)
    addi a3,a3,1
    sw a3,(s1)
    lw a4,64(s1)
    addi a4,a4,1
    sw a4,64(s1)
    lw a5,128(s1)
    addi a5,a5,1
    sw a5,128(s1)
    addi a0,a0,-1
    bnez a0,0b
    ret
