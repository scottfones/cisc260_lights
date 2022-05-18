# CISC 260: Programming Assignment - Lights

## Usage

### Part 1 - Clear

```bash
$ as clear.s -o clear.o; as lights.s -o lights.o; ld clear.o lights.o -o clear
$ ./clear
```

### Part 2 - Blue Fill

```bash
$ as part2.s -o part2.o; as lights.s -o lights.o; ld part2.o lights.o -o part2
$ ./part2
```

### Part 3 - Red X

```bash
$ as part3.s -o part3.o; as lights.s -o lights.o; ld part3.o lights.o -o part3
$ ./part3
```

### Part 4 - Purple Initials

```bash
$ as part4.s -o part4.o; as lights.s -o lights.o; ld part4.o lights.o -o part4
$ ./part4
```

## Assignment Overview

### Part 1

Create a program file clear.s that loops through the 64 locations (8x8) setting the 2-byte value at each location to 0.  If you run the above sample program then this program will clear the 2 pixels that were turned on.  In c, your program should look something like this:

```c
openfb(1)
for (int i=0;i<8;i++){
  for (int j=0;j<8;j++){openfb(1)
for (int i=0;i<8;i++){
	for (int j=0;j<8;j++){
		setPixel(I,j,0);
	}
}
closefb()
    setPixel(I,j,0);
  }
}
closefb()
```

### Part 2

Modify the clear program to set the color of all the pixels to blue.  Instead of calling setPixel(I,j,0), call it with a value returned from getColor(0,0,31) for the last parameter.  This modified code should be put in a file part2.s and assembled and linked as above.

### Part 3

Write a program called part3.s that draws a red x across the raspberry pi.  This x should cover the entire screen (i.e. from 0,0 to 7,7 and from 7,0 to 0,7) and should be red in color.  You should NOT do this by brute force but should use a loop to turn on and off the correct pixels.

### Part 4

Write a program called part4.s that turns on the lights that make your initials.  You will have to do this by brute force mostly (although you could use loops to draw straight lines).  So my screen would say GS on it when the program exits.  You should draw this in purple (i.e. red and blue values on).
