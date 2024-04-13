.data
array:  .byte -1, 5, 3, 8, 10, 23, 6, 5, 2, -10
size:   .byte 10

.text
.global main

main:
	mov r1, #0 @stores value into r1
	ldr r2, =array
	ldr r4, =array
	mov r5, #0 @counter
	ldr r6, =size
	ldrb r6, [r6] @10

max:	ldrsb r3, [r4, #1]!	@increments register and stores value in r3
	add r5, r5, #1		@increments the counter
	
	cmp r3, r1		@compares the value r3 with the previous value
	movgt r1, r3		@if r3 is greater than r1
	bgt else		@if else loop for storing the max address
	
	cmp r5, r6		@comparing the counter
	beq endloop
	
	blt max	
else:
	mov r2, r4		@stores the register of the highest value into the new register
	b max

endloop:

    @ exit syscall
    mov r7, #1
    swi 0

