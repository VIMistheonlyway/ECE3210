.data

a:	.byte -3
b:	.byte 4
c:	.byte 5
.text
.global main

func:
	push {r4, r5, r6, r7, r8, r9, r10, lr}
	
	ldr r4, =a
	ldr r5, =b
	ldr r6, =c
	
	ldrsb r4, [r4]
	ldrsb r5, [r5]
	ldrsb r6, [r6]
	
	mov r10, #0
	
	muls r7, r0, r0	@ax^2
	muls r7, r4, r7	
	
	muls r8, r0, r1	@bxy
	muls r8, r5, r8
	
	adds r9, r7, r8	@ax^2+bxy+c
	adds r10, r9, r6
	
	mov r3, r10
	
	pop {r4, r5, r6, r7, r8, r9, r10, lr}
main:
	
	mov r0, #1	@x
	mov r1, #2	@y
	mov r3, #0	@f
	
	bl func

        @ exit system call
        mov        r7, #1
        swi     0
