 	.text
	.equ PS2_DATA, 0xFF200100 
	.global read_PS2_data_ASM

read_PS2_data_ASM:
	PUSH {R1-R5}
     LDR R1, =PS2_DATA // THE REGISTER ADDRESS
	 LDR R4, [R1] //contents of the PS2
     MOV R2, #32768 // BINARY VALUE TO CHECK IF 15TH BIT IS 1
	 AND R3, R4, R2 // IF R3 IS NOT 0, THEN RVALID IS 1
     CMP R3, #0  //if r3 is not 0, it's true
     BGT RVALID_1
     
     MOV R0, #0 //return false
     B END


RVALID_1:
     LDR R1, =PS2_DATA
     //LDR R4, [R0]  // load into R4 the address in char *data // might need []
     LDR R5, [R1]
     STRB R5, [R0] //store the read data from PS2  into the address in char *data
     MOV R0, #1 // return true
END:    POP {R1-R5}
		BX LR
    
