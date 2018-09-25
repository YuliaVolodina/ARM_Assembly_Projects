		
		.text
		.equ TIM, 0x00000001   //value of the first timer
		
         POINT:	.word 0xFFC08000, 0xFFC09000, 0xFFD00000, 0xFFD01000 //adresses of the 4 timers


	
	.global HPS_TIM_config_ASM
	.global HPS_TIM_read_INT_ASM
	.global HPS_TIM_clear_INT_ASM


// configure the timers
HPS_TIM_config_ASM:	
			PUSH {R1-R11}
									
			LDR R1, [R0] 			// R1: holds the value of the parameter within the adress of the passed pointer
			LDR R2, =TIM  	        // R2: hot encoded value to compare to R1
			MOV R3, #4			    // R3: number of timers
			MOV R4, #0				// R4: index of loop
			LDR R6, =POINT			// R6: address of timer to begin looping from

LOOP_CONFIG:CMP R4, R3      
			BEQ DONE
			ORR R5, R1, R2  		// R1 OR R2 to determine if passed pointer is equal to pointer value in current loop
			CMP R1, R5
			BEQ CONFIG_TIMER

SHIFT:		LSL R2, R2, #1          //shift the TIM to go on checking second timer
			ADD R4, R4, #1
			B LOOP_CONFIG			

DONE: 	    POP {R1-R11}
			BX LR				
	
CONFIG_TIMER:
			LDR R7, [R6, R4, LSL #2]		// calculate adress of the determined timer
			MOV R8, #0				        
			STR R8, [R7, #0x8]		        // write 0 to the timer register to configure
			CMP R4, #1                       
			BLE SET_100MHZ                   // if the timer number is 0 or 1, it runs 100mHz
			B SET_25MHZ
CT_RETURN:	STR R8, [R7]			// write to timer load register
           LDR R8, [R0, #8]        //get the LD_en aka the I
            LSL R8, R8, #2
            LDR R9, [R0, #12]      //get the INT_en aka the M
            LSL R9, R9, #1
            LDR R10, [R0, #16]      //get the enable aka the E
            ORR R11, R8, R9         //get into R11 I and M
            ORR R11, R11, R10       //get into R11 all three bits
			MOV R8, #0b011			// I(int mask) = 0, M(mode) = 1, E(enable) = 1
			STR R11, [R7, #0x8]		// write to timer control register
			B SHIFT

SET_100MHZ:
			//LDR R8, =100000000		// period = 1/(100 MHz)x(100x10^6) = 1 sec 
			
            LDR R8, = 1000000
			B CT_RETURN
SET_25MHZ:   
			LDR R8, =25000000		// period = 1/(25 MHz)x(25x10^6) = 1 sec
			B CT_RETURN




//This function reads multiple timers passed
HPS_TIM_read_INT_ASM:
			PUSH {R1-R7}
			LDR R2, =TIM 	    // value to begin comparison
			MOV R3, #4			// R3: number of timers
			MOV R4, #0			// R4: index of loop
			LDR R6, =POINT	    // R6: address of timers 
LOOP_READ:	ORR R5, R0, R2      //find the desired timer
			CMP R0, R5
			BEQ READ_TIMER       //read the timer 
			LSL R2, R2, #1      // check next timer
			ADD R4, R4, #1
			B LOOP_READ				

READ_TIMER:	LDR R7, [R6, R4, LSL #2]		
			LDR R0, [R7, #0x10]	     //R0 reads the value of timer
			POP {R1-R7}
			BX LR
	

// clear the timer
HPS_TIM_clear_INT_ASM:
			PUSH {R1-R8}
			LDR R2, =TIM  	  
			MOV R3, #4			// R3: number of timers
			MOV R4, #0				// R4: index of loop
			LDR R6, =POINT		// R6: address of timers in a word
LOOP_CLEAR:	CMP R4, R3
			BEQ END
			ORR R5, R0, R2  		// R5: result of or R1 and R2
			CMP R0, R5
			BEQ CLEAR_TIMER
CLEAR_SHIFT:			
			LSL R2, R2, #1
			ADD R4, R4, #1
			B LOOP_CLEAR			

CLEAR_TIMER:LDR R7, [R6, R4, LSL #2]		// R7: address of timer
			LDR R8, [R7, #0xC]		// R8: read the value of F which clears F and S
			MOV R8, #0
			STR R8, [R7, #0xC] 
			STR R8, [R7, #0x10]
			B CLEAR_SHIFT

END:	    POP {R1-R8}
			BX LR
		
	.end
