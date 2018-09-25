         .text
         .equ KEY_DATA, 0xFF200050
          .equ KEY_INT, 0FF200058
         .equ KEY_EDGECAP, 0xFF20005C
         .global read_PB_data_ASM
		 .global PB_data_is_pressed_ASM
		 .global read_PB_edgecap_ASM
		 .global PB_edgecap_is_pressed_ASM
		 .global PB_clear_edgecap_ASM
		 .global enable_PB_INT_ASM
		 .global disable_PB_INT_ASM
        
         
// read the pushbutton data register

read_PB_data_ASM:        
		 LDR R1, =KEY_DATA
         LDR R0, [R1]
         BX LR
         
// return the key being pressed

PB_data_is_pressed_ASM: 
             
            PUSH {LR}
            BL read_PB_data_ASM
            POP {LR}			
    

KEY_0:      MOVS R3, #0x1 
            ANDS R3, R0 // check for KEY0 
			BEQ KEY_1 
			MOVS R2, #0 
			STR R2, [R0] // return KEY0 value 
			B END 
			




KEY_1:      MOVS R3, #0x2 
            ANDS R3, R0 // check for KEY1 
			BEQ KEY_2 
			MOVS R2, #1 
			STR R2, [R0] // return KEY1 value 
			B END


KEY_2:    MOVS R3, #0x4 
          ANDS R3, R0 // check for KEY2 
		  BEQ KEY_3 
		  MOVS R2, #2 
		  STR R2, [R0] // return KEY2 value 
		  B END


KEY_3:    MOVS R2, #3 
          STR R2, [R0] // return KEY3 value 
		  B END
		  
END:      BX LR
             

// read the edgecap register
read_PB_edgecap_ASM:
                   LDR R1, =KEY_EDGECAP
                   LDRB R0, [R1]
                   BX LR
 



// return the key being pressed by reading the edgecap register

PB_edgecap_is_pressed_ASM:

            PUSH {LR}
            BL read_PB_edgecap_ASM
            POP {LR}			
    

EDGE_KEY_0: MOVS R3, #0x1 
            ANDS R3, R0 // check for KEY0 
			BEQ EDGE_KEY_1 
			MOVS R2, #0 
			STR R2, [R0] // return KEY0 value 
			B END 
			




EDGE_KEY_1:      MOVS R3, #0x2 
            ANDS R3, R0 // check for KEY1 
			BEQ EDGE_KEY_2 
			MOVS R2, #2 
			STR R2, [R0] // return KEY1 value 
			B END


EDGE_KEY_2:    MOVS R3, #0x4 
          ANDS R3, R0 // check for KEY2 
		  BEQ EDGE_KEY_3 
		  MOVS R2, #2
		  STR R2, [R0] // return KEY2 value 
		  B END


EDGE_KEY_3:    MOVS R2, #3 
             STR R2, [R0] // return KEY3 value 
		     B EDGE_END
		  
EDGE_END:      BX LR


// clear edgecap by writing any value to it
PB_clear_edgecap_ASM:
                     LDR R1, =KEY_EDGECAP 
					 STR R0, [R1]   //writing any number clears all edgecapture bits
					 BX LR
  

// enable push button interrupts
enable_PB_INT_ASM:
                  LDR R1, =KEY_INT
				  PUSH{LR}
				  BL read_PB_edge
				  POP{LR}
			
enable_KEY_0: MOVS R3, #0x1 
              ANDS R3, R0 // check for KEY0 
			  BEQ enable_KEY_1 
			  MOVS R2, #1 
			  STR R2, [R0] // return KEY0 value 
			  B END 
			




enable_KEY_1:      MOVS R3, #0x2 
            ANDS R3, R0 // check for KEY1 
			BEQ enable_KEY_2 
			MOVS R2, #2 
			STR R2, [R1] // return KEY1 value 
			B END


enable_KEY_2:    MOVS R3, #0x4 
          ANDS R3, R0 // check for KEY2 
		  BEQ enable_KEY_3 
		  MOVS R2, #4 
		  STR R2, [R1] // return KEY2 value 
		  B END


enable_KEY_3:    MOVS R2, #8 
             STR R2, [R1] // return KEY3 value 
		     B enable_END
		  
enable_END:      BX LR



//disable pushbutton interrupts
disable_PB_INT_ASM:  
                       
                  LDR R1, =KEY_INT
				  PUSH{LR}
				  BL read_PB_edge
				  POP{LR}
			
disable_KEY_0: MOVS R3, #0x1 
              ANDS R3, R0 // check for KEY0 
			  BEQ disable_KEY_1 
			  MOVS R2, #14 
			  STR R2, [R1] // return KEY0 value 
			  B END 
			




disable_KEY_1:      MOVS R3, #0x2 
            ANDS R3, R0 // check for KEY1 
			BEQ disable_KEY_2 
			MOVS R2, #13 
			STR R2, [R1] // return KEY1 value 
			B END


disable_KEY_2:    MOVS R3, #0x4 
          ANDS R3, R0 // check for KEY2 
		  BEQ disable_KEY_3 
		  MOVS R2, #11
		  STR R2, [R1] // return KEY2 value 
		  B END


disable_KEY_3:    MOVS R2, #7 
               STR R2, [R1] // return KEY3 value 
		        B disable_END
		  
disable_END:      BX LR



        .end
