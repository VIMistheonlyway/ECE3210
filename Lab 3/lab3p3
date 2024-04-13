 .data
string: .ascii  "tOdAyIsAsUnNyDaY"

.text
.global main
main:
        @ Your Program
        
        ldr r0, =string
        
        ldr r1, =0x54 @ascii values for the uppercase letters in hex (T)
        strb r1, [r0, #0]! @increments by two as the address updates each time
        
        ldr r2, =0x44 @D
        strb r2, [r0, #2]!
        
        ldr r3, =0x59 @Y
        strb r3, [r0, #2]!
        
        ldr r4, =0x53 @S
        strb r4, [r0, #2]!
        
        ldr r5, =0x53 @S
        strb r5, [r0, #2]!
        
        ldr r6, =0x4E @N
        strb r6, [r0, #2]!
        
        ldr r7, =0x59 @&
        strb r7, [r0, #2]!
        
        ldr r8, =0x41 @A
        strb r8, [r0, #2]!
        
        @ exit syscall
        mov r7, #1
        swi 0
