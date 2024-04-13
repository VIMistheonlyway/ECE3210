.data

.text
.global main

main:
	@ Examine the CPSR register and determine what was the value
	@ for C(carry flag) and V(overflow flag)
	ldr r1, =0xFFFFFFFF
	ldr r2, =0x05
	adds r3, r2, r1
	
	@ Examine the CPSR register and determine what was the value
	@ for C(carry flag) and V(overflow flag)
	ldr r1, =0xB0000000
	ldr r2, =0xB0000000
	adds r3, r2, r1
	
    @ exit syscall
    mov r7, #1
    swi 0
