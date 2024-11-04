.bss

dst: .zero 66000
src: .zero 66000

.section .rodata

sizes:
    .word 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17
    .word 31,32,33,63,64,65,127,128,129,255,256,257
    .word 511,512,513,1023,1024,1025,5000,65535,65536,65537
sizes_end:
.set sizes_size, sizes_end - sizes

.text

test_size:
    .cfi_startproc
    addi sp,sp,-16
    sd s0,8(sp)
    .cfi_offset 8,8
    sd ra,0(sp)
    .cfi_offset 1,0
    mv s0,a0
     # clear dst
    addi a1,s0,80
    lla a0,dst
    add a1,a1,a0
0:  sb zero,(a0)
    addi a0,a0,1
    bne a0,a1,0b
     # call
    lla a0,dst+40
    lla a1,src
    mv a2,s0
    call my_memcpy
     # verify
    lla a1,dst
    add a2,a1,40
     # verify return value
    beq a0,a2,1f
    unimp
1:   # verify head
0:  ld a0,(a1)
    beqz a0,1f
    unimp
1:  addi a1,a1,8
    bne a1,a2,0b
     # verify body
    beqz s0,2f
    add a2,a1,s0
    li a4,0
0:  lbu a0,(a1)
    ori a5,a4,0x80
    andi a5,a5,0xff
    beq a0,a5,1f
    unimp
1:  addi a1,a1,1
    addi a4,a4,1
    bne a1,a2,0b
2:   # verify tail
    add a2,a1,40
0:  ld a0,(a1)
    beqz a0,1f
    unimp
1:  addi a1,a1,8
    bne a1,a2,0b
     # done
    ld ra,0(sp)
    .cfi_restore 1
    ld s0,8(sp)
    .cfi_restore 8
    addi sp,sp,16
    ret
    .cfi_endproc

.globl _start
_start:
     # init src
    li a0,0
    lla a1,src
    lla a2,src+66000
0:  ori a3,a0,0x80
    sb a3,(a1)
    addi a1,a1,1
    addi a0,a0,1
    bne a1,a2,0b
     # run tests
    lla s0,sizes
    addi s1,s0,sizes_size
0:  lw a0,(s0)
    call test_size
    addi s0,s0,4
    bne s0,s1,0b
     # exit
    li a7,93
    li a0,0
    ecall
