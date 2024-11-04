.globl _start
_start:
    call misc
    li a7,93
    li a0,0
    ecall
