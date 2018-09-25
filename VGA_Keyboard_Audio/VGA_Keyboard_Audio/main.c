#include <stdio.h>
//#include "./drivers/inc/ISRs.h"
#include "./drivers/inc/pushbuttons.h"
//#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/VGA.h"
#include "./drivers/inc/ps2_keyboard.h"
#include "./drivers/inc/audio.h"
#include "./drivers/inc/slider_switches.h"



//PUSHBUTTON VGA PROGRAM!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
/*

void test_char(){
    int x,y;
    char c = 0;

    for(y = 0; y <= 59; y++){
        for(x = 0; x <= 79; x++){
            VGA_write_char_ASM(x, y, c++);
           }
       }
}


void test_byte(){
    int x, y; 
    char c = 0;

    for(y = 0; y <= 59; y++)
        for(x = 0; x <= 79; x += 3)
            VGA_write_byte_ASM(x, y, c++);
}


void test_pixel(){
    int x, y;
    unsigned short colour = 0;

    for(y = 0; y <= 239; y++) {
        for(x = 0; x <=319; x++){
            VGA_draw_point_ASM(x, y, colour++);
}
}
}

 
int main () {

while(1) {
if (read_PB_data_ASM() == 1){
   if (read_slider_switches_ASM() > 0) {
       test_byte();
	}else{
       test_char();
    }
    
}
if (read_PB_data_ASM() == 2){
   test_pixel();
}
if (read_PB_data_ASM() == 4){
   VGA_clear_charbuff_ASM();
}
if (read_PB_data_ASM() == 8){
   VGA_clear_pixelbuff_ASM();
}
}
return 0;
} 



*/







// THE KEYBOARD PROGRAM!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
/*
int main() {
VGA_clear_charbuff_ASM();

char *data;
int x,y;
x = 0;
y = 0;

while (1){


if (read_PS2_data_ASM(data)){
    
     VGA_write_byte_ASM(x, y, *data);
	if(x <= 76 && y <= 59){ // or 79
     //VGA_write_byte_ASM(x, y, *data);
     x += 3;
	}
	else{
	x = 0;
	y++;

}

}

}


return 0;
}
*/







//AUDIO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


int main() {


int j; // counter up to 480
j= 0;



while(1) {


       if (j == 480) {
          j = 0;
       }
       
       if (j >= 0 && j < 240 && audio_ASM(0x00FFFFFF)) {
           j++;
       }   
	   else if (j>= 240 && j < 480 && audio_ASM(0x00000000) ) {
			 j++;
       } 
       
 
}


return 0;
}

