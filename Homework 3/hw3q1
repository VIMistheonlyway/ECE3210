.data

carry:		.byte 0
overflow:	.byte 0

.text
.global main

main:
	@carry = x & y || x & r! || y & r!
	@overflow = x & y & r! || x! & y! & r
	
	mov r1, #0b10001111
	mov r2, #0b10000111
	ldr r11, =carry
	ldr r12, =overflow
	mov r3, #0
	mov r4, #0
	mov r5, #0
	mov r6, #0
	mov r8, #0
	mov r9, #0
	mov r10, #0
	
	add r0, r1, r2
	lsr r0, #7
	lsr r1, #7
	lsr r2, #7
	bfc r1, #1, #7 @clear bits after rotating to get msb
	bfc r2, #1, #7
	bfc r0, #1, #7
	
	
	@check c flag
	
	and r3, r1, r2 @ & operations for the c flag
	
	mvn r0, r0 @inverse of result r0
	and r4, r1, r0
	and r5, r2, r0
		
	orr r6, r3, r4 @ or operation
	orr r8, r6, r5
	
	str r8, [r11] @store the value of the comparisons into the address of the c flag r11

v:
	@check overflow flag
	
	and r9, r3, r0 @first and for the v flag
	mvn r3, r3 @logical not of x & y
	mvn r0, r0
	
	and r10, r9, r3
	
	orr r10, r9, r10 @or operation
	str r10, [r12]
	

    @ exit syscall
    mov r7, #1
    swi 0
