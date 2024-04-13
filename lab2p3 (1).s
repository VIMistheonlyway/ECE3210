.data

string: .ascii "My name is **!\n"

.text
.global main

main:

	ldr r0, =string

	ldr r1, =69 @69 in ascii is E

	ldr r2, =65 @65 in ascii is A. Hoping this works
	
	strb r1, [r0, #11]
	
	mov r3, #12 @the address of the second asterisk in r3
	
	strb r2, [r0, r3] @register offset to store the value of r2, into r0 and offset it to r3
	

    @ exit syscall
    mov r7, #1
    swi 0
