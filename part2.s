.data
    ROWCNT: .word 7
.global _start
.text
_start:
        #open frame buffer 1
        mov r0,#1
	    bl openfb
	    cmp r0,#0
	    blt _sexit

        #initialize counter and end points
        #r0 = i, r1 = j, r2 = color
        mov r0,#0
        mov r1,#0
        mov r2,#0
        ldr r3,=ROWCNT
        ldr r3,[r3]

        #for loop from [0,7]
loop:   cmp r1,r3
        bgt nline

        #backup values r0, r1
        mov r7,r0
        mov r8,r1

        #getColor(0,0,31)
        mov r0,#0
        mov r1,#0
        mov r2,#31
        bl getColor
	    mov r6,r0

        #setColor(i,j,color)
        mov r0,r7
        mov r1,r8
        mov r2,r6
        bl setPixel

        #restore iter counts
        mov r0,r7
        mov r1,r8
        ldr r3,=ROWCNT
        ldr r3,[r3]

        #increment j
        add r1,r1,#1
        b loop

        #move down one line of leds [0,7) or exit if done
nline:  cmp r0,r3
        beq _sexit
        add r0,r0,#1
        mov r1,#0
        b loop

	    #clean exit
_sexit: bl closefb
        mov r7,#1
	    svc #0
