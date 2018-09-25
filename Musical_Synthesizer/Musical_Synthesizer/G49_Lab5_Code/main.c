#include "./drivers/inc/vga.h"
#include "./drivers/inc/ISRs.h"
#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/audio.h"
#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/int_setup.h"
#include "./drivers/inc/wavetable.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/ps2_keyboard.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/slider_switches.h"
#include <math.h>


//1 Make Waves
//takes as input Frequency and time t to inrement by
//we didn't do this right, frequency can be/is a double


	double make_wave(double frequency, double t, int amplitude) {
    
    double index;
    double signal;
	index = ((int)(frequency*t))%48000;
	int ceil;
	int floor;
	int intIndex = (int) index;
	floor = intIndex;
	ceil = floor +1;

		if(intIndex - index != 0.00){
		 signal = amplitude*((ceil - index) * sine[floor] + (index - floor) * sine[ceil]);
		}else{
		 signal = amplitude*sine[intIndex];
		}
             //return signal;
		return signal;

     }

/*
int main () {


 int_setup(1, (int []) {199});

	HPS_TIM_config_t hps_tim;

	hps_tim.tim = TIM0;
	hps_tim.timeout = 1000000;
	hps_tim.LD_en = 0;
	hps_tim.INT_en = 1;
	hps_tim.enable = 1;

	HPS_TIM_config_ASM(&hps_tim);

	double signal = 0;
    double t = 0;

    while(1) {
	if ( hps_tim0_int_flag) {
			t++;

		}	

     
		signal = make_wave(130.813, t, 100);

		audio_write_data_ASM(signal, signal);
}

}
*/


  


//2 Control Waves
int main() {

	VGA_clear_pixelbuff_ASM();

	int_setup(3, (int []) {199,200, 201});

	HPS_TIM_config_t hps_tim;

	hps_tim.tim = TIM0;
	hps_tim.timeout = 20.83;
	hps_tim.LD_en = 1;
	hps_tim.INT_en = 1;
	hps_tim.enable = 1;

	HPS_TIM_config_ASM(&hps_tim);

	
	HPS_TIM_config_t hps_tim1;

	hps_tim1.tim = TIM1;
	hps_tim1.timeout = 100;
	hps_tim1.LD_en = 1;
	hps_tim1.INT_en = 1;
	hps_tim1.enable = 1;

	HPS_TIM_config_ASM(&hps_tim1);

	
	HPS_TIM_config_t hps_tim2;

	hps_tim2.tim = TIM2;
	hps_tim2.timeout = 20.83;
	hps_tim2.LD_en = 1;
	hps_tim2.INT_en = 1;
	hps_tim2.enable = 1;

	HPS_TIM_config_ASM(&hps_tim2);
    
	
	char *data;
	int a = 0;
	int s = 0;
	int d = 0;
	int f = 0;
	int j = 0;
	int k = 0;
	int l = 0;
	int p = 0; //semicolon
	int v = 0;
	int h = 1;

	double signal = 0;
	int breakCode = 0;
	double t = 0;
	int x = 0;
	int y =0;
	int pixelHeight[320];
	int horizontalPixelHeight[240];
	int volume =5;

	while (1) { 
   
		if ( hps_tim0_int_flag1) {
				hps_tim0_int_flag1 = 0;
			
			if (read_PS2_data_ASM(data)){

   				if (*data == 0x1C) {
           			if (breakCode) {
                 		a = 0;
                 		breakCode = 0;
           			}else{a = 1;}
				}
	
				if (*data == 0x1B) {
         			if (breakCode){
						s = 0;
						breakCode = 0; 
					}else{s =1;}
      			}
     
				if (*data == 0x23) {
        			if ( breakCode){
						d = 0;
						breakCode = 0;
					} else {d = 1;}
				}

				if (*data == 0x2B) {
         			if ( breakCode){
						f = 0;
						breakCode = 0;
					}else{f =1;}
				}

				if (*data == 0x3B) {
        			if (breakCode){
						j = 0;
						breakCode = 0;
					}else{j =1;}
				}

				if (*data == 0x42) {
					if(breakCode) {
						k = 0;
						breakCode = 0;
					}else{k =1;}
				}

				if (*data == 0x4B) {
      			 	if ( breakCode) {
						l = 0;
						breakCode = 0;
					}else{l = 1;}
				}
	
				if (*data == 0x4C) {
					if (breakCode){
						p = 0;
						breakCode = 0;
					}else{p = 1;}
				}

				if (*data == 0x3A) {
					if (breakCode){
					if(volume < 100){volume += 5;}
					breakCode = 0;
					}
				}

				if (*data == 0x31) {
					if (breakCode){
					if (volume > 0){volume -= 5;}
					breakCode = 0;
					}
				}

				if (*data == 0x33) {//make the vga output horiztonal
						if (breakCode){
								h = 1;
								v = 0;
						VGA_clear_pixelbuff_ASM();
						breakCode = 0;
						}
				}

				if (*data == 0x2A) {//make the VGA output vertical
						if (breakCode){
								h = 0;
								v = 1;
						VGA_clear_pixelbuff_ASM();
						breakCode = 0;
						}
				}


   				 if (*data == 0xF0) {
					breakCode = 1; 
					}
				}	
			}

			
	signal = 0;

	if (a) {signal = signal + make_wave(130.813, t, volume);} //add lower C to signal
	if (s) {signal = signal + make_wave(146.832, t, volume);} //add D to signal
	if (d) {signal = signal + make_wave(164.814, t, volume);} //add E to signal
	if (f) {signal = signal + make_wave(174.614, t, volume);} //add F to signal
	if (j) {signal = signal + make_wave(196.000, t, volume);} //add G to signal
	if (k) {signal = signal + make_wave(220.000, t, volume);} //add A to signal
	if (l) {signal = signal + make_wave(246.942, t, volume);} //add B to signal
	if (p) {signal = signal + make_wave(261.626, t, volume);} //add upper C to signal
	
	if( hps_tim0_int_flag) {
		 //hps_tim0_int_flag = 0;
    		if( audio_write_data_ASM(signal, signal));
			t++;
	}


	if (hps_tim0_int_flag2) {
		hps_tim0_int_flag2 = 0;

		if(h){
			if((int) (t/9)%320 == x){
   			pixelHeight[x]=  (int)(signal/0x7fffff) +120; //smoosh the signal
			if(x < 53){VGA_draw_point_ASM(x, pixelHeight[x], 0xF800);} //Write the color at the pixel height RED
			else if(x < 106){VGA_draw_point_ASM(x, pixelHeight[x], 0xFD20);} //Write the color at the pixel height ORANGE
			else if(x < 159){VGA_draw_point_ASM(x, pixelHeight[x], 0xFFE0);} //Write the color at the pixel height YELLOW
			else if(x < 212){VGA_draw_point_ASM(x, pixelHeight[x], 0x07E0);} //Write the color at the pixel height GREEN
			else if(x < 265){VGA_draw_point_ASM(x, pixelHeight[x], 0x001F);} //Write the color at the pixel height BLUE
			else{VGA_draw_point_ASM(x, pixelHeight[x], 0x680F);} //Write the color at the pixel height PURPLE
		
			VGA_draw_point_ASM(x+1, pixelHeight[x+1], 0); //clear the next line
			x++;
		

				if (x == 320) {
				VGA_draw_point_ASM(0, pixelHeight[0], 0);
     			x=0;
				}   
			}
 		}


		if(v){
			if((int) (t/10)%240 == x){
   			horizontalPixelHeight[x]=  (int)(signal/0x7fffff) +160; //smoosh the signal
			if(x < 40){VGA_draw_point_ASM(horizontalPixelHeight[x], x, 0xF800);} //Write the color at the pixel height RED
			else if(x < 80){VGA_draw_point_ASM(horizontalPixelHeight[x], x, 0xFD20);} //Write the color at the pixel height ORANGE
			else if(x < 120){VGA_draw_point_ASM(horizontalPixelHeight[x], x, 0xFFE0);} //Write the color at the pixel height YELLOW
			else if(x < 160){VGA_draw_point_ASM(horizontalPixelHeight[x], x, 0x07E0);} //Write the color at the pixel height GREEN
			else if(x < 200){VGA_draw_point_ASM(horizontalPixelHeight[x], x, 0x001F);} //Write the color at the pixel height BLUE
			else{VGA_draw_point_ASM(horizontalPixelHeight[x], x, 0x680F);} //Write the color at the pixel height PURPLE
		
			VGA_draw_point_ASM(horizontalPixelHeight[x+1], x + 1, 0); //clear the next line
			x++;

				if (x == 240) {
				VGA_draw_point_ASM(horizontalPixelHeight[0], 0, 0);
     			x=0;
				}   
			}
 		}
		
	}

      
	}
      
	return 0;

}










