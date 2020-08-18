#include"/home/navdeep/Desktop/operating-system/drivers/screen.h"
#include "/home/navdeep/Desktop/operating-system/kernel/low_level.h"
void set_cursor(int offset);
int get_cursor();
 //this will track screen current pos. address.

void print_char(char*character){
       char * vidmem = (char*) VIDEO_ADDRESS;
       char attribute_byte = WHITE_ON_BLACK;
      
      int cursorpos  = get_cursor();

        int i = 0;
      while(i<5){ //can't figure out why character[i] != 0 can't be used..
      vidmem[cursorpos] = character[i];
       vidmem[cursorpos+1] = 0x0e;
          cursorpos = cursorpos+2;
          i++;
     }
     
      set_cursor(cursorpos);

}
int get_cursor(){
       port_byte_out(REG_SCREEN_CTRL, 14);
       int offset = port_byte_in(REG_SCREEN_DATA) << 8;
       port_byte_out(REG_SCREEN_CTRL, 15);
       offset += port_byte_in(REG_SCREEN_DATA);
       return offset*2;
}

/*void print_at(char*message){

      
}
/*void print(char*message){
       print_char(message, WHITE_ON_BLACK);
}*/
void set_cursor(int offset)
{
    offset /= 2;
    port_byte_out(REG_SCREEN_CTRL, 14);
    port_byte_out(REG_SCREEN_DATA, offset >> 8);

    port_byte_out(REG_SCREEN_CTRL, 15);
    port_byte_out(REG_SCREEN_DATA, offset & 0xff);
}



