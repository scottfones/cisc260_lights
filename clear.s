.global _start
.text
_start:
        #open frame buffer 1
        mov r0,#1
	    bl openfb
	    cmp r0,#0
	    blt done

        #store the clear color in r6
        mov r6,#0

        #initialize counter and end points
        mov r0,#0
        mov r1,#0
        mov r3,#7

        #for loop from [0,64)
loop:   cmp r1,r3
        bgt nline
        bl setPixel
        add r1,r1,#1

        #move down one line of leds or exit if done
nline:  cmp r0,r3
        bgt done
        add r0,r0,#1
        mov r1,#0
        b loop

	    #clean exit
done:   mov r7,#1
	    svc #0
