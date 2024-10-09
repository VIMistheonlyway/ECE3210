.data

prices:	.ascii "$7"
pricec:	.ascii "$6"
pricem:	.ascii "$8"
price:	.ascii "  "

.text
.global main

////////// Subroutines ////////////////

MoviePrice:	
	
	push {r8, r10, r12, lr}	@pushed addresses
	ldr r4, =0		
	cmp r1, #65
	bge senior
	b cc
	
senior:	ldr r4, [r10] @stores the value of the address r10 in r4
	b ends
	
cc:	cmp r1, #12
	ble child
	b cm
	
child:	ldr r4, [r12]
	b ends

cm:	ldr r4, [r8]
	
ends:	pop {r8, r10, r12, lr}
	bx lr
		
	
///////////////////////////////////////

main:
	ldr r10, =prices	@addresses of my variables
	ldr r12, =pricec
	ldr r8, =pricem
	ldr r2, =price
	
	mov r1, #20	@age
	bl MoviePrice
	str r4, [r2]	@stores that value into the register r2 which is the price
	
        @ exit system call
        mov        r7, #1
        swi     0
