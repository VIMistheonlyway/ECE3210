.data

array:	.word 10, 15

.text
.global main

main:
	
	ldr r0, =array
	
	ldmia r0!, {r1} @load the value of r1, 10 into the updated address of r0, r2
	ldmia r0, {r2} @load r2 into the spot of r0, r1
	
	stmda r0!, {r1} @store that value of the updated address into r1
	stmia r0, {r2} @store the value of r0 15 into r2
	
	ldmia r0, {r1, r2} @load the new values of r1 and r2, 15 and 10

    @ exit syscall
    mov r7, #1
    swi 0
