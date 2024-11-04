.globl _start
_start:
    li s4,100000
2:  lla s0,dictionary
    addi s2,s0,80
0:  lla s1,dictionary
    addi s3,s1,80
1:  ld a0,(s0)
    li a2,5
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
str0: .string "basdf"
str1: .string "basff"
str2: .string "basdp"
str3: .string "basd3"
str4: .string "bqsdf"
str5: .string "basdr"
str6: .string "bawdf"
str7: .string "6asjf"
str8: .string "basdg"
str9: .string "basdm"
