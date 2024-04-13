.macro INC_COUNT var

	ldr r8, =\var
	ldrb r9, [r8]
	add r9, r9, #1
	strb r9, [r8]
.endm

.data

COUNT_OTHER:	.byte 0
COUNT_SPACE:	.byte 0
COUNT_CAP:	.byte 0
COUNT_SMALL:	.byte 0
COUNT_DIGIT:	.byte 0

INPUT: .space 40
PROMPT: .ascii "Input String:"

.text
.global main

main:
	
	mov r7, #4 @prints the prompt
	mov r0, #1
	mov r2, #13
	ldr r1, =PROMPT
	swi 0
	
	mov r7, #3 @the "scanf"
	mov r0, #0
	mov r2, #40
	ldr r1, =INPUT
	swi 0
	
	mov r7, #4 @prints the output
	mov r0, #1
	mov r2, #40
	ldr r1, =INPUT
	swi 0
	
	ldr r3, =INPUT @loads the input given, and then converts to byte for counting
	ldrb r4, [r3]
	
loop:	

	cmp r4, #10 @ten is the decimal value for the ascii enter button
	beq endloop	
	
	cmp r4, #65 @compares capital letter in the ascii table
	blt elses
	cmp r4, #90 @between the two it will move to the macro and give a value for the count
	bgt elses @if less or greater than it will bump to the next then else statement
	INC_COUNT COUNT_CAP
	b end

elses:	cmp r4, #97 @same process as the captial but for lower case
	blt elsed
	cmp r4, #122
	bgt elsed @greater or less it jumps down
	INC_COUNT COUNT_SMALL
	b end

elsed:	cmp r4, #48 @checks for digit
	blt elsesp 
	cmp r4, #57
	bgt elsesp
	INC_COUNT COUNT_DIGIT
	b end

elsesp:	cmp r4, #32
	beq thensp @checks for space
	bne elseo
thensp:	INC_COUNT COUNT_SPACE
	b end
	
elseo:	INC_COUNT COUNT_OTHER @if none of the above it must be a special character
	b end


end:	add r3, r3, #1 @address increment
	ldrb r4, [r3]
	b loop

endloop:
	
    @ exit syscall
    mov r7, #1
    swi 0
