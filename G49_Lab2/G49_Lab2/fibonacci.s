         

//FIBONACCI
    .text
    .global _start

_start: 
     
       LDR R0, N //LOAD THE VALUE OF N INTO R0
       PUSH {R0, LR} //PUSH THIS VALUE AND LR ON THE STACK
       BL fibonacci   //CALL fibonacci subroutine
       B END


fibonacci:
         
          CMP R0, #1 // IF THE N IS EITHER 0 OR 1, GO TO RESULT AND RETURN 1
          BLE result
          B recursion
          //POP {LR}    //LDR LR, [SP], #4 //pop LR 
          //BX LR
result: 
           MOV R0, #1  // LOAD #1 INRO R0
           BX LR //RETURN THE VALUE
             

recursion: 
         PUSH {LR} // PUSH LR
         PUSH {R0} //PUSH ANOTHER COPY OF THE N
          SUB R0, R0, #1 //FIND N-1
          BL fibonacci  //PERFORM FIBONACCI ON N-1
          POP {R1} // POP THE SAVED N VALUE INTO R1
         PUSH {R0} // PUSH FIBONACCI OF N-1 ONTO THE STACK
          SUB R0, R1, #2    //FIND THE VALUE OF N-2 AND SAVE IT IN R0 TO PERFORM FIBONACCI ON IT 
          BL fibonacci
          POP {R1}   // POP OFF FIBONACCI ( N-1 ) INTO R1
          ADD R0, R1, R0 //ADD FIBONACCI (N-1) AND FIBONACCI (N-2) AND STORE IN R0
          POP {LR}   // POP OFF THE LR
          BX LR      //RETURN TO THE METHOD THAT CALLED 
          
          
END: B END
       

N: .word 6
