.data
fibnoacci :  .byte   1, 1, 0, 0, 0, 0, 0, 0, 0, 0

.text
.global main
main:
    
    ldr r0, =fibnoacci  
    mov r2, #1 @offset the initial value
    
    ldrb r1, [r0], r2 @offset with r2 to get 1, 1, 2, in the registers
    ldrb r2, [r0], r2 @register post index for the loading of the address
    
    add r3, r1, r2
    strb r3, [r0], #1 @immediate post index when storing
    
    add r4, r2, r3
    strb r4, [r0], #1
    
    add r5, r3, r4
    strb r5, [r0], #1
    
    add r6, r4, r5
    strb r6, [r0], #1
    
    add r7, r5, r6
    strb r7, [r0], #1
    
    add r8, r6, r7
    strb r8, [r0], #1
    
    add r9, r7, r8
    strb r9, [r0], #1
    
    add r10, r8, r9
    strb r10, [r0], #1 @fibonacci sequence is incremented to the 10th number
    
        @ exit syscall
        mov r12, #1
        swi 0 
