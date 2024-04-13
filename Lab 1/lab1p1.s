.data
message:	.ascii  "Hello World!\n"

.text
.global main
main:
    @ write syscall
    mov r0, #1          @ For stdout
    ldr r1, =message    @ buffer is loaded with message
    mov r2, #13         @ count is the length of message
    mov r7, #4          @ write is syscall 4
    swi 0               @ interrupt
	
    @ exit syscall
    mov r7, #1
    swi 0
