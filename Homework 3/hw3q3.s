.data

.text
.global main

main:

@WORK AND FINISH THIS TOMORROW

	ldrh r0, =0b1111111111111111
	
	ldrh r1, =0b1111111111111110
	
	ldrh r2, =0b0000000000100110
	
	ldrh r3, =0b0000100010000000
	
	lsl r0, r0, #1

	and r0, r0, r1 	  @0111111111111110
	
	orr r0, r0, r2    
	
	eor r0, r0, r3 
	
	
    @ exit syscall
    mov r7, #1
    swi 0
