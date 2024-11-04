.globl _start
_start:
    li s4,100000
2:  lla s0,dictionary
    addi s2,s0,80
0:  lla s1,dictionary
    addi s3,s1,80
1:  ld a0,(s0)
    li a2,37
    ld a1,(s1)
    call my_memcmp # but ignore the result
    addi s1,s1,8
    bne s1,s3,1b
    addi s0,s0,8
    bne s0,s2,0b
    addi s4,s4,-1
    bnez s4,2b
     # exit
    li a7,93
    li a0,0
    ecall

.section .rodata
dictionary: .dword str0, str1, str2, str3, str4, str5, str6, str7, str8, str9
str0: .string "Lorem ipsum dolor sit amet.  The quick brown fox jumps over the lazy dog!"
str1: .string "Lorem ipsum dolor sit amet.  The quick brown fox jumps over the lazy dog?"
str2: .string "Lorem ipsum dolor sit amet.  The quick brown fox jumps over the lazy dog."
str3: .string "Lorem ipsum dolor sit amet.  The quick brown fox jumps over the lazy dog/"
str4: .string "Lorem ipsum dolor sit amet.  The quick brown fox jumps over the lazy dog^"
str5: .string "Lorem ipsum dolor sit amet.  The quick brown fox jumps over the lazy dog#"
str6: .string "Lorem ipsum dolor sit amet.  The quick brown fox jumps over the lazy dog$"
str7: .string "Lorem ipsum dolor sit amet.  The quick brown fox jumps over the lazy dog%"
str8: .string "Lorem ipsum dolor sit amet.  The quick brown fox jumps over the lazy dog@"
str9: .string "Lorem ipsum dolor sit amet.  The quick brown fox jumps over the lazy dog="
