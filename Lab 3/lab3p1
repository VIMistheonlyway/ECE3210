.data

num1: .word 0x0000FFFF

num2: .word 0x12345678

res1: .word 0x00000000

res2: .word 0x00000000

.text
.global main
main:
    
	ldr r0, =num1
	ldr r1, [r0] @num1
	
	ldr r5, =num2
	ldr r6, [r5]
	
	ldr r8, =res1
	ldr r10, [r8]
	
	ldr r9, =res2
	ldr r4, [r9]
	
	lsl r11, r1, #16 @shift num1 16 bits to get 0xFFFF0000
	and r3, r11, r6 @and compares num2 to num1 and then stores the values as 0x12340000
	
	mvn r12, r1 @will peform logical not and save it to r12
	and r4, r12, r6 @compares the logical not with the 0s
	
	str r3, [r8] @stores our register value into res1
	str r4, [r9] @stores the register value into res2
	
        @ exit syscall
        mov r7, #1
        swi 0 
