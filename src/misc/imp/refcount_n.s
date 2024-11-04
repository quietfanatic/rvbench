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
    lw a2,4(s0)
    addi a2,a2,1
    sw a2,4(s0)
    lw a3,8(s0)
    addi a3,a3,1
    sw a3,8(s0)
    lw a4,12(s0)
    addi a4,a4,1
    sw a4,12(s0)
    lw a5,16(s0)
    addi a5,a5,1
    sw a5,16(s0)
    lw a1,(s0)
    addi a1,a1,1
    sw a1,(s0)
    lw a2,4(s0)
    addi a2,a2,1
    sw a2,4(s0)
    lw a3,8(s0)
    addi a3,a3,1
    sw a3,8(s0)
    lw a4,12(s0)
    addi a4,a4,1
    sw a4,12(s0)
    lw a5,16(s0)
    addi a5,a5,1
    sw a5,16(s0)
    addi a0,a0,-1
    bnez a0,0b
    ret
