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
    ld a2,0(a0)
    ld a3,8(a0)
    sd a1,0(a1)
    sd a1,8(a1)
    sd a1,16(a1)
    sd a1,24(a1)
    ld a2,0(a0)
    ld a3,8(a0)
    sd a1,0(a1)
    sd a1,8(a1)
    sd a1,16(a1)
    sd a1,24(a1)
    ld a2,0(a0)
    ld a3,8(a0)
    sd a1,0(a1)
    sd a1,8(a1)
    sd a1,16(a1)
    sd a1,24(a1)
    ld a2,0(a0)
    ld a3,8(a0)
    sd a1,0(a1)
    sd a1,8(a1)
    sd a1,16(a1)
    sd a1,24(a1)
    ld a2,0(a0)
    ld a3,8(a0)
    sd a1,0(a1)
    sd a1,8(a1)
    sd a1,16(a1)
    sd a1,24(a1)
    ld a2,0(a0)
    ld a3,8(a0)
    sd a1,0(a1)
    sd a1,8(a1)
    sd a1,16(a1)
    sd a1,24(a1)
    ld a2,0(a0)
    ld a3,8(a0)
    sd a1,0(a1)
    sd a1,8(a1)
    sd a1,16(a1)
    sd a1,24(a1)
    ld a2,0(a0)
    ld a3,8(a0)
    sd a1,0(a1)
    sd a1,8(a1)
    sd a1,16(a1)
    sd a1,24(a1)
    ld a2,0(a0)
    ld a3,8(a0)
    sd a1,0(a1)
    sd a1,8(a1)
    sd a1,16(a1)
    sd a1,24(a1)
    ld a2,0(a0)
    ld a3,8(a0)
    sd a1,0(a1)
    sd a1,8(a1)
    sd a1,16(a1)
    sd a1,24(a1)
    addi t0,t0,-1
    bnez t0,0b
    ret

