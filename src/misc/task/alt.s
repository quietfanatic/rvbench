.globl _start
_start:
    nop # Offset dual-issue pairing?
    call misc
    li a7,93
    li a0,0
    ecall
