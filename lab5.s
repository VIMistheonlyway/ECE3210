
/////////////// MACROS ////////////////
.macro error
	mov r7, #4	@prints the error message
	mov r0, #1
	mov r2, #110
	ldr r1, =ErrorM
	swi 0
.endm
///////////////////////////////////////

.data

input:		.space 20

prompt:		.ascii "Enter an algebraic command line: "

ErrorM:		.ascii "ERROR!!!\nInput Format: Operand1 Operator Operand2\nOperand: decimal values (-128 to 127)\nOperators: + - * / %\n"

operand1_Ap:	.ascii "operand 1: "
operatorp:	.ascii "\noperator: "
operand2_Ap:	.ascii "\noperand 2: "
resultp:	.ascii "\nresult: "

operand1_A:	.ascii "     "	@must be at least 5 spaces
operator:	.ascii "     "
operand2_A:	.ascii "     "

operand1_H:	.byte 0
operand2_H:	.byte 0
result_H:	.word 0

result_A:	.space 10

.text
.global main

//////////// GIVEN FUNCTIONS //////////
// ===== HEX to ASCII conversion =====
// r0 - address of a hex value variable
// r1 - addrees of a ASCII value variable
 
hex_to_ascii:
        push    {r1, r2, r3, r5, r6, r7, r8, r9, lr}
        ldrb    r8, [r0]
        mov        r9,    r1
        
        @ Initialization for hex to ascii
        mov     r1, r8      @ dividend
        mov     r2, #10     @ divisor
        mov     r5, #0      @ counter

        @ Start conversion with dividing by 10
next_digit:
        udiv    r3, r1, r2
        mul     r7, r3, r2
        sub     r1, r1, r7

        add     r1, r1, #0x30   @ increment by 0x30 to get the ascii value
        push    {r1}            @ push the converted value into the stack
        add     r5, r5, #1      @ increment the counter
        mov     r1, r3          @ update the dividend
        cmp     r3, #0          @ check whether the conversion is finished
        bne     next_digit

        @ Store the converted value into memory
        mov     r6, r9
store_asci:
        pop     {r1}            @ pop each digit from the stack
        strb    r1, [r6]        @ store the digit into memory
        add     r6, r6, #1      @ increment the address
        sub     r5, r5, #1      @ decrement the counter
        cmp     r5, #0
        bne     store_asci

        pop     {r1, r2, r3, r5, r6, r7, r8, r9, lr}
        bx      lr
        
////////// Subroutines ////////////////

A_to_H:	push {r5, r6, lr}
	mov r6, #0
	ldrb r5, [r1]
	cmp r5, #0x2D	@compare r5 with "-" symbol and then conditional insts for negative
	moveq r6, #1
	addeq r1, #1
	ldrb r5, [r1]
	mov r4, #0
	
h:	sub r5, r5, #0x30	@subs ascii by 30 to get hex digit
	mov r11, #10
	mul r4, r11, r4
	add r4, r4, r5
	ldrb r5, [r1, #1]!
	cmp r5, #0x20	@compares with space if no space then continue looping
	bne h
	
	cmp r6, #1	@compare with negative value of 1, if negative perform the 2's complement
	mvneq r2, r4
	addeq r2, r2, #1
	movne r2, r4
	
	
	pop {r5, r6, lr}
	bx lr
		
	
///////////////////////////////////////

main:
        
        mov r7, #4	@prints the prompt
	mov r0, #1
	mov r2, #33
	ldr r1, =prompt
	swi 0
	
	mov r7, #3	@the "scanf"
	mov r0, #0
	mov r2, #20
	ldr r1, =input
	swi 0

	ldr r0, =input		@the string loaded
	ldr r1, =operand1_A
	ldr r2, =operand2_A
	ldr r3, =operator
	
/// check input ///	

op1:	ldrb r4, [r0], #1
	
	cmp r4, #0x20	@if r4 finds a space break to function operator
	beq func
	
	cmp r4, #0x2D	@if the first value of the address is "-" set negative
	beq neg1

	cmp r4, #0x30	@checks if the digits of r0 are numbers
	blt err
	cmp r4, #0x39
	bgt err
	
	strb r4, [r1], #1
	b op1

func:	ldrb r4, [r0]	

	cmp r4, #0x2B	@checks addition
	beq setop
	
	cmp r4, #0x2D	@checks subtraction
	beq setop 
	
	cmp r4, #0x2A	@checks multiplication
	beq setop
	
	cmp r4, #0x2F	@checks division
	beq setop
	
	cmp r4, #0x25	@checks mod
	beq setop
	
	b err 		@if none of these then error
	
setop:	
	strb r4, [r3]	@stores the operator into r3
	ldrb r4, [r0, #1]!
	
op2:	ldrb r4, [r0, #1]!

	cmp r4, #0x0A @if " " end loop end all and print result
	beq subr
	
	cmp r4, #0x2D	@instruction 3 on the value
	beq neg2
		
	cmp r4, #0x30	@checks that the digits of r0 are numbers
	blt err
	cmp r4, #0x39	
	bgt err

	strb r4, [r2], #1
	b op2
//////

/// check negative ///
neg1:	strb r4, [r1], #1	@checks negative value and stores it into the address and increments by 1
	b op1

neg2:	strb r4, [r2], #1
	b op2
//////

/// operator check for arithmetic operation ///
oper:	
	ldrb r4, [r3]
	
	cmp r4, #0x2B	@checks addition
	beq addo 
	
	cmp r4, #0x2D	@checks subtraction
	beq subo 
	
	cmp r4, #0x2A	@checks multiplication
	beq mulo
	
	cmp r4, #0x2F	@checks division
	beq divo
	
	cmp r4, #0x25	@checks mod
	beq modo
//////

/// operations ///

			@all functions are 's' signed, for negative values that may be passed
addo:			@addition function
	ldr r11, =result_H
	ldrsb r1, [r8]	@need sb or else it will load wrong values
	ldrsb r2, [r9]
	adds r1, r1, r2
	strb r1, [r11]
	b res	
	
subo:			@subtraction function
	ldr r11, =result_H
	ldrsb r1, [r8]	
	ldrsb r2, [r9]
	subs r1, r1, r2
	strb r1, [r11]
	b res	
	
mulo:			@multiplication function
	ldr r11, =result_H
	ldrsb r1, [r8]
	ldrsb r2, [r9]
	muls r1, r2, r1
	strb r1, [r11]
	b res	
	
divo:			@division function
	ldr r11, =result_H
	ldrsb r1, [r8]
	ldrsb r2, [r9]
	sdiv r1, r1, r2
	strb r1, [r11]
	b res	
	
modo:			@mod function 
	ldr r11, =result_H
	ldrsb r1, [r8]
	ldrsb r2, [r9]
	sdiv r10, r1, r2
	muls r10, r2, r10
	subs r1, r1, r10
	strb r1, [r11]
	b res	
//////

/// macros ///

err:	error 
	b end
//////

/// subroutine call ///

subr:	
	ldr r1, =operand1_A	@loads the values of the operands into the a_to_h subroutine
	bl A_to_H
	ldr r8, =operand1_H
	strb r2, [r8]		@the storing of the value into the Hex form
	ldr r1, =operand2_A
	bl A_to_H
	ldr r9, =operand2_H
	strb r2, [r9]
	b oper			@branch to the operation check
//////

/// result ///

res:	
	mov r3, #0x2D
	ldr r0, =result_H
	ldr r1, =result_A
	ldrsb r2, [r0]
	cmp r2, #0 	@checks if my value is negative and branches if it is
	blt nr
	b res2

nr:
	
	strb r3, [r1], #1	@conditional instructions if <0 then store "-" into r2
	mvn r2, r2		@flip back to the positive number
	add r2, r2, #1


res2:	
	strb r2, [r0]
	bl hex_to_ascii		@branch to hex to ascii subroutine
	
	mov r7, #4		@prints the operand 1 prompt
	mov r0, #1
	mov r2, #11
	ldr r1, =operand1_Ap
	swi 0
//////

/// printing results ///

	mov r7, #4		@prints operand 1
	mov r0, #1
	mov r2, #4
	ldr r1, =operand1_A
	swi 0

	mov r7, #4		@prints the operand 2 prompt
	mov r0, #1
	mov r2, #12
	ldr r1, =operand2_Ap
	swi 0
		
	mov r7, #4		@prints operand 2
	mov r0, #1
	mov r2, #4
	ldr r1, =operand2_A
	swi 0

	mov r7, #4		@prints the operator prompt
	mov r0, #1
	mov r2, #11
	ldr r1, =operatorp
	swi 0	
	
	mov r7, #4		@prints the operator
	mov r0, #1
	mov r2, #4
	ldr r1, =operator
	swi 0	

	mov r7, #4		@prints the result prompt
	mov r0, #1
	mov r2, #9
	ldr r1, =resultp
	swi 0
		
	mov r7, #4		@prints the result
	mov r0, #1
	mov r2, #4
	ldr r1, =result_A
	swi 0
//////

end:	

        @ exit system call
        mov        r7, #1
        swi     0
