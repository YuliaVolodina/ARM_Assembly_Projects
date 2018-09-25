#include <stdio.h>

include "./drivers/inc/int_setup.h"
#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/ISRs.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/HPS_TIM.h"




  
//Polling
    int count0 = 0;
	int count1 = 0;
	int count2 = 0;
	int count3 = 0;
	int count4 = 0;
	int count5 = 0;


void runwatch();
int main() {

  
	

	HPS_TIM_config_t hps_tim;

	hps_tim.tim = TIM0 | TIM1;
	hps_tim.timeout = 1000000;
	hps_tim.LD_en = 0;
	hps_tim.INT_en = 1;
	hps_tim.enable = 1;

	HPS_TIM_config_ASM(&hps_tim);
    
    
     int isRun = 0;

      while(1) {
   
     
      

   if(read_PB_data_ASM() == 1) {
        isRun = 1;
    }
    if(read_PB_data_ASM() == 2) {
        isRun = 0;
    }
   
    if(read_PB_data_ASM()  == 4) {
        

    	    int count0 = 0;
    		int count1 = 0;
    		int count2 = 0;
    		int count3 = 0;
    		int count4 = 0;
    		int count5 = 0
      HEX_write_ASM( HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5 , 0 );
      isRun = 0;
     
     
   }

      if (isRun) {
       runwatch();
    
  }
}
  return 0;
}
	
	void runwatch() {
		        HEX_clear_ASM(HEX1);
				HEX_write_ASM(HEX0, count0);
				HEX_write_ASM(HEX1, count1);
				HEX_write_ASM(HEX2, count2);
				HEX_write_ASM(HEX3, count3);
				HEX_write_ASM(HEX4, count4);
				HEX_write_ASM(HEX5, count5);

		if(HPS_TIM_read_INT_ASM(TIM0)) {
			HPS_TIM_clear_INT_ASM(TIM0); 
			if(++count0 == 10){
							count0 = 0;
							count1++;
			                
			 					if(count1 == 10) {
			                        count1 = 0;
			                        count2++;
			                        
			                   			if(count2 == 10) {
											count2 = 0;
											count3++;
										
			                                 if(count3 == 6) {
			                                    count3 = 0;
												count4++;
												
													if(count4 == 10) {
			                                            count4 = 0;
														count5++;
			                                       
			                                              if(count5 == 6) { 
																count5 = 0;
			                                                    count0=0;
																
			                                                 } HEX_write_ASM(HEX5, count5);
						                    } HEX_write_ASM(HEX4, count4);
			                         } HEX_write_ASM(HEX3, count3);
			                  } HEX_write_ASM(HEX2, count2);
			              }  HEX_write_ASM(HEX1, count1);
			       } HEX_write_ASM(HEX0, count0);
			     
     
}

	return 0;
}
//END OF POLLING




 // PROGRAM IMPLEMENTING INTERRUPTS


    int count0 = 0;
	int count1 = 0;
	int count2 = 0;
	int count3 = 0;
	int count4 = 0;
	int count5 = 0;


void runwatch();
int main() {

  
	 int_setup(2, (int []) { 73, 199});

	HPS_TIM_config_t hps_tim;

	hps_tim.tim = TIM0;
	hps_tim.timeout = 1000000;
	hps_tim.LD_en = 0;
	hps_tim.INT_en = 1;
	hps_tim.enable = 1;

	HPS_TIM_config_ASM(&hps_tim);
    CONFIG_KEYS();
    


      while(1) {
   
      
      int isRun = 0;

   if(pb_int_flag == 1) {
        isRun = 1;
    }
    if(pb_int_flag == 2) {
        isRun = 0;
    }
   
    if(pb_int_flag == 3) {
        

	 count0 = 0;
	 count1 = 0;
	 count2 = 0;
	 count3 = 0;
	 count4 = 0;
	 count5 = 0;
      HEX_write_ASM( HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5 , 0 );
      
     
     
   }

      if (isRun) {
       runwatch();
    
  }
}
  return 0;
}
	
	void runwatch() {
        HEX_clear_ASM(HEX1);
		HEX_write_ASM(HEX0, count0);
		HEX_write_ASM(HEX1, count1);
		HEX_write_ASM(HEX2, count2);
		HEX_write_ASM(HEX3, count3);
		HEX_write_ASM(HEX4, count4);
		HEX_write_ASM(HEX5, count5);

		if(hps_tim0_int_flag) {
			hps_tim0_int_flag = 0;
			if(++count0 == 10){
				count0 = 0;
				count1++;
                
 					if(count1 == 10) {
                        count1 = 0;
                        count2++;
                        
                   			if(count2 == 10) {
								count2 = 0;
								count3++;
							
                                 if(count3 == 6) {
                                    count3 = 0;
									count4++;
									
										if(count4 == 10) {
                                            count4 = 0;
											count5++;
                                       
                                              if(count5 == 6) { 
													count5 = 0;
                                                    count0=0;
													
                                                 } HEX_write_ASM(HEX5, count5);
			                    } HEX_write_ASM(HEX4, count4);
                         } HEX_write_ASM(HEX3, count3);
                  } HEX_write_ASM(HEX2, count2);
              }  HEX_write_ASM(HEX1, count1);
       } HEX_write_ASM(HEX0, count0);
     
     
}

	return 0;
}

//^ end of program implementing interrupts


	
//example for timers from the lab 
 	int main() {
	int count0 = 0, count1 = 0, count2 = 0, count3 = 0;

	HPS_TIM_config_t hps_tim;

	hps_tim.tim = TIM0|TIM1|TIM2|TIM3;
	hps_tim.timeout = 1000000;
	hps_tim.LD_en = 0;
	hps_tim.INT_en = 1;
	hps_tim.enable = 1;

	HPS_TIM_config_ASM(&hps_tim);
	
	while(1) {
		HEX_write_ASM(HEX0, count0);
		HEX_write_ASM(HEX1, count1);
		HEX_write_ASM(HEX2, count2);
		HEX_write_ASM(HEX3, count3);
		if(HPS_TIM_read_INT_ASM(TIM0)) {
			HPS_TIM_clear_INT_ASM(TIM0);
			if(++count0 == 16){
				count0 = 0;
			}
			HEX_write_ASM(HEX0, count0);
		}

		if(HPS_TIM_read_INT_ASM(TIM1)) {
			HPS_TIM_clear_INT_ASM(TIM1);
			if(++count1 == 16){
				count1 = 0;
			}
			HEX_write_ASM(HEX1, count1);
		}

		if(HPS_TIM_read_INT_ASM(TIM2)) {
			HPS_TIM_clear_INT_ASM(TIM2);
			if(++count2 == 16){
				count2 = 0;
			}
			HEX_write_ASM(HEX2, count2);
		}

		if(HPS_TIM_read_INT_ASM(TIM3)) {
			HPS_TIM_clear_INT_ASM(TIM3);
			if(++count3 == 16){
				count3 = 0;
			}
			HEX_write_ASM(HEX3, count3);
		}
	}
	return 0;
}

//end of ^program


//THE FIRST PART WITH LED AND SWITCHES
int main() {


  while(1) {

write_LEDs_ASM(read_slider_switches_ASM());

}
 return 0;
}

//end of first part








// use pushbuttons to print slider switch values
int main() {

HEX_flood_ASM(HEX4|HEX5);
HEX_clear_ASM(HEX0 | HEX1 | HEX2 | HEX3);
   
 while(1) {

//write_LEDs_ASM(read_slider_switches_ASM());



if (read_slider_switches_ASM()>= 512) {

  HEX_clear_ASM(HEX0| HEX1| HEX2|HEX3);
}
 else if (read_PB_data_ASM() == 1){
  HEX_write_ASM(HEX0, read_slider_switches_ASM());
}
 else if (read_PB_data_ASM() == 2) {
  HEX_write_ASM(HEX1, read_slider_switches_ASM());

}
  else if (read_PB_data_ASM() == 4) {
  HEX_write_ASM(HEX2, read_slider_switches_ASM());
}
 else if (read_PB_data_ASM()== 8) {
        
    HEX_write_ASM(HEX3, read_slider_switches_ASM());
}


      
}


 return 0;

}


