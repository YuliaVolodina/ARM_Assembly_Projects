
  // THE STACK PROGRAM 1.1

     .text
     .global _start

_start:
       
        LDR R0, N_0  //LOAD THE PARAMETER VALUE AT N_0 TO R0
        LDR R1, N_1 //LOAD THE PARAMETER VALUE AT N_1 TO R1
		LDR R2, N_2 //LOAD THE PARAMETER VALUE AT N_2 TO R2
        LDR SP, =ADDRESS_5 //SP POIBNTS TO THE ADDRESS OF PARAMETER ADDRESS_5 (FOR THE PURPOSE OF INITIALIZING THE STACK POINTER)
        
        
	
       STR R0, [SP, #-4]!  //PUSH R0 ONTO STACK
       STR R1, [SP, #-4]! //PUSH R1 ONTO STACK
       STR R2, [SP, #-4]! //PUSH R2 ONTO STACK

      
       LDMIA SP!, {R0-R2} //POP OFF THE THREE VALUES ON THE STACK INTO THE RESPECTIVE REGISTERS

     // LDR R3, [SP], #4
     // LDR R4, [SP], #4
     // LDR R5, [SP], #4

End: B End


N_0: .word 1
N_1: .word 2
N_2: .word 3

ADDRESS_1: .space 4
ADDRESS_2: .space 4
ADDRESS_3: .space 4
ADDRESS_4: .space 4
ADDRESS_5: .space 0