isPalindrome(char*):
	push	{r3, r4, r5, lr}
	mov	r4, r0
	bl	strlen
	lsr	r3, r0, #31
	adds	r2, r0, r3
	and	r2, r2, #1
	subs	r3, r2, r3
	cmp	r3, #1
	bne	.L5
	add	r5, r0, r0, lsr #31
	asr	r5, r5, #1
	cmp	r5, #0
	ble	.L6
	adds	r3, r4, r0
	ldrb	r2, [r4, #0]	@ zero_extendqisi2
	ldrb	r3, [r3, #-1]	@ zero_extendqisi2
	cmp	r2, r3
	ittt	eq
	moveq	r2, r4
	addeq	r4, r4, r0
	moveq	r3, #0
	beq	.L3
	b	.L9
.L4:
	ldrb	r1, [r2, #1]!	@ zero_extendqisi2
	add	r4, r4, #-1
	ldrb	r0, [r4, #-1]	@ zero_extendqisi2
	cmp	r0, r1
	bne	.L8
.L3:
	add	r3, r3, #1
	cmp	r3, r5
	bne	.L4
	mov	r0, #1
	pop	{r3, r4, r5, pc}
.L5:
	mov	r0, #-1
	pop	{r3, r4, r5, pc}
.L6:
	mov	r0, #1
	pop	{r3, r4, r5, pc}
.L9:
	mov	r0, #0
	pop	{r3, r4, r5, pc}
.L8:
	mov	r0, #0
	pop	{r3, r4, r5, pc}
main:
	push	{r3, r4, r5, lr}
	movw	r4, #:lower16:.LC0
	movt	r4, #:upper16:.LC0
	mov	r0, r4
	bl	isPalindrome(char*)
	mov	r3, r0
	movw	r5, #:lower16:.LC1
	movt	r5, #:upper16:.LC1
	mov	r0, #1
	mov	r1, r5
	mov	r2, r4
	bl	__printf_chk
	movw	r4, #:lower16:.LC2
	movt	r4, #:upper16:.LC2
	mov	r0, r4
	bl	isPalindrome(char*)
	mov	r3, r0
	mov	r0, #1
	mov	r1, r5
	mov	r2, r4
	bl	__printf_chk
	mov	r0, #0
	pop	{r3, r4, r5, pc}
.LC0:
	.ascii	"not\000"
.LC1:
	.ascii	"Is \"%s\" a palindrome? %d\012\000"
.LC2:
	.ascii	"dad\000"
