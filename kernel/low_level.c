/* working on low level register 
    E.g._____
        assembly instruction
        mov dx, register address ;mov add. of i/o register of hardware to be used
        in al, dx
        or al, incstruction
        out dx, al ; out put to register
    */
   /*this will act as middle ware b/w high level c prog. and low level assembly instruction for
    i/o hardware register*/
    #include "low_level.h"
   unsigned char port_byte_in(unsigned short port){
        unsigned char result;
            __asm__("in %%dx, %%al" : "= a" (result) : "d" (port));
        return result;
    
   }
    void port_byte_out(unsigned short port, unsigned char data){

       __asm__("out %%al, %%dx" : : "a" (data), "d" (port));
          
   }

   unsigned short port_word_in ( unsigned short port ) {
        unsigned short result ;
            __asm__ ("in %%dx, %%ax" : "=a" (result) : "d" (port));
        return result ;
}

   void port_word_out ( unsigned short port , unsigned short data ) {
            
            __asm__ ("out %% ax , %% dx" : : "a" ( data ), "d" (port));

}