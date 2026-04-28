	.build_version macos, 26, 0
	.section	__TEXT,__text,regular,pure_instructions
	.globl	__QMsortingPpositionless
	.p2align	2
__QMsortingPpositionless:
	ldr	x11, [x2, #32]
	cmp	x11, #1
	b.lt	LBB0_3
	stp	x26, x25, [sp, #-64]!
	stp	x24, x23, [sp, #16]
	stp	x22, x21, [sp, #32]
	stp	x20, x19, [sp, #48]
	ldr	x8, [x2, #40]
	ldr	x9, [x2]
	bic	x10, x11, x11, asr #63
	ldr	x13, [x0, #40]
	ldr	x14, [x0]
	cmp	x11, #4
	b.ge	LBB0_4
	mov	w16, #1
	mov	w12, #1
	b	LBB0_9
LBB0_3:
	mov	w13, #1
	mov	w8, #1
	cmp	w13, #0
	ccmp	w8, #0, #4, ne
	ccmp	w13, w8, #2, ne
	cset	w0, lo
	ret
LBB0_4:
	cmp	x8, #1
	ccmp	x13, #1, #0, eq
	b.eq	LBB0_6
	mov	w12, #1
	mov	x16, x12
	b	LBB0_9
LBB0_6:
	and	x15, x10, #0x7ffffffffffffffc
	orr	x12, x15, #0x1
	add	x16, x9, #1
	add	x0, x14, #1
	mov	w17, #1
	and	x3, x10, #0x7ffffffffffffffc
	mov	w4, #1
	mov	w5, #1
	mov	w6, #1
LBB0_7:
	ldur	w7, [x16, #-1]
	ldr	w19, [x16]
	ldur	w20, [x16, #1]
	ldur	w21, [x16, #2]
	ldur	w22, [x0, #-1]
	ldr	w23, [x0]
	ldur	w24, [x0, #1]
	ldur	w25, [x0, #2]
	cmp	w7, w22
	cset	w7, eq
	cmp	w19, w23
	cset	w19, eq
	cmp	w20, w24
	cset	w20, eq
	cmp	w21, w25
	cset	w21, eq
	and	w17, w17, w7
	and	w4, w4, w19
	and	w5, w5, w20
	and	w6, w6, w21
	add	x16, x16, #4
	add	x0, x0, #4
	subs	x3, x3, #4
	b.ne	LBB0_7
	and	w16, w4, w17
	and	w17, w6, w5
	and	w16, w17, w16
	cmp	x11, x15
	b.eq	LBB0_11
LBB0_9:
	sub	x15, x10, x12
	add	x15, x15, #1
	sub	x17, x12, #1
	madd	x12, x13, x17, x14
	madd	x17, x8, x17, x9
LBB0_10:
	ldr	w0, [x17]
	ldr	w3, [x12]
	cmp	w0, w3
	cset	w0, eq
	and	w16, w16, w0
	add	x12, x12, x13
	add	x17, x17, x8
	subs	x15, x15, #1
	b.ne	LBB0_10
LBB0_11:
	ldr	x12, [x2, #64]
	cbz	w16, LBB0_13
	mov	w13, #1
	ldr	x14, [x1, #40]
	ldr	x15, [x1]
	cmp	x11, #4
	b.ge	LBB0_41
	b	LBB0_56
LBB0_13:
	cmp	x11, #4
	b.ge	LBB0_19
	mov	w17, #1
	mov	w15, #1
LBB0_15:
	sub	x16, x10, x15
	add	x16, x16, #1
	sub	x0, x15, #1
	madd	x15, x8, x0, x12
	add	x15, x9, x15
	madd	x0, x13, x0, x14
LBB0_16:
	ldr	w2, [x15]
	ldr	w3, [x0]
	cmp	w2, w3
	cset	w2, eq
	and	w17, w17, w2
	add	x15, x15, x8
	add	x0, x0, x13
	subs	x16, x16, #1
	b.ne	LBB0_16
LBB0_17:
	tbz	w17, #0, LBB0_24
	mov	w13, #2
	ldr	x14, [x1, #40]
	ldr	x15, [x1]
	cmp	x11, #4
	b.ge	LBB0_41
	b	LBB0_56
LBB0_19:
	mov	w15, #1
	mov	w17, #1
	cmp	x8, #1
	b.ne	LBB0_15
	cmp	x13, #1
	b.ne	LBB0_15
	and	x16, x10, #0x7ffffffffffffffc
	orr	x15, x16, #0x1
	add	x17, x12, x9
	add	x17, x17, #1
	add	x2, x14, #1
	mov	w0, #1
	and	x3, x10, #0x7ffffffffffffffc
	mov	w4, #1
	mov	w5, #1
	mov	w6, #1
LBB0_22:
	ldur	w7, [x17, #-1]
	ldr	w19, [x17]
	ldur	w20, [x17, #1]
	ldur	w21, [x17, #2]
	ldur	w22, [x2, #-1]
	ldr	w23, [x2]
	ldur	w24, [x2, #1]
	ldur	w25, [x2, #2]
	cmp	w7, w22
	cset	w7, eq
	cmp	w19, w23
	cset	w19, eq
	cmp	w20, w24
	cset	w20, eq
	cmp	w21, w25
	cset	w21, eq
	and	w0, w0, w7
	and	w4, w4, w19
	and	w5, w5, w20
	and	w6, w6, w21
	add	x17, x17, #4
	add	x2, x2, #4
	subs	x3, x3, #4
	b.ne	LBB0_22
	and	w17, w4, w0
	and	w0, w6, w5
	and	w17, w0, w17
	cmp	x11, x16
	b.ne	LBB0_15
	b	LBB0_17
LBB0_24:
	lsl	x15, x12, #1
	cmp	x11, #4
	b.ge	LBB0_30
	mov	w0, #1
	mov	w16, #1
LBB0_26:
	sub	x17, x10, x16
	add	x17, x17, #1
	sub	x16, x16, #1
	madd	x15, x8, x16, x15
	add	x15, x9, x15
	madd	x16, x13, x16, x14
LBB0_27:
	ldr	w2, [x15]
	ldr	w3, [x16]
	cmp	w2, w3
	cset	w2, eq
	and	w0, w0, w2
	add	x15, x15, x8
	add	x16, x16, x13
	subs	x17, x17, #1
	b.ne	LBB0_27
LBB0_28:
	tbz	w0, #0, LBB0_35
	mov	w13, #3
	ldr	x14, [x1, #40]
	ldr	x15, [x1]
	cmp	x11, #4
	b.ge	LBB0_41
	b	LBB0_56
LBB0_30:
	mov	w16, #1
	mov	w0, #1
	cmp	x8, #1
	b.ne	LBB0_26
	cmp	x13, #1
	b.ne	LBB0_26
	and	x17, x10, #0x7ffffffffffffffc
	orr	x16, x17, #0x1
	add	x0, x15, x9
	add	x0, x0, #1
	add	x3, x14, #1
	mov	w2, #1
	and	x4, x10, #0x7ffffffffffffffc
	mov	w5, #1
	mov	w6, #1
	mov	w7, #1
LBB0_33:
	ldur	w19, [x0, #-1]
	ldr	w20, [x0]
	ldur	w21, [x0, #1]
	ldur	w22, [x0, #2]
	ldur	w23, [x3, #-1]
	ldr	w24, [x3]
	ldur	w25, [x3, #1]
	ldur	w26, [x3, #2]
	cmp	w19, w23
	cset	w19, eq
	cmp	w20, w24
	cset	w20, eq
	cmp	w21, w25
	cset	w21, eq
	cmp	w22, w26
	cset	w22, eq
	and	w2, w2, w19
	and	w5, w5, w20
	and	w6, w6, w21
	and	w7, w7, w22
	add	x0, x0, #4
	add	x3, x3, #4
	subs	x4, x4, #4
	b.ne	LBB0_33
	and	w0, w5, w2
	and	w2, w7, w6
	and	w0, w2, w0
	cmp	x11, x17
	b.ne	LBB0_26
	b	LBB0_28
LBB0_35:
	add	x15, x12, x12, lsl #1
	cmp	x11, #4
	b.ge	LBB0_46
	mov	w0, #1
	mov	w16, #1
LBB0_37:
	sub	x17, x10, x16
	add	x17, x17, #1
	sub	x16, x16, #1
	madd	x15, x8, x16, x15
	add	x15, x9, x15
	madd	x16, x13, x16, x14
LBB0_38:
	ldr	w2, [x15]
	ldr	w3, [x16]
	cmp	w2, w3
	cset	w2, eq
	and	w0, w0, w2
	add	x15, x15, x8
	add	x16, x16, x13
	subs	x17, x17, #1
	b.ne	LBB0_38
LBB0_39:
	tbz	w0, #0, LBB0_51
	mov	w13, #4
	ldr	x14, [x1, #40]
	ldr	x15, [x1]
	cmp	x11, #4
	b.lt	LBB0_56
LBB0_41:
	mov	w16, #1
	mov	w17, #1
	cmp	x8, #1
	b.ne	LBB0_57
	cmp	x14, #1
	b.ne	LBB0_57
	and	x0, x10, #0x7ffffffffffffffc
	orr	x16, x0, #0x1
	add	x17, x9, #1
	add	x2, x15, #1
	mov	w1, #1
	and	x3, x10, #0x7ffffffffffffffc
	mov	w4, #1
	mov	w5, #1
	mov	w6, #1
LBB0_44:
	ldur	w7, [x17, #-1]
	ldr	w19, [x17]
	ldur	w20, [x17, #1]
	ldur	w21, [x17, #2]
	ldur	w22, [x2, #-1]
	ldr	w23, [x2]
	ldur	w24, [x2, #1]
	ldur	w25, [x2, #2]
	cmp	w7, w22
	cset	w7, eq
	cmp	w19, w23
	cset	w19, eq
	cmp	w20, w24
	cset	w20, eq
	cmp	w21, w25
	cset	w21, eq
	and	w1, w1, w7
	and	w4, w4, w19
	and	w5, w5, w20
	and	w6, w6, w21
	add	x17, x17, #4
	add	x2, x2, #4
	subs	x3, x3, #4
	b.ne	LBB0_44
	and	w17, w4, w1
	and	w1, w6, w5
	and	w17, w1, w17
	cmp	x11, x0
	b.ne	LBB0_57
	b	LBB0_59
LBB0_46:
	mov	w16, #1
	mov	w0, #1
	cmp	x8, #1
	b.ne	LBB0_37
	cmp	x13, #1
	b.ne	LBB0_37
	and	x17, x10, #0x7ffffffffffffffc
	orr	x16, x17, #0x1
	add	x0, x15, x9
	add	x0, x0, #1
	add	x3, x14, #1
	mov	w2, #1
	and	x4, x10, #0x7ffffffffffffffc
	mov	w5, #1
	mov	w6, #1
	mov	w7, #1
LBB0_49:
	ldur	w19, [x0, #-1]
	ldr	w20, [x0]
	ldur	w21, [x0, #1]
	ldur	w22, [x0, #2]
	ldur	w23, [x3, #-1]
	ldr	w24, [x3]
	ldur	w25, [x3, #1]
	ldur	w26, [x3, #2]
	cmp	w19, w23
	cset	w19, eq
	cmp	w20, w24
	cset	w20, eq
	cmp	w21, w25
	cset	w21, eq
	cmp	w22, w26
	cset	w22, eq
	and	w2, w2, w19
	and	w5, w5, w20
	and	w6, w6, w21
	and	w7, w7, w22
	add	x0, x0, #4
	add	x3, x3, #4
	subs	x4, x4, #4
	b.ne	LBB0_49
	and	w0, w5, w2
	and	w2, w7, w6
	and	w0, w2, w0
	cmp	x11, x17
	b.ne	LBB0_37
	b	LBB0_39
LBB0_51:
	lsl	x15, x12, #2
	cmp	x11, #4
	b.ge	LBB0_100
	mov	w17, #1
	mov	w16, #1
LBB0_53:
	sub	x0, x10, x16
	add	x0, x0, #1
	sub	x16, x16, #1
	madd	x15, x8, x16, x15
	add	x15, x9, x15
	madd	x14, x13, x16, x14
LBB0_54:
	ldr	w16, [x15]
	ldr	w2, [x14]
	cmp	w16, w2
	cset	w16, eq
	and	w17, w17, w16
	add	x15, x15, x8
	add	x14, x14, x13
	subs	x0, x0, #1
	b.ne	LBB0_54
LBB0_55:
	mov	w13, #5
	cmp	w17, #0
	csel	w13, w13, wzr, ne
	ldr	x14, [x1, #40]
	ldr	x15, [x1]
	cmp	x11, #4
	b.ge	LBB0_41
LBB0_56:
	mov	w17, #1
	mov	w16, #1
LBB0_57:
	sub	x0, x10, x16
	add	x0, x0, #1
	sub	x1, x16, #1
	madd	x16, x14, x1, x15
	madd	x1, x8, x1, x9
LBB0_58:
	ldr	w2, [x1]
	ldr	w3, [x16]
	cmp	w2, w3
	cset	w2, eq
	and	w17, w17, w2
	add	x16, x16, x14
	add	x1, x1, x8
	subs	x0, x0, #1
	b.ne	LBB0_58
LBB0_59:
	cbz	w17, LBB0_61
	mov	w8, #1
	b	LBB0_99
LBB0_61:
	cmp	x11, #4
	b.ge	LBB0_67
	mov	w0, #1
	mov	w16, #1
LBB0_63:
	sub	x17, x10, x16
	add	x17, x17, #1
	sub	x1, x16, #1
	madd	x16, x8, x1, x12
	add	x16, x9, x16
	madd	x1, x14, x1, x15
LBB0_64:
	ldr	w2, [x16]
	ldr	w3, [x1]
	cmp	w2, w3
	cset	w2, eq
	and	w0, w0, w2
	add	x16, x16, x8
	add	x1, x1, x14
	subs	x17, x17, #1
	b.ne	LBB0_64
LBB0_65:
	tbz	w0, #0, LBB0_72
	mov	w8, #2
	b	LBB0_99
LBB0_67:
	mov	w16, #1
	mov	w0, #1
	cmp	x8, #1
	b.ne	LBB0_63
	cmp	x14, #1
	b.ne	LBB0_63
	and	x17, x10, #0x7ffffffffffffffc
	orr	x16, x17, #0x1
	add	x0, x12, x9
	add	x0, x0, #1
	add	x2, x15, #1
	mov	w1, #1
	and	x3, x10, #0x7ffffffffffffffc
	mov	w4, #1
	mov	w5, #1
	mov	w6, #1
LBB0_70:
	ldur	w7, [x0, #-1]
	ldr	w19, [x0]
	ldur	w20, [x0, #1]
	ldur	w21, [x0, #2]
	ldur	w22, [x2, #-1]
	ldr	w23, [x2]
	ldur	w24, [x2, #1]
	ldur	w25, [x2, #2]
	cmp	w7, w22
	cset	w7, eq
	cmp	w19, w23
	cset	w19, eq
	cmp	w20, w24
	cset	w20, eq
	cmp	w21, w25
	cset	w21, eq
	and	w1, w1, w7
	and	w4, w4, w19
	and	w5, w5, w20
	and	w6, w6, w21
	add	x0, x0, #4
	add	x2, x2, #4
	subs	x3, x3, #4
	b.ne	LBB0_70
	and	w0, w4, w1
	and	w1, w6, w5
	and	w0, w1, w0
	cmp	x11, x17
	b.ne	LBB0_63
	b	LBB0_65
LBB0_72:
	lsl	x16, x12, #1
	cmp	x11, #4
	b.ge	LBB0_78
	mov	w1, #1
	mov	w17, #1
LBB0_74:
	sub	x0, x10, x17
	add	x0, x0, #1
	sub	x17, x17, #1
	madd	x16, x8, x17, x16
	add	x16, x9, x16
	madd	x17, x14, x17, x15
LBB0_75:
	ldr	w2, [x16]
	ldr	w3, [x17]
	cmp	w2, w3
	cset	w2, eq
	and	w1, w1, w2
	add	x16, x16, x8
	add	x17, x17, x14
	subs	x0, x0, #1
	b.ne	LBB0_75
LBB0_76:
	tbz	w1, #0, LBB0_83
	mov	w8, #3
	b	LBB0_99
LBB0_78:
	mov	w17, #1
	mov	w1, #1
	cmp	x8, #1
	b.ne	LBB0_74
	cmp	x14, #1
	b.ne	LBB0_74
	and	x0, x10, #0x7ffffffffffffffc
	orr	x17, x0, #0x1
	add	x1, x16, x9
	add	x1, x1, #1
	add	x3, x15, #1
	mov	w2, #1
	and	x4, x10, #0x7ffffffffffffffc
	mov	w5, #1
	mov	w6, #1
	mov	w7, #1
LBB0_81:
	ldur	w19, [x1, #-1]
	ldr	w20, [x1]
	ldur	w21, [x1, #1]
	ldur	w22, [x1, #2]
	ldur	w23, [x3, #-1]
	ldr	w24, [x3]
	ldur	w25, [x3, #1]
	ldur	w26, [x3, #2]
	cmp	w19, w23
	cset	w19, eq
	cmp	w20, w24
	cset	w20, eq
	cmp	w21, w25
	cset	w21, eq
	cmp	w22, w26
	cset	w22, eq
	and	w2, w2, w19
	and	w5, w5, w20
	and	w6, w6, w21
	and	w7, w7, w22
	add	x1, x1, #4
	add	x3, x3, #4
	subs	x4, x4, #4
	b.ne	LBB0_81
	and	w1, w5, w2
	and	w2, w7, w6
	and	w1, w2, w1
	cmp	x11, x0
	b.ne	LBB0_74
	b	LBB0_76
LBB0_83:
	add	x16, x12, x12, lsl #1
	cmp	x11, #4
	b.ge	LBB0_89
	mov	w1, #1
	mov	w17, #1
LBB0_85:
	sub	x0, x10, x17
	add	x0, x0, #1
	sub	x17, x17, #1
	madd	x16, x8, x17, x16
	add	x16, x9, x16
	madd	x17, x14, x17, x15
LBB0_86:
	ldr	w2, [x16]
	ldr	w3, [x17]
	cmp	w2, w3
	cset	w2, eq
	and	w1, w1, w2
	add	x16, x16, x8
	add	x17, x17, x14
	subs	x0, x0, #1
	b.ne	LBB0_86
LBB0_87:
	tbz	w1, #0, LBB0_94
	mov	w8, #4
	b	LBB0_99
LBB0_89:
	mov	w17, #1
	mov	w1, #1
	cmp	x8, #1
	b.ne	LBB0_85
	cmp	x14, #1
	b.ne	LBB0_85
	and	x0, x10, #0x7ffffffffffffffc
	orr	x17, x0, #0x1
	add	x1, x16, x9
	add	x1, x1, #1
	add	x3, x15, #1
	mov	w2, #1
	and	x4, x10, #0x7ffffffffffffffc
	mov	w5, #1
	mov	w6, #1
	mov	w7, #1
LBB0_92:
	ldur	w19, [x1, #-1]
	ldr	w20, [x1]
	ldur	w21, [x1, #1]
	ldur	w22, [x1, #2]
	ldur	w23, [x3, #-1]
	ldr	w24, [x3]
	ldur	w25, [x3, #1]
	ldur	w26, [x3, #2]
	cmp	w19, w23
	cset	w19, eq
	cmp	w20, w24
	cset	w20, eq
	cmp	w21, w25
	cset	w21, eq
	cmp	w22, w26
	cset	w22, eq
	and	w2, w2, w19
	and	w5, w5, w20
	and	w6, w6, w21
	and	w7, w7, w22
	add	x1, x1, #4
	add	x3, x3, #4
	subs	x4, x4, #4
	b.ne	LBB0_92
	and	w1, w5, w2
	and	w2, w7, w6
	and	w1, w2, w1
	cmp	x11, x0
	b.ne	LBB0_85
	b	LBB0_87
LBB0_94:
	lsl	x12, x12, #2
	cmp	x11, #4
	b.ge	LBB0_105
	mov	w17, #1
	mov	w16, #1
LBB0_96:
	sub	x10, x10, x16
	add	x10, x10, #1
	sub	x11, x16, #1
	madd	x12, x8, x11, x12
	add	x9, x9, x12
	madd	x11, x14, x11, x15
LBB0_97:
	ldr	w12, [x9]
	ldr	w15, [x11]
	cmp	w12, w15
	cset	w12, eq
	and	w17, w17, w12
	add	x9, x9, x8
	add	x11, x11, x14
	subs	x10, x10, #1
	b.ne	LBB0_97
LBB0_98:
	mov	w8, #5
	cmp	w17, #0
	csel	w8, w8, wzr, ne
LBB0_99:
	ldp	x20, x19, [sp, #48]
	ldp	x22, x21, [sp, #32]
	ldp	x24, x23, [sp, #16]
	ldp	x26, x25, [sp], #64
	cmp	w13, #0
	ccmp	w8, #0, #4, ne
	ccmp	w13, w8, #2, ne
	cset	w0, lo
	ret
LBB0_100:
	mov	w16, #1
	mov	w17, #1
	cmp	x8, #1
	b.ne	LBB0_53
	cmp	x13, #1
	b.ne	LBB0_53
	and	x0, x10, #0x7ffffffffffffffc
	orr	x16, x0, #0x1
	add	x17, x15, x9
	add	x17, x17, #1
	add	x3, x14, #1
	mov	w2, #1
	and	x4, x10, #0x7ffffffffffffffc
	mov	w5, #1
	mov	w6, #1
	mov	w7, #1
LBB0_103:
	ldur	w19, [x17, #-1]
	ldr	w20, [x17]
	ldur	w21, [x17, #1]
	ldur	w22, [x17, #2]
	ldur	w23, [x3, #-1]
	ldr	w24, [x3]
	ldur	w25, [x3, #1]
	ldur	w26, [x3, #2]
	cmp	w19, w23
	cset	w19, eq
	cmp	w20, w24
	cset	w20, eq
	cmp	w21, w25
	cset	w21, eq
	cmp	w22, w26
	cset	w22, eq
	and	w2, w2, w19
	and	w5, w5, w20
	and	w6, w6, w21
	and	w7, w7, w22
	add	x17, x17, #4
	add	x3, x3, #4
	subs	x4, x4, #4
	b.ne	LBB0_103
	and	w17, w5, w2
	and	w2, w7, w6
	and	w17, w2, w17
	cmp	x11, x0
	b.ne	LBB0_53
	b	LBB0_55
LBB0_105:
	mov	w16, #1
	mov	w17, #1
	cmp	x8, #1
	b.ne	LBB0_96
	cmp	x14, #1
	b.ne	LBB0_96
	and	x0, x10, #0x7ffffffffffffffc
	orr	x16, x0, #0x1
	add	x17, x12, x9
	add	x17, x17, #1
	add	x2, x15, #1
	mov	w1, #1
	and	x3, x10, #0x7ffffffffffffffc
	mov	w4, #1
	mov	w5, #1
	mov	w6, #1
LBB0_108:
	ldur	w7, [x17, #-1]
	ldr	w19, [x17]
	ldur	w20, [x17, #1]
	ldur	w21, [x17, #2]
	ldur	w22, [x2, #-1]
	ldr	w23, [x2]
	ldur	w24, [x2, #1]
	ldur	w25, [x2, #2]
	cmp	w7, w22
	cset	w7, eq
	cmp	w19, w23
	cset	w19, eq
	cmp	w20, w24
	cset	w20, eq
	cmp	w21, w25
	cset	w21, eq
	and	w1, w1, w7
	and	w4, w4, w19
	and	w5, w5, w20
	and	w6, w6, w21
	add	x17, x17, #4
	add	x2, x2, #4
	subs	x3, x3, #4
	b.ne	LBB0_108
	and	w17, w4, w1
	and	w1, w6, w5
	and	w17, w1, w17
	cmp	x11, x0
	b.ne	LBB0_96
	b	LBB0_98

	.globl	__QMsortingPsortempl
	.p2align	2
__QMsortingPsortempl:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	add	x29, sp, #80
	sub	sp, sp, #432
	mov	x19, x1
	mov	x20, x0
	ldrb	w8, [x1, #23]
	ldr	x9, [x1]
	add	x24, sp, #96
	and	w8, w8, #0xfe
	mov	w10, #4
	stp	x9, x10, [sp, #24]
	mov	w9, #55631
	movk	w9, #308, lsl #16
	str	w9, [sp, #40]
	mov	w11, #11266
	strh	w11, [sp, #44]
	strb	wzr, [sp, #46]
	strb	w8, [sp, #47]
	mov	w13, #1
	str	x13, [sp, #48]
	ldr	q0, [x1, #32]
	stur	q0, [sp, #56]
	str	x13, [sp, #72]
	ldur	q0, [x1, #56]
	stur	q0, [sp, #80]
	ldrb	w8, [x2, #23]
	and	w8, w8, #0xfe
	ldr	x12, [x2]
	stp	x12, x10, [sp, #96]
	str	w9, [sp, #112]
	strh	w11, [sp, #116]
	strb	wzr, [sp, #118]
	strb	w8, [sp, #119]
	str	x13, [sp, #120]
	ldr	q0, [x2, #32]
	str	q0, [sp, #128]
	str	x13, [sp, #144]
	ldur	q0, [x2, #56]
	stur	q0, [x24, #56]
	ldr	x8, [x0, #56]
	str	w8, [sp, #20]
Lloh0:
	adrp	x21, l___unnamed_1@PAGE
Lloh1:
	add	x21, x21, l___unnamed_1@PAGEOFF
	mov	x0, x21
	bl	___kmpc_global_thread_num
Lloh2:
	adrp	x2, __QMsortingPsortempl..omp_par@PAGE
Lloh3:
	add	x2, x2, __QMsortingPsortempl..omp_par@PAGEOFF
	mov	x0, x21
	mov	w1, #0
	bl	___kmpc_fork_call
	add	x26, sp, #236
	add	x27, sp, #176
	add	x28, sp, #20
	add	x25, sp, #172
	add	x22, sp, #24
Lloh4:
	adrp	x23, __QMsortingPsortempl..omp_par.3@PAGE
Lloh5:
	add	x23, x23, __QMsortingPsortempl..omp_par.3@PAGEOFF
LBB1_1:
	mov	w8, #1
	str	w8, [sp, #172]
	stp	x26, x27, [x24, #200]
	stp	x28, x25, [x24, #216]
	stp	x22, x24, [x24, #232]
	stp	x19, x20, [x24, #248]
	sub	x8, x29, #216
	str	x8, [sp]
	mov	x0, x21
	mov	w1, #1
Lloh6:
	adrp	x2, __QMsortingPsortempl..omp_par.2@PAGE
Lloh7:
	add	x2, x2, __QMsortingPsortempl..omp_par.2@PAGEOFF
	bl	___kmpc_fork_call
	stp	x26, x27, [x24, #264]
	stp	x28, x25, [x24, #280]
	stp	x22, x24, [x24, #296]
	stp	x19, x20, [x24, #312]
	sub	x8, x29, #152
	str	x8, [sp]
	mov	x0, x21
	mov	w1, #1
	mov	x2, x23
	bl	___kmpc_fork_call
	ldr	w8, [sp, #172]
	cbz	w8, LBB1_1
	add	sp, sp, #432
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
	.loh AdrpAdd	Lloh4, Lloh5
	.loh AdrpAdd	Lloh2, Lloh3
	.loh AdrpAdd	Lloh0, Lloh1
	.loh AdrpAdd	Lloh6, Lloh7

	.p2align	2
__QMsortingPsortempl..omp_par.3:
	sub	sp, sp, #272
	stp	x28, x27, [sp, #176]
	stp	x26, x25, [sp, #192]
	stp	x24, x23, [sp, #208]
	stp	x22, x21, [sp, #224]
	stp	x20, x19, [sp, #240]
	stp	x29, x30, [sp, #256]
	add	x29, sp, #256
	ldp	x8, x9, [x2, #16]
	str	x9, [sp, #16]
	ldp	x19, x9, [x2, #32]
	str	x9, [sp, #32]
	ldp	x23, x24, [x2, #48]
	ldr	w8, [x8]
	sub	w9, w8, #1
	mov	w10, #1
	stp	w10, w10, [x29, #-108]
	sub	w8, w8, #3
	lsr	w8, w8, #1
	cmp	w9, #2
	csinv	w8, w8, wzr, ge
	stp	w8, wzr, [x29, #-100]
Lloh8:
	adrp	x21, l___unnamed_1@PAGE
Lloh9:
	add	x21, x21, l___unnamed_1@PAGEOFF
	mov	x0, x21
	bl	___kmpc_global_thread_num
	mov	x1, x0
	str	wzr, [sp]
	sub	x3, x29, #92
	sub	x4, x29, #96
	sub	x5, x29, #100
	sub	x6, x29, #104
	mov	x0, x21
	str	w1, [sp, #28]
	mov	w2, #34
	mov	w7, #1
	bl	___kmpc_for_static_init_4u
	ldp	w9, w8, [x29, #-100]
	sub	w9, w9, w8
	cmn	w9, #1
	b.eq	LBB2_5
	ldrb	w10, [x19, #23]
	and	w25, w10, #0xfffffffe
	ldp	x10, x26, [x19, #32]
	ldr	x27, [x19, #64]
	bic	x28, x10, x10, asr #63
	add	w22, w9, #1
	lsl	w8, w8, #1
	add	w8, w8, #2
	ldr	x20, [x19]
	b	LBB2_3
LBB2_2:
	add	w8, w21, #2
	subs	w22, w22, #1
	b.eq	LBB2_5
LBB2_3:
	sxtw	x21, w8
	madd	x8, x27, x21, x20
	mov	w10, #4
	stp	x8, x10, [sp, #40]
	mov	w9, #55631
	movk	w9, #308, lsl #16
	str	w9, [sp, #56]
	mov	w11, #11265
	strh	w11, [sp, #60]
	strb	wzr, [sp, #62]
	strb	w25, [sp, #63]
	mov	w12, #1
	stp	x12, x28, [sp, #64]
	sub	x19, x21, #1
	madd	x8, x27, x19, x20
	stp	x26, x8, [sp, #80]
	str	x10, [sp, #96]
	str	w9, [sp, #104]
	strh	w11, [sp, #108]
	strb	wzr, [sp, #110]
	strb	w25, [sp, #111]
	stp	x12, x28, [sp, #112]
	str	x26, [sp, #128]
	add	x0, sp, #40
	add	x1, sp, #88
	ldr	x2, [sp, #32]
	bl	__QMsortingPpositionless
	cbz	w0, LBB2_2
	ldr	x10, [x24, #40]
	ldr	x9, [x24, #64]
	ldr	x11, [x24]
	madd	x8, x9, x19, x11
	madd	x9, x9, x21, x11
	ldr	w11, [x8]
	ldr	w12, [x9]
	str	w12, [x8]
	str	w11, [x9]
	ldr	w11, [x8, x10]
	ldr	w12, [x9, x10]
	str	w12, [x8, x10]
	str	w11, [x9, x10]
	lsl	x11, x10, #1
	ldr	w12, [x8, x11]
	ldr	w13, [x9, x11]
	str	w13, [x8, x11]
	str	w12, [x9, x11]
	add	x12, x11, x10
	ldr	w13, [x8, x12]
	ldr	w14, [x9, x12]
	str	w14, [x8, x12]
	str	w13, [x9, x12]
	lsl	x13, x10, #2
	ldr	w14, [x8, x13]
	ldr	w15, [x9, x13]
	str	w15, [x8, x13]
	str	w14, [x9, x13]
	add	x13, x13, x10
	ldr	w14, [x8, x13]
	ldr	w15, [x9, x13]
	str	w15, [x8, x13]
	str	w14, [x9, x13]
	lsl	x14, x12, #1
	ldr	w15, [x8, x14]
	ldr	w16, [x9, x14]
	str	w16, [x8, x14]
	str	w15, [x9, x14]
	lsl	x14, x10, #3
	sub	x15, x14, x10
	ldr	w16, [x8, x15]
	ldr	w17, [x9, x15]
	str	w17, [x8, x15]
	str	w16, [x9, x15]
	ldr	w15, [x8, x14]
	ldr	w16, [x9, x14]
	str	w16, [x8, x14]
	str	w15, [x9, x14]
	add	x14, x14, x10
	ldr	w15, [x8, x14]
	ldr	w16, [x9, x14]
	str	w16, [x8, x14]
	str	w15, [x9, x14]
	lsl	x13, x13, #1
	ldr	w14, [x8, x13]
	ldr	w15, [x9, x13]
	str	w15, [x8, x13]
	str	w14, [x9, x13]
	mov	w0, #11
	mul	x13, x10, x0
	ldr	w14, [x8, x13]
	ldr	w15, [x9, x13]
	str	w15, [x8, x13]
	str	w14, [x9, x13]
	ldr	w13, [x8, x12, lsl #2]
	ldr	w14, [x9, x12, lsl #2]
	str	w14, [x8, x12, lsl #2]
	str	w13, [x9, x12, lsl #2]
	mov	w1, #13
	mul	x12, x10, x1
	ldr	w13, [x8, x12]
	ldr	w14, [x9, x12]
	str	w14, [x8, x12]
	str	w13, [x9, x12]
	lsl	x10, x10, #4
	sub	x10, x10, x11
	ldr	w11, [x8, x10]
	ldr	w12, [x9, x10]
	str	w12, [x8, x10]
	str	w11, [x9, x10]
	ldr	x10, [x23, #40]
	ldr	x9, [x23, #64]
	ldr	x11, [x23]
	madd	x8, x9, x19, x11
	madd	x9, x9, x21, x11
	ldr	w11, [x8]
	ldr	w12, [x9]
	str	w12, [x8]
	str	w11, [x9]
	ldr	w11, [x8, x10]
	ldr	w12, [x9, x10]
	str	w12, [x8, x10]
	str	w11, [x9, x10]
	lsl	x11, x10, #1
	ldr	w12, [x8, x11]
	ldr	w13, [x9, x11]
	str	w13, [x8, x11]
	str	w12, [x9, x11]
	add	x12, x11, x10
	ldr	w13, [x8, x12]
	ldr	w14, [x9, x12]
	str	w14, [x8, x12]
	str	w13, [x9, x12]
	lsl	x13, x10, #2
	ldr	w14, [x8, x13]
	ldr	w15, [x9, x13]
	str	w15, [x8, x13]
	str	w14, [x9, x13]
	add	x13, x13, x10
	ldr	w14, [x8, x13]
	ldr	w15, [x9, x13]
	str	w15, [x8, x13]
	str	w14, [x9, x13]
	lsl	x14, x12, #1
	ldr	w15, [x8, x14]
	ldr	w16, [x9, x14]
	str	w16, [x8, x14]
	str	w15, [x9, x14]
	lsl	x14, x10, #3
	sub	x15, x14, x10
	ldr	w16, [x8, x15]
	ldr	w17, [x9, x15]
	str	w17, [x8, x15]
	str	w16, [x9, x15]
	ldr	w15, [x8, x14]
	ldr	w16, [x9, x14]
	str	w16, [x8, x14]
	str	w15, [x9, x14]
	add	x14, x14, x10
	ldr	w15, [x8, x14]
	ldr	w16, [x9, x14]
	str	w16, [x8, x14]
	str	w15, [x9, x14]
	lsl	x13, x13, #1
	ldr	w14, [x8, x13]
	ldr	w15, [x9, x13]
	str	w15, [x8, x13]
	str	w14, [x9, x13]
	mul	x13, x10, x0
	ldr	w14, [x8, x13]
	ldr	w15, [x9, x13]
	str	w15, [x8, x13]
	str	w14, [x9, x13]
	ldr	w13, [x8, x12, lsl #2]
	ldr	w14, [x9, x12, lsl #2]
	str	w14, [x8, x12, lsl #2]
	str	w13, [x9, x12, lsl #2]
	mul	x12, x10, x1
	ldr	w13, [x8, x12]
	ldr	w14, [x9, x12]
	str	w14, [x8, x12]
	str	w13, [x9, x12]
	lsl	x10, x10, #4
	sub	x10, x10, x11
	ldr	w11, [x8, x10]
	ldr	w12, [x9, x10]
	str	w12, [x8, x10]
	str	w11, [x9, x10]
	stur	wzr, [x29, #-108]
	b	LBB2_2
LBB2_5:
Lloh10:
	adrp	x20, l___unnamed_1@PAGE
Lloh11:
	add	x20, x20, l___unnamed_1@PAGEOFF
	mov	x0, x20
	ldr	w19, [sp, #28]
	mov	x1, x19
	bl	___kmpc_for_static_fini
Lloh12:
	adrp	x0, l___unnamed_2@PAGE
Lloh13:
	add	x0, x0, l___unnamed_2@PAGEOFF
	mov	x1, x19
	bl	___kmpc_barrier
	sub	x8, x29, #108
	stur	x8, [x29, #-120]
Lloh14:
	adrp	x5, _.omp.reduction.func.1@PAGE
Lloh15:
	add	x5, x5, _.omp.reduction.func.1@PAGEOFF
Lloh16:
	adrp	x6, _.gomp_critical_user_.reduction.var@GOTPAGE
Lloh17:
	ldr	x6, [x6, _.gomp_critical_user_.reduction.var@GOTPAGEOFF]
	sub	x4, x29, #120
	mov	x0, x20
	mov	x1, x19
	mov	w2, #1
	mov	w3, #8
	bl	___kmpc_reduce
	cmp	w0, #1
	b.ne	LBB2_7
	ldr	x10, [sp, #16]
	ldr	w8, [x10]
	ldur	w9, [x29, #-108]
	cmp	w8, #0
	ccmp	w9, #0, #4, ne
	cset	w8, ne
	str	w8, [x10]
Lloh18:
	adrp	x0, l___unnamed_1@PAGE
Lloh19:
	add	x0, x0, l___unnamed_1@PAGEOFF
Lloh20:
	adrp	x2, _.gomp_critical_user_.reduction.var@GOTPAGE
Lloh21:
	ldr	x2, [x2, _.gomp_critical_user_.reduction.var@GOTPAGEOFF]
	mov	x1, x19
	bl	___kmpc_end_reduce
LBB2_7:
Lloh22:
	adrp	x0, l___unnamed_2@PAGE
Lloh23:
	add	x0, x0, l___unnamed_2@PAGEOFF
	mov	x1, x19
	bl	___kmpc_barrier
	ldp	x29, x30, [sp, #256]
	ldp	x20, x19, [sp, #240]
	ldp	x22, x21, [sp, #224]
	ldp	x24, x23, [sp, #208]
	ldp	x26, x25, [sp, #192]
	ldp	x28, x27, [sp, #176]
	add	sp, sp, #272
	ret
	.loh AdrpAdd	Lloh8, Lloh9
	.loh AdrpLdrGot	Lloh16, Lloh17
	.loh AdrpAdd	Lloh14, Lloh15
	.loh AdrpAdd	Lloh12, Lloh13
	.loh AdrpAdd	Lloh10, Lloh11
	.loh AdrpLdrGot	Lloh20, Lloh21
	.loh AdrpAdd	Lloh18, Lloh19
	.loh AdrpAdd	Lloh22, Lloh23

	.p2align	2
__QMsortingPsortempl..omp_par.2:
	sub	sp, sp, #272
	stp	x28, x27, [sp, #176]
	stp	x26, x25, [sp, #192]
	stp	x24, x23, [sp, #208]
	stp	x22, x21, [sp, #224]
	stp	x20, x19, [sp, #240]
	stp	x29, x30, [sp, #256]
	add	x29, sp, #256
	ldp	x8, x9, [x2, #16]
	str	x9, [sp, #16]
	ldp	x19, x9, [x2, #32]
	str	x9, [sp, #32]
	ldp	x23, x24, [x2, #48]
	ldr	w8, [x8]
	sub	w9, w8, #1
	mov	w10, #1
	stp	w10, w10, [x29, #-108]
	sub	w8, w8, #2
	lsr	w8, w8, #1
	cmp	w9, #0
	csinv	w8, w8, wzr, gt
	stp	w8, wzr, [x29, #-100]
Lloh24:
	adrp	x21, l___unnamed_1@PAGE
Lloh25:
	add	x21, x21, l___unnamed_1@PAGEOFF
	mov	x0, x21
	bl	___kmpc_global_thread_num
	mov	x1, x0
	str	wzr, [sp]
	sub	x3, x29, #92
	sub	x4, x29, #96
	sub	x5, x29, #100
	sub	x6, x29, #104
	mov	x0, x21
	str	w1, [sp, #28]
	mov	w2, #34
	mov	w7, #1
	bl	___kmpc_for_static_init_4u
	ldp	w9, w8, [x29, #-100]
	sub	w9, w9, w8
	cmn	w9, #1
	b.eq	LBB3_5
	ldrb	w10, [x19, #23]
	and	w25, w10, #0xfffffffe
	ldp	x10, x26, [x19, #32]
	ldr	x27, [x19, #64]
	bic	x28, x10, x10, asr #63
	add	w22, w9, #1
	lsl	w8, w8, #1
	ldr	x20, [x19]
	b	LBB3_3
LBB3_2:
	add	w8, w21, #2
	subs	w22, w22, #1
	b.eq	LBB3_5
LBB3_3:
	add	w9, w8, #1
	sxtw	x19, w9
	madd	x9, x27, x19, x20
	mov	w10, #4
	stp	x9, x10, [sp, #40]
	mov	w9, #55631
	movk	w9, #308, lsl #16
	str	w9, [sp, #56]
	mov	w11, #11265
	strh	w11, [sp, #60]
	strb	wzr, [sp, #62]
	strb	w25, [sp, #63]
	mov	w12, #1
	stp	x12, x28, [sp, #64]
	sxtw	x21, w8
	madd	x8, x27, x21, x20
	stp	x26, x8, [sp, #80]
	str	x10, [sp, #96]
	str	w9, [sp, #104]
	strh	w11, [sp, #108]
	strb	wzr, [sp, #110]
	strb	w25, [sp, #111]
	stp	x12, x28, [sp, #112]
	str	x26, [sp, #128]
	add	x0, sp, #40
	add	x1, sp, #88
	ldr	x2, [sp, #32]
	bl	__QMsortingPpositionless
	cbz	w0, LBB3_2
	ldr	x10, [x24, #40]
	ldr	x9, [x24, #64]
	ldr	x11, [x24]
	madd	x8, x9, x21, x11
	madd	x9, x9, x19, x11
	ldr	w11, [x8]
	ldr	w12, [x9]
	str	w12, [x8]
	str	w11, [x9]
	ldr	w11, [x8, x10]
	ldr	w12, [x9, x10]
	str	w12, [x8, x10]
	str	w11, [x9, x10]
	lsl	x11, x10, #1
	ldr	w12, [x8, x11]
	ldr	w13, [x9, x11]
	str	w13, [x8, x11]
	str	w12, [x9, x11]
	add	x12, x11, x10
	ldr	w13, [x8, x12]
	ldr	w14, [x9, x12]
	str	w14, [x8, x12]
	str	w13, [x9, x12]
	lsl	x13, x10, #2
	ldr	w14, [x8, x13]
	ldr	w15, [x9, x13]
	str	w15, [x8, x13]
	str	w14, [x9, x13]
	add	x13, x13, x10
	ldr	w14, [x8, x13]
	ldr	w15, [x9, x13]
	str	w15, [x8, x13]
	str	w14, [x9, x13]
	lsl	x14, x12, #1
	ldr	w15, [x8, x14]
	ldr	w16, [x9, x14]
	str	w16, [x8, x14]
	str	w15, [x9, x14]
	lsl	x14, x10, #3
	sub	x15, x14, x10
	ldr	w16, [x8, x15]
	ldr	w17, [x9, x15]
	str	w17, [x8, x15]
	str	w16, [x9, x15]
	ldr	w15, [x8, x14]
	ldr	w16, [x9, x14]
	str	w16, [x8, x14]
	str	w15, [x9, x14]
	add	x14, x14, x10
	ldr	w15, [x8, x14]
	ldr	w16, [x9, x14]
	str	w16, [x8, x14]
	str	w15, [x9, x14]
	lsl	x13, x13, #1
	ldr	w14, [x8, x13]
	ldr	w15, [x9, x13]
	str	w15, [x8, x13]
	str	w14, [x9, x13]
	mov	w0, #11
	mul	x13, x10, x0
	ldr	w14, [x8, x13]
	ldr	w15, [x9, x13]
	str	w15, [x8, x13]
	str	w14, [x9, x13]
	ldr	w13, [x8, x12, lsl #2]
	ldr	w14, [x9, x12, lsl #2]
	str	w14, [x8, x12, lsl #2]
	str	w13, [x9, x12, lsl #2]
	mov	w1, #13
	mul	x12, x10, x1
	ldr	w13, [x8, x12]
	ldr	w14, [x9, x12]
	str	w14, [x8, x12]
	str	w13, [x9, x12]
	lsl	x10, x10, #4
	sub	x10, x10, x11
	ldr	w11, [x8, x10]
	ldr	w12, [x9, x10]
	str	w12, [x8, x10]
	str	w11, [x9, x10]
	ldr	x10, [x23, #40]
	ldr	x9, [x23, #64]
	ldr	x11, [x23]
	madd	x8, x9, x21, x11
	madd	x9, x9, x19, x11
	ldr	w11, [x8]
	ldr	w12, [x9]
	str	w12, [x8]
	str	w11, [x9]
	ldr	w11, [x8, x10]
	ldr	w12, [x9, x10]
	str	w12, [x8, x10]
	str	w11, [x9, x10]
	lsl	x11, x10, #1
	ldr	w12, [x8, x11]
	ldr	w13, [x9, x11]
	str	w13, [x8, x11]
	str	w12, [x9, x11]
	add	x12, x11, x10
	ldr	w13, [x8, x12]
	ldr	w14, [x9, x12]
	str	w14, [x8, x12]
	str	w13, [x9, x12]
	lsl	x13, x10, #2
	ldr	w14, [x8, x13]
	ldr	w15, [x9, x13]
	str	w15, [x8, x13]
	str	w14, [x9, x13]
	add	x13, x13, x10
	ldr	w14, [x8, x13]
	ldr	w15, [x9, x13]
	str	w15, [x8, x13]
	str	w14, [x9, x13]
	lsl	x14, x12, #1
	ldr	w15, [x8, x14]
	ldr	w16, [x9, x14]
	str	w16, [x8, x14]
	str	w15, [x9, x14]
	lsl	x14, x10, #3
	sub	x15, x14, x10
	ldr	w16, [x8, x15]
	ldr	w17, [x9, x15]
	str	w17, [x8, x15]
	str	w16, [x9, x15]
	ldr	w15, [x8, x14]
	ldr	w16, [x9, x14]
	str	w16, [x8, x14]
	str	w15, [x9, x14]
	add	x14, x14, x10
	ldr	w15, [x8, x14]
	ldr	w16, [x9, x14]
	str	w16, [x8, x14]
	str	w15, [x9, x14]
	lsl	x13, x13, #1
	ldr	w14, [x8, x13]
	ldr	w15, [x9, x13]
	str	w15, [x8, x13]
	str	w14, [x9, x13]
	mul	x13, x10, x0
	ldr	w14, [x8, x13]
	ldr	w15, [x9, x13]
	str	w15, [x8, x13]
	str	w14, [x9, x13]
	ldr	w13, [x8, x12, lsl #2]
	ldr	w14, [x9, x12, lsl #2]
	str	w14, [x8, x12, lsl #2]
	str	w13, [x9, x12, lsl #2]
	mul	x12, x10, x1
	ldr	w13, [x8, x12]
	ldr	w14, [x9, x12]
	str	w14, [x8, x12]
	str	w13, [x9, x12]
	lsl	x10, x10, #4
	sub	x10, x10, x11
	ldr	w11, [x8, x10]
	ldr	w12, [x9, x10]
	str	w12, [x8, x10]
	str	w11, [x9, x10]
	stur	wzr, [x29, #-108]
	b	LBB3_2
LBB3_5:
Lloh26:
	adrp	x20, l___unnamed_1@PAGE
Lloh27:
	add	x20, x20, l___unnamed_1@PAGEOFF
	mov	x0, x20
	ldr	w19, [sp, #28]
	mov	x1, x19
	bl	___kmpc_for_static_fini
Lloh28:
	adrp	x0, l___unnamed_2@PAGE
Lloh29:
	add	x0, x0, l___unnamed_2@PAGEOFF
	mov	x1, x19
	bl	___kmpc_barrier
	sub	x8, x29, #108
	stur	x8, [x29, #-120]
Lloh30:
	adrp	x5, _.omp.reduction.func@PAGE
Lloh31:
	add	x5, x5, _.omp.reduction.func@PAGEOFF
Lloh32:
	adrp	x6, _.gomp_critical_user_.reduction.var@GOTPAGE
Lloh33:
	ldr	x6, [x6, _.gomp_critical_user_.reduction.var@GOTPAGEOFF]
	sub	x4, x29, #120
	mov	x0, x20
	mov	x1, x19
	mov	w2, #1
	mov	w3, #8
	bl	___kmpc_reduce
	cmp	w0, #1
	b.ne	LBB3_7
	ldr	x10, [sp, #16]
	ldr	w8, [x10]
	ldur	w9, [x29, #-108]
	cmp	w8, #0
	ccmp	w9, #0, #4, ne
	cset	w8, ne
	str	w8, [x10]
Lloh34:
	adrp	x0, l___unnamed_1@PAGE
Lloh35:
	add	x0, x0, l___unnamed_1@PAGEOFF
Lloh36:
	adrp	x2, _.gomp_critical_user_.reduction.var@GOTPAGE
Lloh37:
	ldr	x2, [x2, _.gomp_critical_user_.reduction.var@GOTPAGEOFF]
	mov	x1, x19
	bl	___kmpc_end_reduce
LBB3_7:
Lloh38:
	adrp	x0, l___unnamed_2@PAGE
Lloh39:
	add	x0, x0, l___unnamed_2@PAGEOFF
	mov	x1, x19
	bl	___kmpc_barrier
	ldp	x29, x30, [sp, #256]
	ldp	x20, x19, [sp, #240]
	ldp	x22, x21, [sp, #224]
	ldp	x24, x23, [sp, #208]
	ldp	x26, x25, [sp, #192]
	ldp	x28, x27, [sp, #176]
	add	sp, sp, #272
	ret
	.loh AdrpAdd	Lloh24, Lloh25
	.loh AdrpLdrGot	Lloh32, Lloh33
	.loh AdrpAdd	Lloh30, Lloh31
	.loh AdrpAdd	Lloh28, Lloh29
	.loh AdrpAdd	Lloh26, Lloh27
	.loh AdrpLdrGot	Lloh36, Lloh37
	.loh AdrpAdd	Lloh34, Lloh35
	.loh AdrpAdd	Lloh38, Lloh39

	.p2align	2
__QMsortingPsortempl..omp_par:
	stp	x22, x21, [sp, #-48]!
	stp	x20, x19, [sp, #16]
	stp	x29, x30, [sp, #32]
	add	x29, sp, #32
Lloh40:
	adrp	x20, l___unnamed_1@PAGE
Lloh41:
	add	x20, x20, l___unnamed_1@PAGEOFF
	mov	x0, x20
	bl	___kmpc_global_thread_num
	mov	x19, x0
	mov	x0, x20
	mov	x1, x19
	bl	___kmpc_single
	cbz	w0, LBB4_2
Lloh42:
	adrp	x20, __QQclX4a371998d3834160fecaf6dcb60525bf@GOTPAGE
Lloh43:
	ldr	x20, [x20, __QQclX4a371998d3834160fecaf6dcb60525bf@GOTPAGEOFF]
	mov	w0, #6
	mov	x1, x20
	mov	w2, #59
	bl	__FortranAioBeginExternalListOutput
	mov	x21, x0
Lloh44:
	adrp	x1, __QQclX3D3D3D20D092D0BDD183D182D180D0B820536F7274456D706C203D3D3D@GOTPAGE
Lloh45:
	ldr	x1, [x1, __QQclX3D3D3D20D092D0BDD183D182D180D0B820536F7274456D706C203D3D3D@GOTPAGEOFF]
	mov	w2, #29
	bl	__FortranAioOutputAscii
	mov	x0, x21
	bl	__FortranAioEndIoStatement
	mov	w0, #6
	mov	x1, x20
	mov	w2, #60
	bl	__FortranAioBeginExternalListOutput
	mov	x21, x0
Lloh46:
	adrp	x1, __QQclXb2400978d02278642bb20263cae58716@GOTPAGE
Lloh47:
	ldr	x1, [x1, __QQclXb2400978d02278642bb20263cae58716@GOTPAGEOFF]
	mov	w2, #37
	bl	__FortranAioOutputAscii
	bl	_omp_get_num_threads
	mov	x1, x0
	mov	x0, x21
	bl	__FortranAioOutputInteger32
	mov	x0, x21
	bl	__FortranAioEndIoStatement
	mov	w0, #6
	mov	x1, x20
	mov	w2, #61
	bl	__FortranAioBeginExternalListOutput
	mov	x21, x0
Lloh48:
	adrp	x1, __QQclXc5a8d12074dfdde05db04b30655b9d22@GOTPAGE
Lloh49:
	ldr	x1, [x1, __QQclXc5a8d12074dfdde05db04b30655b9d22@GOTPAGEOFF]
	mov	w2, #35
	bl	__FortranAioOutputAscii
	bl	_omp_get_max_threads
	mov	x1, x0
	mov	x0, x21
	bl	__FortranAioOutputInteger32
	mov	x0, x21
	bl	__FortranAioEndIoStatement
	mov	w0, #6
	mov	x1, x20
	mov	w2, #62
	bl	__FortranAioBeginExternalListOutput
	mov	x20, x0
Lloh50:
	adrp	x1, __QQclX3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D@GOTPAGE
Lloh51:
	ldr	x1, [x1, __QQclX3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D@GOTPAGEOFF]
	mov	w2, #22
	bl	__FortranAioOutputAscii
	mov	x0, x20
	bl	__FortranAioEndIoStatement
Lloh52:
	adrp	x0, l___unnamed_1@PAGE
Lloh53:
	add	x0, x0, l___unnamed_1@PAGEOFF
	mov	x1, x19
	bl	___kmpc_end_single
LBB4_2:
Lloh54:
	adrp	x0, l___unnamed_2@PAGE
Lloh55:
	add	x0, x0, l___unnamed_2@PAGEOFF
	mov	x1, x19
	ldp	x29, x30, [sp, #32]
	ldp	x20, x19, [sp, #16]
	ldp	x22, x21, [sp], #48
	b	___kmpc_barrier
	.loh AdrpAdd	Lloh40, Lloh41
	.loh AdrpAdd	Lloh52, Lloh53
	.loh AdrpLdrGot	Lloh50, Lloh51
	.loh AdrpLdrGot	Lloh48, Lloh49
	.loh AdrpLdrGot	Lloh46, Lloh47
	.loh AdrpLdrGot	Lloh44, Lloh45
	.loh AdrpLdrGot	Lloh42, Lloh43
	.loh AdrpAdd	Lloh54, Lloh55

	.p2align	2
_.omp.reduction.func:
	ldr	x8, [x0]
	ldr	w9, [x8]
	ldr	x10, [x1]
	ldr	w10, [x10]
	cmp	w9, #0
	ccmp	w10, #0, #4, ne
	cset	w9, ne
	str	w9, [x8]
	ret

	.p2align	2
_.omp.reduction.func.1:
	ldr	x8, [x0]
	ldr	w9, [x8]
	ldr	x10, [x1]
	ldr	w10, [x10]
	cmp	w9, #0
	ccmp	w10, #0, #4, ne
	cset	w9, ne
	str	w9, [x8]
	ret

	.section	__TEXT,__const
	.globl	__QQclX4a371998d3834160fecaf6dcb60525bf
	.weak_definition	__QQclX4a371998d3834160fecaf6dcb60525bf
	.p2align	4, 0x0
__QQclX4a371998d3834160fecaf6dcb60525bf:
	.asciz	"/Users/varvarafedorova/Desktop/course_work/1_2b/src/sorting.f90"

	.globl	__QQclX3D3D3D20D092D0BDD183D182D180D0B820536F7274456D706C203D3D3D
	.weak_definition	__QQclX3D3D3D20D092D0BDD183D182D180D0B820536F7274456D706C203D3D3D
	.p2align	4, 0x0
__QQclX3D3D3D20D092D0BDD183D182D180D0B820536F7274456D706C203D3D3D:
	.ascii	"=== \320\222\320\275\321\203\321\202\321\200\320\270 SortEmpl ==="

	.globl	__QQclXb2400978d02278642bb20263cae58716
	.weak_definition	__QQclXb2400978d02278642bb20263cae58716
	.p2align	4, 0x0
__QQclXb2400978d02278642bb20263cae58716:
	.ascii	"\320\232\320\276\320\273\320\270\321\207\320\265\321\201\321\202\320\262\320\276 \320\277\320\276\321\202\320\276\320\272\320\276\320\262: "

	.globl	__QQclXc5a8d12074dfdde05db04b30655b9d22
	.weak_definition	__QQclXc5a8d12074dfdde05db04b30655b9d22
	.p2align	4, 0x0
__QQclXc5a8d12074dfdde05db04b30655b9d22:
	.ascii	"\320\234\320\260\320\272\321\201\320\270\320\274\321\203\320\274 \320\277\320\276\321\202\320\276\320\272\320\276\320\262:   "

	.globl	__QQclX3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D
	.weak_definition	__QQclX3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D
	.p2align	4, 0x0
__QQclX3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D:
	.space	22,61

	.section	__TEXT,__cstring,cstring_literals
l___unnamed_3:
	.asciz	";unknown;unknown;0;0;;"

	.section	__DATA,__const
	.p2align	3, 0x0
l___unnamed_1:
	.long	0
	.long	2
	.long	0
	.long	22
	.quad	l___unnamed_3

	.p2align	3, 0x0
l___unnamed_2:
	.long	0
	.long	66
	.long	0
	.long	22
	.quad	l___unnamed_3

	.comm	_.gomp_critical_user_.reduction.var,32,3
.subsections_via_symbols
