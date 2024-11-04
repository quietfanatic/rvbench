 # Disassembled with gdb from glibc version 2.39.  This is probably a generic
 # implementation originally written in C.
 # Used under the GNU lGPL https://www.gnu.org/licences/

.p2align 4
.globl my_memcpy
my_memcpy:
	add	a3,a1,a2
	add	a4,a0,a2
	li	a5,96
	bltu	a5,a2,L464
	li	a5,32
	bltu	a5,a2,L176
	li	a5,16
	bgeu	a5,a2,L64
	ld	a6,0(a1)
	ld	a7,8(a1)
	ld	t0,-16(a3)
	ld	t1,-8(a3)
	sd	a6,0(a0)
	sd	a7,8(a0)
	sd	t0,-16(a4)
	sd	t1,-8(a4)
	ret
L64:	li	a5,8
	bgeu	a5,a2,L88
	ld	a6,0(a1)
	ld	a7,-8(a3)
	sd	a6,0(a0)
	sd	a7,-8(a4)
	ret
L88:	li	a5,4
	bgeu	a5,a2,L112
	lw	a6,0(a1)
	lw	t0,-4(a3)
	sw	a6,0(a0)
	sw	t0,-4(a4)
	ret
L112:	li	a5,2
	bgeu	a5,a2,L136
	lh	a6,0(a1)
	lh	t0,-2(a3)
	sh	a6,0(a0)
	sh	t0,-2(a4)
	ret
L136:	li	a5,1
	bgeu	a5,a2,L152
	lh	a6,0(a1)
	sh	a6,0(a0)
	ret
L152:	beqz	a2,L162
	lb	a6,0(a1)
	sb	a6,0(a0)
L162:	ret
	nop
	nop
	nop
L176:	ld	a6,0(a1)
	ld	a7,8(a1)
	ld	t0,16(a1)
	ld	t1,24(a1)
	ld	t2,-32(a3)
	ld	t3,-24(a3)
	ld	t4,-16(a3)
	ld	t5,-8(a3)
	li	a5,64
	bltu	a5,a2,L256
	sd	a6,0(a0)
	sd	a7,8(a0)
	sd	t0,16(a0)
	sd	t1,24(a0)
	sd	t2,-32(a4)
	sd	t3,-24(a4)
	sd	t4,-16(a4)
	sd	t5,-8(a4)
	ret
	nop
	nop
L256:	ld	a5,32(a1)
	ld	a2,40(a1)
	ld	t6,48(a1)
	ld	a3,56(a1)
	sd	a6,0(a0)
	sd	a7,8(a0)
	sd	t0,16(a0)
	sd	t1,24(a0)
	sd	a5,32(a0)
	sd	a2,40(a0)
	sd	t6,48(a0)
	sd	a3,56(a0)
	sd	t2,-32(a4)
	sd	t3,-24(a4)
	sd	t4,-16(a4)
	sd	t5,-8(a4)
	ret
	nop
	nop
	nop
L320:	ld	a6,0(a1)
	ld	a7,8(a1)
	ld	t0,16(a1)
	ld	t1,24(a1)
	ld	t2,-16(a3)
	ld	t3,-8(a3)
	ld	t4,-32(a3)
	ld	t5,-24(a3)
	ld	a5,-48(a3)
	ld	a2,-40(a3)
	ld	t6,-64(a3)
	ld	a3,-56(a3)
	sd	a6,0(a0)
	sd	a7,8(a0)
	ld	a6,32(a1)
	ld	a7,40(a1)
	sd	t0,16(a0)
	sd	t1,24(a0)
	ld	t0,48(a1)
	ld	t1,56(a1)
	sd	t2,-16(a4)
	sd	t3,-8(a4)
	sd	t4,-32(a4)
	sd	t5,-24(a4)
	sd	a5,-48(a4)
	sd	a2,-40(a4)
	sd	t6,-64(a4)
	sd	a3,-56(a4)
	sd	a6,32(a0)
	sd	a7,40(a0)
	sd	t0,48(a0)
	sd	t1,56(a0)
	ret
	nop
	nop
	nop
	nop
L464:	li	a5,128
	bge	a5,a2,L320
	ld	t4,0(a1)
	ld	t5,8(a1)
	andi	a5,a0,15
	andi	t6,a0,-16
	sub	a1,a1,a5
	ld	a6,16(a1)
	ld	a7,24(a1)
	sd	t4,0(a0)
	sd	t5,8(a0)
	ld	t0,32(a1)
	ld	t1,40(a1)
	ld	t2,48(a1)
	ld	t3,56(a1)
	ld	t4,64(a1)
	ld	t5,72(a1)
	addi	a1,a1,64
	addi	a5,a4,-144
	bgeu	t6,a5,L620
	nop
L544:	addi	a1,a1,64
	sd	a6,16(t6)
	sd	a7,24(t6)
	ld	a6,-48(a1)
	ld	a7,-40(a1)
	sd	t0,32(t6)
	sd	t1,40(t6)
	ld	t0,-32(a1)
	ld	t1,-24(a1)
	sd	t2,48(t6)
	sd	t3,56(t6)
	ld	t2,-16(a1)
	ld	t3,-8(a1)
	sd	t4,64(t6)
	sd	t5,72(t6)
	ld	t4,0(a1)
	ld	t5,8(a1)
	addi	t6,t6,64
	bltu	t6,a5,L544
L620:	ld	a5,-64(a3)
	ld	a2,-56(a3)
	sd	a6,16(t6)
	sd	a7,24(t6)
	ld	a6,-48(a3)
	ld	a7,-40(a3)
	sd	t0,32(t6)
	sd	t1,40(t6)
	ld	t0,-32(a3)
	ld	t1,-24(a3)
	sd	t2,48(t6)
	sd	t3,56(t6)
	ld	t2,-16(a3)
	ld	t3,-8(a3)
	sd	t4,64(t6)
	sd	t5,72(t6)
	sd	a5,-64(a4)
	sd	a2,-56(a4)
	sd	a6,-48(a4)
	sd	a7,-40(a4)
	sd	t0,-32(a4)
	sd	t1,-24(a4)
	sd	t2,-16(a4)
	sd	t3,-8(a4)
	ret
