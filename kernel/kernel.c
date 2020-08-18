#include "/home/navdeep/Desktop/operating-system/drivers/screen.h"
/*void print(char*message);
extern void kmain();*/
void main() {

  print_char("driver up and running.0");
}
/*void print(char*message){
char * p_video_buffer = (char*)0xb8000;
char * p_next_char = message;
    while(*p_next_char){
    *p_video_buffer = *p_next_char;
      p_next_char++;
     p_video_buffer += 2;
     
    }
}*/

