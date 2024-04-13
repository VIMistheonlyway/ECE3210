.data
array:  .byte   0, 2, 4, 6, 8, -1, -3, -5, -7

.text
.global main
main:
    
	ldr r0, =array
	
	ldrb r1, [r0] @load the address of r0 then into r1
	add r10, r10, r1 @adds r1 to r10 and loops through to r9
	
	add r0, #1 @increments by one 
	ldrb r2, [r0] @stores the value register immediate
	add r10, r10, r2
	
	add r0, #1
	ldrb r3, [r0]
	add r10, r10, r3
	
	add r0, #1
	ldrb r4, [r0]
	add r10, r10, r4
	
	add r0, #1
	ldrb r5, [r0]
	add r10, r10, r5
	
	add r0, #1
	ldrb r6, [r0]
	add r10, r10, r6
	
	add r0, #1
	ldrb r7, [r0]
	add r10, r10, r7
	
	add r0, #1
	ldrb r8, [r0]
	add r10, r10, r8
	
	add r0, #1
	ldrb r9, [r0]
	add r10, r10, r9 @final sum of all registers into r10
	
	@second part of deliverable 2
	
	ldr r0, =array
	
	ldrsb r1, [r0] @load the address of r0 then into r1 look for signed value
	add r11, r11, r1 @adds r1 to r10 and loops through to r9
	
	
	ldrsb r2, [r0, #1] @stores the value, immediate offset, preindex
	add r11, r11, r2
	
	
	ldrsb r3, [r0, #2]
	add r11, r11, r3
	
	
	ldrsb r4, [r0, #3]
	add r11, r11, r4
	
	
	ldrsb r5, [r0, #4]
	add r11, r11, r5
	
	
	ldrsb r6, [r0, #5]
	add r11, r11, r6
	
	
	ldrsb r7, [r0 #6]
	add r11, r11, r7
	
	
	ldrsb r8, [r0, #7]
	add r11, r11, r8
	
	
	ldrsb r9, [r0,#8]
	add r11, r11, r9 @final sum of all registers into r11
	

        @ exit syscall
        mov r7, #1
        swi 0 
