.bss

.align 4
dst: .zero 3
.align 4
src: .zero 3

.text

.align 3
.globl _start
_start:
    li s0,10000000
    lla s1,dst
    lla s2,src
    .p2align 3
0:  mv a0,s1
    mv a1,s2
    li a2,3
    call my_memcpy
    addi s0,s0,-1
    bnez s0,0b
    li a7,93 #exit
    li a0,0
    ecall
