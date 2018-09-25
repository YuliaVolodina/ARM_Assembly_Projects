         .text
         .equ HEX_BASE1, 0xFF200020 // address of the displays HEX(0-3)
         .equ HEX_BASE2, 0xFF200030 //address of the displays HEX(4-5)
         .equ N_1, 4                // four hex displays following first address
         .equ N_2, 2                // 2 hex displays following 2nd address
         .equ HEX0, 0x00000001      
         .equ HEX4, 0x00000010
         .global HEX_clear_ASM
         .global HEX_flood_ASM
         .global HEX_write_ASM


// this subroutine clears all of the HEX displays
HEX_clear_ASM:

              PUSH {R1-R6}
              LDR R1, =N_1
              MOV R2, #0
              LDR R3, =HEX_BASE1
              LDR R4, =HEX0
    

loop_1:      CMP R2, R1        // compare 0 to current N
             BGE  clear_rem      // if 0 is greater or equal to current N then return
             
			 ORR R5, R0, R4      // R0 OR R4  determines whether the parameter in R0 corresponds to the current looped HEX display
             CMP R5, R0
             BEQ equal_1   // if the HEX value is equal to current loop value, clear it
shift_1:  LSL R4, R4, #1    // check the next HEX value otherwise
          ADD R2, R2, #1
            B loop_1

equal_1: 	ADD R6, R2, R3
            MOV R5, #0
            STRB R5, [R6]
            B shift_1
         


clear_rem:    LDR R1, =N_2  //proceed to performing the exact same functions as above but for hexes 4-5
              MOV R2, #0
              LDR R3, =HEX_BASE2
              LDR R4, =HEX4
    
loop_clear_rem:    CMP R2, R1  // compare 0 to current N
             BGE  label1      // if 0 is greater or equal to current N then return
             
			 ORR R5, R0, R4 // Input OR HEX0
             CMP R5, R0
             BEQ equal_clear_rem
shift_clear_rem:       LSL R4, R4, #1
            ADD R2, R2, #1
            B loop_clear_rem

equal_clear_rem: 	ADD R6, R2, R3
            MOV R5, #0
            STRB R5, [R6]
            B shift_clear_rem

label1: POP {R1-R6}
        BX LR


		
//proceed to flooding the hexes, performing same functions as above, except filling all of the bits of the 7 segments		

HEX_flood_ASM: 
              PUSH {R1-R5}
              LDR R1, =N_1
              MOV R2, #0
              LDR R3, =HEX_BASE1
              LDR R4, =HEX0
    
loop:        CMP R2, R1  // compare 0 to current N
             BGE  flood_rem     // if 0 is greater or equal to current N then return
             
			 ORR R5, R0, R4 // Input OR HEX0
             CMP R5, R0
             BEQ equal_2
shift:       LSL R4, R4, #1
            ADD R2, R2, #1
            B loop

equal_2: 	ADD R6, R2, R3
            MOV R5, #0x255
            STRB R5, [R6]
            B shift




flood_rem:    LDR R1, =N_2
              MOV R2, #0
              LDR R3, =HEX_BASE2
              LDR R4, =HEX4
    
loop_rem:        CMP R2, R1  // compare 0 to current N
             BGE  loop2     // if 0 is greater or equal to current N then return
             
			 ORR R5, R0, R4 // Input OR HEX0
             CMP R5, R0
             BEQ equal_rem
shift_rem:       LSL R4, R4, #1
            ADD R2, R2, #1
            B loop_rem

equal_rem: 	ADD R6, R2, R3 //R6 holds the byte offset from the register address indicating the HEX #
            MOV R5, #255 // write #255 to fill all of the 7 bits of the display
            STRB R5, [R6] //store value within the provided byte
            B shift_rem


loop2: POP {R1-R5}
       BX LR

	   
// write the value provided by the parameter of the subroutine call within main	   
HEX_write_ASM:


    PUSH {R2-R7,R11}


// a fallthrough function which tests what value has been passed
VAL_0: CMP R1, #0
       BNE VAL_1
       MOV R1, #63
       B DISPLAY
                

VAL_1: CMP R1, #1
       BNE VAL_2
       MOV R1, #0x00000006
       B DISPLAY

VAL_2: CMP R1, #2
       BNE VAL_3
       MOV R1, #91
       B DISPLAY

VAL_3: CMP R1, #3
       BNE VAL_4
       MOV R1, #79
       B DISPLAY

VAL_4:  CMP R1, #4
       BNE VAL_5
       MOV R1, #102
       B DISPLAY

VAL_5:  CMP R1, #5
       BNE VAL_6
       MOV R1, #109
       B DISPLAY

VAL_6:  CMP R1, #6
       BNE VAL_7
       MOV R1, #125
       B DISPLAY


VAL_7:  CMP R1, #7
       BNE VAL_8
       MOV R1, #39
       B DISPLAY


VAL_8:  CMP R1, #8
       BNE VAL_9
       MOV R1, #127
       B DISPLAY


VAL_9:  CMP R1, #9
       BNE VAL_10
       MOV R1, #111
       B DISPLAY


VAL_10: CMP R1, #10
       BNE VAL_11
       MOV R1, #119
       B DISPLAY


VAL_11:  CMP R1, #11
       BNE VAL_12
       MOV R1, #124
       B DISPLAY

VAL_12:  CMP R1, #12
       BNE VAL_13
       MOV R1, #57
       B DISPLAY


VAL_13:  CMP R1, #13
       BNE VAL_14
       MOV R1, #94
       B DISPLAY

VAL_14:  CMP R1, #14
       BNE VAL_15
       MOV R1, #121
       B DISPLAY


VAL_15:  CMP R1, #15
       BXNE LR
       MOV R1, #113
       B DISPLAY              





// Now R1 holds the value to turn on corresponding bits of the 7-segment display
//the following function is almost equivalent to the process of clear and flood, except R1 is written onto corresponding 
//Hex address

DISPLAY:     MOV R11, #0
             LDR R2, =HEX0
             MOV R3, #6
             LDR R6, =HEX_BASE1
             LDR R7, =HEX_BASE2




loop_write: CMP R11, #4
			BGE BASE_2_3
			ORR R5, R0, R2  
			CMP R0, R5
			BEQ write
he_sh3_1:	LSL R2, R2, #1
			ADD R11, R11, #1
			B loop_write
write:		ADD R4, R11, R6
			MOV R5, R1
			STRB R5, [R4]
			B he_sh3_1 

BASE_2_3:	MOV R11, #0
loop_write2:CMP R11, #2
			BGE LABEL
			ORR R5, R0, R2  
			CMP R0, R5
			BEQ write2
he_sh3_2:	LSL R2, R2, #1
			ADD R11, R11, #1
			B loop_write2
write2:		ADD R4, R11, R7
			MOV R5, R1   //R1 holds the value to be written
			STRB R5, [R4]
			B he_sh3_2 

LABEL:		POP {R2-R7,R11}
			BX LR





  .end
