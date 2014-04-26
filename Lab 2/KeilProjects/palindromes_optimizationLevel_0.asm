isPalindrome(char*):
	push	{r7, lr}
	sub	sp, sp, #16
	add	r7, sp, #0
	str	r0, [r7, #4]
	ldr	r0, [r7, #4]
	bl	strlen
	mov	r3, r0
	str	r3, [r7, #8]
	ldr	r2, [r7, #8]
	asr	r3, r2, #31
	lsr	r3, r3, #31
	adds	r2, r2, r3
	and	r2, r2, #1
	subs	r3, r2, r3
	cmp	r3, #1
	beq	.L2
	mov	r3, #-1
	b	.L3
.L2:
	mov	r3, #0
	str	r3, [r7, #12]
	b	.L4
.L6:
	ldr	r3, [r7, #12]
	ldr	r2, [r7, #4]
	adds	r3, r2, r3
	ldrb	r2, [r3, #0]	@ zero_extendqisi2
	ldr	r3, [r7, #8]
	add	r3, r3, #-1
	ldr	r1, [r7, #4]
	adds	r3, r1, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r2, r3
	beq	.L5
	mov	r3, #0
	b	.L3
.L5:
	ldr	r3, [r7, #8]
	add	r3, r3, #-1
	str	r3, [r7, #8]
	ldr	r3, [r7, #12]
	add	r3, r3, #1
	str	r3, [r7, #12]
.L4:
	ldr	r0, [r7, #4]
	bl	strlen
	mov	r3, r0
	lsr	r2, r3, #31
	adds	r3, r2, r3
	asr	r3, r3, #1
	mov	r2, r3
	ldr	r3, [r7, #12]
	cmp	r2, r3
	ite	le
	movle	r3, #0
	movgt	r3, #1
	uxtb	r3, r3
	cmp	r3, #0
	bne	.L6
	mov	r3, #1
.L3:
	mov	r0, r3
	add	r7, r7, #16
	mov	sp, r7
	pop	{r7, pc}
.LC0:
	.ascii	"not\000"
.LC1:
	.ascii	"dad\000"
.LC2:
	.ascii	"Is \"%s\" a palindrome? %d\012\000"
main:
	push	{r7, lr}
	sub	sp, sp, #16
	add	r7, sp, #0
	str	r0, [r7, #4]
	str	r1, [r7, #0]
	movw	r3, #:lower16:.LC0
	movt	r3, #:upper16:.LC0
	str	r3, [r7, #8]
	movw	r3, #:lower16:.LC1
	movt	r3, #:upper16:.LC1
	str	r3, [r7, #12]
	ldr	r0, [r7, #8]
	bl	isPalindrome(char*)
	mov	r3, r0
	movw	r0, #:lower16:.LC2
	movt	r0, #:upper16:.LC2
	ldr	r1, [r7, #8]
	mov	r2, r3
	bl	printf
	ldr	r0, [r7, #12]
	bl	isPalindrome(char*)
	mov	r3, r0
	movw	r0, #:lower16:.LC2
	movt	r0, #:upper16:.LC2
	ldr	r1, [r7, #12]
	mov	r2, r3
	bl	printf
	mov	r3, #0
	mov	r0, r3
	add	r7, r7, #16
	mov	sp, r7
	pop	{r7, pc}
