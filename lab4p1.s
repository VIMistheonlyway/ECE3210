.data
fibonacci :  .byte   1, 1, 0, 0, 0, 0, 0, 0, 0, 0
string: .ascii  "tOdAyIsAsUnNyDaY"

.text
.global main
main:

	@String sequence

	ldr r0, =string @string initialized values
	ldr r1, [r0]
	mov r2, #0	@counter

stri:	sub r1, #32 	@in ascii table the upper letter 32 less than the lower
	str r1, [r0]	@storing the address value into r0
	add r0, #2	@adding 2 to the base address to get to the next lowercase letter
	ldr r1, [r0]	@load the next value of the base address into r1 
	
	add r2, #1 	@increment the counter	
	cmp r2, #8	@comparing the counter with the character limit to kill the program
	beq endloop1
	blt stri	

endloop1:
	
	@fibonacci sequence
	
	ldr r3, =fibonacci
	mov r4, #0 	@counter
	ldrb r5, [r3]
	add r3, #1
	ldrb r6, [r3]
	add r3, #1 	@increment the base register by 1
	
fibo:	add r5, r5, r6 	@add 1st and 2nd, then store that in r5
	strb r5, [r3] 	@store the value r5 into r3
	add r3, #1	@increment r3
	add r6, r5, r6	@add 1st and 2nd term post increment of r3
	strb r6, [r3]	@store that new value in the new r3
	add r3, #1	@increment r3 again
	

	add r4, #1	@increment counter
	cmp r4, #4	@for the first 10 terms, the first 2 have to be initialized
	beq endloop2
	blt fibo

endloop2:

        @ exit syscall
        mov r7, #1
        swi 0 
