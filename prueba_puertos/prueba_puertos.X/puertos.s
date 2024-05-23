.globl main
.text
.ent main
    
main:
    
    li	    $t0,0x330    # configuracion SPI en hexadecimal
    sw	    $t0,(SPI1CON)
    
    
    j main