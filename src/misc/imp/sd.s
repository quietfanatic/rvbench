.data
self: .dword self

.text

.align 3
.globl misc
misc:
    li t0,10000000
    lla a0,self
0:
    sd a0,(a0)
    sd a0,(a0)
    sd a0,(a0)
    sd a0,(a0)
    sd a0,(a0)
    sd a0,(a0)
    sd a0,(a0)
    sd a0,(a0)
    sd a0,(a0)
    sd a0,(a0)
    addi t0,t0,-1
    bnez t0,0b
    ret

