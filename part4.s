.data
    ROWCNT: .word 7
.global _start
.text
_start:
    #open frame buffer 1
    mov r0,#1
    bl openfb

    #get and store purple color value
    mov r0,#31
    mov r1,#0
    mov r2,#31
    bl getColor
    mov r10,r0

    #sketch
    #0 0 1 2 3 4 5 6 7
    #0 X X X X X X X X
    #1 X       X
    #2 X       X
    #3 X X X X X X X X
    #4       X X
    #5       X X
    #6       X X
    #7 X X X X X

    #initialize counter and end points
    #r0 = i, r1 = j, r2 = color
    mov r0,#0
    mov r1,#0
    mov r2,r10
    ldr r3,=ROWCNT
    ldr r3,[r3]

loop_full_horizontal:
    #for loop from [0,7]
    cmp r0,r3
    bgt next_full_h_line

    #backup values r0, r1
    mov r7,r0
    mov r8,r1

    mov r2,r10
    bl setPixel

    #restore r0, r1, r3
    mov r0,r7
    mov r1,r8
    ldr r3,=ROWCNT
    ldr r3,[r3]

    add r0,r0,#1
    b loop_full_horizontal

next_full_h_line:
    #move down to second horiz line
    cmp r1,#3
    beq full_vertical_setup
    mov r1,#3
    mov r0,#0
    b loop_full_horizontal

full_vertical_setup:
    #initialize vars for vert line
    mov r0,#4
    mov r1,#0
    ldr r3,=ROWCNT
    ldr r3,[r3]

loop_full_vertical:
    #for loop from [0,7]
    cmp r1,r3
    bgt bottom_s_setup

    #backup values r0, r1
    mov r7,r0
    mov r8,r1

    mov r2,r10
    bl setPixel

    #restore r0, r1, r3
    mov r0,r7
    mov r1,r8
    ldr r3,=ROWCNT
    ldr r3,[r3]

    add r1,r1,#1
    b loop_full_vertical

bottom_s_setup:
    mov r0,#0
    mov r1,#7
    mov r2,r10

bottom_s_loop:
    #for loop from [0,3]
    cmp r0,#4
    bgt point_fills

    #backup values r0, r1
    mov r7,r0
    mov r8,r1

    mov r2,r10
    bl setPixel

    #restore r0, r1
    mov r0,r7
    mov r1,r8

    add r0,r0,#1
    b bottom_s_loop

point_fills:
    #fill remaining points

    #top left S
    mov r0,#0
    mov r1,#1
    mov r2,r10
    bl setPixel
    mov r0,#0
    mov r1,#2
    mov r2,r10
    bl setPixel

    #bottom right S
    mov r0,#3
    mov r1,#4
    mov r2,r10
    bl setPixel
    mov r0,#3
    mov r1,#5
    mov r2,r10
    bl setPixel
    mov r0,#3
    mov r1,#6
    mov r2,r10
    bl setPixel

_part4_exit:
    #clean exit
    bl closefb
    mov r7,#1
    svc #0
