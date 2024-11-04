.data
self: .dword self
.zero 64  # separate by a cache line
other: .dword other

.text

.align 3
.globl misc
misc:
    li t0,10000000
    lla a0,self
    lla a1,other
0:
    sd a0,(a0)
    sd a1,(a1)
    sd a0,(a0)
    sd a1,(a1)
    sd a0,(a0)
    sd a1,(a1)
    sd a0,(a0)
    sd a1,(a1)
    sd a0,(a0)
    sd a1,(a1)
    sd a0,(a0)
    sd a1,(a1)
    sd a0,(a0)
    sd a1,(a1)
    sd a0,(a0)
    sd a1,(a1)
    sd a0,(a0)
    sd a1,(a1)
    sd a0,(a0)
    sd a1,(a1)
    addi t0,t0,-1
    bnez t0,0b
    ret

