.data 

x:	.word 0b11011010 

y:	.word 4 @width 

z: 	.word 8@length 

 

.text 

.global main 

main: 

ldr r0, =x  

ldr r1, [r0] 	@theconstant that we want to clear 

 

ldr r2, =y 

ldr r3, [r2] 	@value of the offset 

 

ldr r4, =z 

ldr r5, [r4] 	@width of the register 

 

lsl r6, r1, r3 	@storing the values with the offset 

mvn r7, r6 	@negating the lsl and comparing with the original 

and r8, r7, r1 @comparison into the new register 

@exit syscal 

mov r10, #1 

swi 0 
