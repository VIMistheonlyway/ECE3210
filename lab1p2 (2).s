.data
num1:	.byte	5
num2:	.byte	0b1010
num3:	.byte	0x0c
num4:	.byte	23
num5:	.byte	0b0101101
num6:	.byte	0x4B
string:   .ascii  "Super!"

.text
.global main
main:

    @ exit syscall
    mov r7, #1
    swi 0
