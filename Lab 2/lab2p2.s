.data

num1: .word 11  	@ 4. declare a byte variable num1 with decimal value 11

num2: .word 0xD 	@ 5. declare a byte variable num2 with hex value D

result: .word 0      	@ 9. declare a byte variable result with 0

.text
.global main

main:
	ldr r0, =0x3AB 	@ 1. Assign 3AB to r0 as hex

	mov r1, #0b1101 	@ 2. Assign 1101 to r1 as binary
	
	ldr r2, =25 	@ 3. Assign 25 to r2 as decimal
	
	ldr r0, =num1 	@ 6. load the address of num1 into r0
	
	ldr r1, =num2 	@ 6. load the address of num2 into r1
	
	ldr r2, [r0] 	@ 7. load the content of num1 into r2
	
	ldr r3, [r1] 	@ 7. load the content of num2 into r3
	
	add r4, r2, r3 	@ 8. perform addition of r2, r3 and store into r4
	
	ldr r0, =result @ 10. Load the address of result into r0
	
	str r4, [r0] @ 11. store the value in r4 into variable result
	
	
    @ exit syscall
    mov r7, #1
    swi 0
