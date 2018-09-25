   // THE SUBROUTINE CALLING CONVENTION 1.2
        .text

		.global _start



_start:		
            LDR R0, =RESULT // R0 POINTS TO ADDRESS OF RESULT
		    LDR R1, N  // R1 HOLDS THE NUMBER OF ENTRIES
			LDR R2, =NUMBERS //R2 POINTS TO THE NUMBERS LIST
            PUSH {LR}
            PUSH {R0-R2} // PUSH THE THREE REGISTERS ONTO THE STACK
            
            BL findmax   // BRANCH TOWARDS THE findmax SUBROUTINE
            
            LDR R0, [SP, #0] //get return value from stack
            STR R0,RESULT
            
stop:       B stop

findmax: 
          PUSH {R4-R12}             //    STMDB SP!, {R4-LR} // PART OF SAVING AND RESTORING THE STATE (PUSH R4-R12 ON STACK)
          

         LDR R4, [SP, #36] //HOLD RESULT ADDRESS FROM STACK IN R4
         
       LDR R5, [SP, #40] //load param N from stack into R5
         LDR R6, [SP, #44] //load param NUMBERS from stack into R6
         
         
         LDR R7, [R4] //R7 holds the result VALUE


LOOP:    
         SUBS R5, R5, #1 //DECREMENT N
         BEQ DONE //ONCE 0, GO TO DONE

          LDR R8, [R6], #4 //access the next value of THE NUMBERS ARRAY
	      CMP R7, R8       // IF THE MAX SO FAR, LOOP AGAIN
          BGE LOOP
		  MOV R7, R8       //OTHERWISE, UPDATE THE MAX
          B LOOP           //LOOP AGAIN
          
DONE:
          MOV R0, R7             //MOVE RETURN VALUE INTO R0
          STR R0, [SP, #36]      //Store the result value in place of result address on the stack 
          POP {R4-R12}           //restore the stack state by popping off R4-R12
          BX LR                  //RETURN VALUE TO  THE METHOD That called


RESULT:   .word 0
N:        .word 7
NUMBERS:  .word 4, 5, 3, 6 
          .word 9, 10, 2
          






















RESULT:   .word 0
N:        .word 7
NUMBERS:  .word 4, 5, 3, 6
 .word 9, 10, 2 