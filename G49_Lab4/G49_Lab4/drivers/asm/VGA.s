
	.text
	.equ PIXEL_BASE, 0xC8000000
    .equ BUFFER_BASE, 0x0
	.equ CHAR_BASE, 0xC9000000
     .equ value, 638
     .equ value_2, 0x13F
     .global VGA_clear_pixelbuff_ASM
     .global VGA_clear_charbuff_ASM
		.global VGA_write_char_ASM
		.global VGA_write_byte_ASM
 		.global	VGA_draw_point_ASM


VGA_clear_pixelbuff_ASM:
   PUSH {R0-R6}
	LDR R0, =PIXEL_BASE
    MOV R1, #0 // X STARTS WITH 0
	
LOOP_PIXEL_X: 
	ADD R1, R1, #2 //INCREMENT X BY 1
    LDR R6, =value
	CMP R1, R6 
    BGT RESET_X_Y_2   //CLEAR_CHAR_X0 //branch to end if x value is greater than 79	
    MOV R2, #0 // Y STARTS WITH 0
    B LOOP_PIXEL_Y

LOOP_PIXEL_Y:  
    PUSH {LR}
    BL CLEAR_PIXEL
    POP {LR}
    ADD R2, R2, #1024
    CMP R2, #262144 //is it too big????????
    BGT LOOP_PIXEL_X
	B LOOP_PIXEL_Y

CLEAR_PIXEL:
         ADD R3, R1, R2 //we add the x and y coordinates
         ADD R4, R0, R3 // add the x and y total value to the base    
         MOV R5, #0 //CLEAR    
         STRH R5, [R4]  //STORE THE HALF WORD
         BX LR

RESET_X_Y_2: 
    MOV R1, #0 // X EQUALS 0
    MOV R2, #0 // Y EQUALS 0

CLEAR_PIXEL_X0:
	//MOV R1, #0 // X EQUALS 0
    //MOV R2, #0 // Y EQUALS 0
    PUSH {LR}
    BL CLEAR_PIXEL
    POP {LR}
    
    ADD R2, R2, #1024
    CMP R2, #262144 // is it too big???
    BGT END_2
	B CLEAR_PIXEL_X0

END_6: POP {R0-R6}
       BX LR
























VGA_clear_charbuff_ASM:
    PUSH {R0-R5}
	LDR R0, =CHAR_BASE
    MOV R1, #0 // X STARTS WITH 0
    
    
	

LOOP_CHAR_X: 
	ADD R1, R1, #1 //INCREMENT X BY 1
	CMP R1, #79 
    BGT RESET_X_Y   //CLEAR_CHAR_X0 //branch to end if x value is greater than 79	
    MOV R2, #0// Y STARTS WITH 0
    B LOOP_CHAR_Y
	

LOOP_CHAR_Y:  
    PUSH {LR}
    BL CLEAR_CHAR
    POP {LR}
    ADD R2, R2, #128
    CMP R2, #7552 //is it too big????????
    BGT LOOP_CHAR_X
	B LOOP_CHAR_Y

CLEAR_CHAR:
         ADD R3, R1, R2 //we add the x and y coordinates
         ADD R4, R0, R3 // add the x and y total value to the base    
         MOV R5, #0 //CLEAR    
         STRB R5, [R4]  //BYTE OR NOT?????????????
         BX LR


RESET_X_Y: 
    MOV R1, #0 // X EQUALS 0
    MOV R2, #0 // Y EQUALS 0
CLEAR_CHAR_X0:
	//MOV R1, #0 // X EQUALS 0
    //MOV R2, #0 // Y EQUALS 0
    PUSH {LR}
    BL CLEAR_CHAR
    POP {LR}
    ADD R2, R2, #128
    CMP R2, #7552 // is it too big???
    BGT END_2
	B CLEAR_CHAR_X0
    

END_2: POP {R0-R5}
       BX LR




















VGA_write_char_ASM:
    PUSH {R0, R1, R2, R4, R5}
	//PUSH {R3-R5}
	//check that 0 <= x <= 79
    CMP R0, #0
     BLT END_3 //if x < 0 go to END 
     CMP R0, #79
     BGT END_3 //if x>79 go the END

     //check that 0 <= y <= 59
     CMP R1, #0
     BLT END_3 //if y < 0 go to END 
      CMP R1, #59
      BGT END_3 //if y > 59 go the END

//store the char into the location

	
    //MOV R3, #128
   // MUL R1, R1, R3 //Y offset
    LSL R1, R1, #7
    ADD R5, R0, R1  // x and y together
    LDR R4, =CHAR_BASE
    ADD R5, R5, R4 //adding the x, y, and base address where the char will be stores
    STRB R2, [R5] //store R2 (the char) into R5 //might need []
    
END_3:    POP {R0, R1, R2, R4, R5}
          BX LR

VGA_write_byte_ASM:
    PUSH {R0-R2, R5-R9}
	//check that 0 <= x <= 78
    CMP R0, #0
    BLT END_4 //if x < 0 go to END 
    CMP R0, #78
    BGT END_4 //if x>78 go the END

//check that 0 <= y <= 59
    CMP R1, #0
    BLT END_4 //if y < 0 go to END 
    CMP R1, #59
    BGT END_4 //if y > 59 go the END

//store the char into the location
BYTE_STORE:
   // MOV R3, #128
    //MUL R1, R1, R3 //Y offset
    LSL R1, R1, #7 // Y is offset by 7
    ADD R5, R0, R1 
    LDR R9, =CHAR_BASE
    ADD R5, R5, R9 // FIRST ADRESS //adding the x, y, and base address where the char will be stores
    ADD R8, R5, #1 //SECOND ADDRESSSSSSSSSSSSSSS
	//AND R6, R2, #0xF0 //get the first char
    LSR R6, R2, #4 //shift the char so that it is a value between 0 and 15
	PUSH {LR}
	BL ASCII_1
	POP {LR}
    AND R7, R2, #0x0F //get the second char, its a value between 0 and 15
	PUSH {LR}
	BL ASCII_2
	POP {LR}
	STRB R6, [R5] //MIGHT NEED []
	STRB R7, [R8] //MIGHT NEED []

ASCII_1:
	CMP R6, #10
	BLT NUMBER_1
	ADD R6, R6, #55
	B END_ASCII_1

ASCII_2:
	CMP R7, #10
	BLT NUMBER_2
	ADD R7, R7, #55
	B END_ASCII_2

NUMBER_1:
	ADD R6, R6, #48
	B END_ASCII_1

NUMBER_2: 
	ADD R7, R7, #48	
	B END_ASCII_2

END_ASCII_1:
	BX LR

END_ASCII_2:
	BX LR

END_4:	 POP {R0-R2, R5-R9}
       BX LR








VGA_draw_point_ASM:
    PUSH {R0, R1, R2, R4, R5, R6}
	//check that 0 <= x <= 319
    CMP R0, #0
     BLT END_5 //if x < 0 go to END 
     LDR R6, =value_2
     CMP R0, R6
     BGT END_5 //if x>79 go the END

     //check that 0 <= y <= 239
     CMP R1, #0
     BLT END_5 //if y < 0 go to END 
      CMP R1, #239
      BGT END_5 //if y > 59 go the END

//store the char into the location
	LSL R0, R0, #1
    LSL R1, R1, #10
    ADD R5, R0, R1  // x and y together
    LDR R4, =PIXEL_BASE
    ADD R5, R5, R4 //adding the x, y, and base address where the char will be stores
    STRH R2, [R5] //store R2 (the char) into R5 //might need []
    
END_5:    POP {R0, R1, R2, R4, R5, R6}
          BX LR
