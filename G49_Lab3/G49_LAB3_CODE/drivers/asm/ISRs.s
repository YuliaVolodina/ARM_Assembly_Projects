	.text
	
	.global A9_PRIV_TIM_ISR
	.global HPS_GPIO1_ISR
	.global HPS_TIM0_ISR
	.global HPS_TIM1_ISR
	.global HPS_TIM2_ISR
	.global HPS_TIM3_ISR
	.global FPGA_INTERVAL_TIM_ISR
	.global FPGA_PB_KEYS_ISR
	.global FPGA_Audio_ISR
	.global FPGA_PS2_ISR
	.global FPGA_JTAG_ISR
	.global FPGA_IrDA_ISR
	.global FPGA_JP1_ISR
	.global FPGA_JP2_ISR
	.global FPGA_PS2_DUAL_ISR
	
    


    
	.global hps_tim0_int_flag
    .global pb_int_flag
hps_tim0_int_flag:
	.word 0x0

pb_int_flag:
	.word 0x0


A9_PRIV_TIM_ISR:
	BX LR
	
HPS_GPIO1_ISR:
	BX LR
	
HPS_TIM0_ISR:
	
	PUSH {LR}

	MOV R0, #0x1    
	BL HPS_TIM_clear_INT_ASM     // CLEAR INTERUPT FOR TIM0

	LDR R0, =hps_tim0_int_flag    // SET FLAG TO 1
	MOV R1, #1         
	STR R1, [R0]                //SET FLAG TO 1

	POP {LR}
	BX LR
	
HPS_TIM1_ISR:
	BX LR
	
HPS_TIM2_ISR:
	BX LR
	
HPS_TIM3_ISR:
	BX LR
	
FPGA_INTERVAL_TIM_ISR:
	BX LR
	
FPGA_PB_KEYS_ISR:
	
     PUSH { LR}
     
   
   
    BL read_PB_edgecap_ASM  //R0 holds the button being pressed

     POP {LR}
      
    PUSH {LR}
     BL PB_clear_edgecap_ASM // clear edgecap
     POP {LR}

            LDR R1, =pb_int_flag // global variable to return the result 
CHECK_KEY0: MOVS R3, #0x1 
             ANDS R3, R0 // check for KEY0 
             BEQ CHECK_KEY1 
           MOVS R2, #1 
           STR R2, [R1] // return KEY0 value 
            B END_KEY_ISR 
CHECK_KEY1: MOVS R3, #0x2 
            ANDS R3, R0 // check for KEY1 
           BEQ CHECK_KEY2 
          MOVS R2, #2 
          STR R2, [R1] // return KEY1 value 
          B END_KEY_ISR 
CHECK_KEY2: MOVS R3, #0x4 
			ANDS R3, R0 // check for KEY2 
			BEQ IS_KEY3 
			MOVS R2, #3 
			STR R2, [R1] // return KEY2 value 
			B END_KEY_ISR 
IS_KEY3: MOVS R2, #4 
		STR R2, [R1] // return KEY3 value 
END_KEY_ISR: 
          
			
             BX LR
 
     

	//LDR R0, =pb_int_flag    // SET FLAG TO 1
	//MOV R1, #1         
	//STR R1, [R0]   


    




    

	
	
FPGA_Audio_ISR:
	BX LR
	
FPGA_PS2_ISR:
	BX LR
	
FPGA_JTAG_ISR:
	BX LR
	
FPGA_IrDA_ISR:
	BX LR
	
FPGA_JP1_ISR:
	BX LR
	
FPGA_JP2_ISR:
	BX LR
	
FPGA_PS2_DUAL_ISR:
	BX LR
	
	.end
