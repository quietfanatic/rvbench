.data
self: .dword self, 0
other: .dword 0, 0, 0, 0

.text

.align 3
.globl misc
misc:
    li t0,10000000
    lla a0,self
    lla a1,other
0:
    lw a2,0(a0)
    lw a3,4(a0)
    sw a5,0(a1)
    sw a4,4(a1)
    lw a2,0(a0)
    lw a3,4(a0)
    sw a5,0(a1)
    sw a4,4(a1)
    lw a2,0(a0)
    lw a3,4(a0)
    sw a5,0(a1)
    sw a4,4(a1)
    lw a2,0(a0)
    lw a3,4(a0)
    sw a5,0(a1)
    sw a4,4(a1)
    lw a2,0(a0)
    lw a3,4(a0)
    sw a5,0(a1)
    sw a4,4(a1)
    lw a2,0(a0)
    lw a3,4(a0)
    sw a5,0(a1)
    sw a4,4(a1)
    lw a2,0(a0)
    lw a3,4(a0)
    sw a5,0(a1)
    sw a4,4(a1)
    lw a2,0(a0)
    lw a3,4(a0)
    sw a5,0(a1)
    sw a4,4(a1)
    lw a2,0(a0)
    lw a3,4(a0)
    sw a5,0(a1)
    sw a4,4(a1)
    lw a2,0(a0)
    lw a3,4(a0)
    sw a5,0(a1)
    sw a4,4(a1)
    addi t0,t0,-1
    bnez t0,0b
    ret

