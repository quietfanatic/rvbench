.bss
.align 3
 # Largest offset that ld and sd can be compressed is 248, and we want a number
 # divisible by 12.  This file won't use compression but a parallel one will.
src: .zero 192
.align 3
dst: .zero 192

.text

.align 3
.globl misc
misc:
     # These should all take 8 bytes, aligning the loop to 8 bytes
    li t0,10000000
    lla a4,src
    lla a5,dst
0:  lh a0,0/4(a4)
    lh a1,8/4(a4)
    lh a2,16/4(a4)
    lh a3,24/4(a4)
    sh a0,0/4(a5)
    sh a1,8/4(a5)
    sh a2,16/4(a5)
    sh a3,24/4(a5)
    lh a0,32/4(a4)
    lh a1,40/4(a4)
    lh a2,48/4(a4)
    lh a3,56/4(a4)
    sh a0,32/4(a5)
    sh a1,40/4(a5)
    sh a2,48/4(a5)
    sh a3,56/4(a5)
    lh a0,64/4(a4)
    lh a1,72/4(a4)
    lh a2,80/4(a4)
    lh a3,88/4(a4)
    sh a0,64/4(a5)
    sh a1,72/4(a5)
    sh a2,80/4(a5)
    sh a3,88/4(a5)
    lh a0,96/4(a4)
    lh a1,104/4(a4)
    lh a2,112/4(a4)
    lh a3,120/4(a4)
    sh a0,96/4(a5)
    sh a1,104/4(a5)
    sh a2,112/4(a5)
    sh a3,120/4(a5)
    lh a0,128/4(a4)
    lh a1,136/4(a4)
    lh a2,144/4(a4)
    lh a3,152/4(a4)
    sh a0,128/4(a5)
    sh a1,136/4(a5)
    sh a2,144/4(a5)
    sh a3,152/4(a5)
    lh a0,160/4(a4)
    lh a1,168/4(a4)
    lh a2,176/4(a4)
    lh a3,184/4(a4)
    sh a0,160/4(a5)
    sh a1,168/4(a5)
    sh a2,176/4(a5)
    sh a3,184/4(a5)
    addi t0,t0,-1
    bnez t0,0b
    ret

