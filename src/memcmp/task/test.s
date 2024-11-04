.globl _start
_start:
     # 0 eq
    li a0,0
    li a1,0
    li a2,0
    call my_memcmp
    beqz a0,0f
    unimp
0:   # small eq
    lla a0,a
    lla a1,a
    li a2,4
    call my_memcmp
    beqz a0,0f
    unimp
0:   # small lt
    lla a0,a
    lla a1,b
    li a2,4
    call my_memcmp
    bltz a0,0f
    unimp
0:   # small gt
    lla a0,b
    lla a1,a
    li a2,4
    call my_memcmp
    bgtz a0,0f
    unimp
0:   # medium eq
    lla a0,c
    lla a1,c
    li a2,73
    call my_memcmp
    beqz a0,0f
    unimp
0:   # medium lt
    lla a0,c
    lla a1,d
    li a2,73
    call my_memcmp
    bltz a0,0f
    unimp
0:   # medium gt
    lla a0,d
    lla a1,c
    li a2,73
    call my_memcmp
    bgtz a0,0f
    unimp
0:    # exit
    li a7,93
    li a0,0
    ecall

.section .rodata
a: .string "asdf"
b: .string "asfd"
c: .string "Lorem ipsum dolor sit amet.  The quick brown fox jumps over the lazy dog!"
d: .string "Lorem ipsum dolor sit amet.  The quick brown fox jumps over the lazy dog?"
