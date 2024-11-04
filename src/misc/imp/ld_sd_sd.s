.data
foo: .dword foo
self: .dword self
# .zero 2040 # Causes no delay
# .zero 4080 # Causes failure of parallelism due to false near-miss
# .zero 4088 # Causes store-forwarding delay due to false overlap
other: .dword other

.text

.align 3
.globl misc
misc:
    li t0,10000000
    lla a0,self
    lla a1,other
0:
    ld a0,(a0)
    sd a1,(a1)
    sd a1,(a1)
    ld a0,(a0)
    sd a1,(a1)
    sd a1,(a1)
    ld a0,(a0)
    sd a1,(a1)
    sd a1,(a1)
    ld a0,(a0)
    sd a1,(a1)
    sd a1,(a1)
    ld a0,(a0)
    sd a1,(a1)
    sd a1,(a1)
    ld a0,(a0)
    sd a1,(a1)
    sd a1,(a1)
    ld a0,(a0)
    sd a1,(a1)
    sd a1,(a1)
    ld a0,(a0)
    sd a1,(a1)
    sd a1,(a1)
    ld a0,(a0)
    sd a1,(a1)
    sd a1,(a1)
    ld a0,(a0)
    sd a1,(a1)
    sd a1,(a1)
    addi t0,t0,-1
    bnez t0,0b
    ret

