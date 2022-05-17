.data
    RCNT: .word 7
.global _start
.text
_start:
    #open frame buffer 1
    mov r0,#1
    bl openfb

    #initialize counter and end points
    #r0 = row, r1 = column, r2 = color
    mov r0,#0
    mov r1,#0
    mov r2,#0
    ldr r3,=RCNT
    ldr r3,[r3]

loop:
    #for loop from [0,7]
    cmp r1,r3
    bgt nline
    mov r7,r0
    mov r8,r1
    mov r2,r6
    bl setPixel
    mov r0,r7
    mov r1,r8
    mov r2,#0
    ldr r3,=RCNT
    ldr r3,[r3]
    add r1,r1,#1
    b loop

nline:
    #move down one line of leds [0,7) or exit if done
    cmp r0,r3
    beq _clear_exit
    add r0,r0,#1
    mov r1,#0
    b loop

_clear_exit:
    #clean exit
    bl closefb
    mov r7,#1
    svc #0
