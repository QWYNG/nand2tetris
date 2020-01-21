// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
@i
M=0

(WHITE_LOOP)
    @KBD
    D=M
    @RESET_BLACK
    D;JGT

    @i
    D=M
    @8192 // 16ビット幅で横は512ビット縦は256
    D=D-A
    @RESET_WHITE
    D;JGE

    @i
    D=M
    @SCREEN
    A=A+D
    M=0
    @i
    M=D+1
    @WHITE_LOOP
    0; JMP

(RESET_WHITE)
    @i
    M=0
    @WHITE_LOOP
    0;JMP

(BLACK_LOOP)
    @KBD
    D=M
    @RESET_WHITE
    D;JEQ

    @i
    D=M
    @8192
    D=D-A
    @RESET_BLACK
    D;JGE

    @i
    D=M
    @SCREEN
    A=A+D
    M=1 //ここなんで-1にさせると全ビット黒くなるのかわからん
    @i
    M=D+1
    @BLACK_LOOP
    0;JMP

(RESET_BLACK)
    @i
    M=0
    @BLACK_LOOP
    0;JMP
