.text
.globl send
.globl send_bitmap
    
    
# FUNCT send
# PARAM
# $a0 send through spi
# $a1 data (0x3); comm (0x1)
send:

    # Inicializar DC, RES y CS (PORTE)
    sb	    $a1, PORTE
    
    # Escribir comando en SPI1BUF
    sb	    $a0, SPI1BUF
    
waitTxReady:
    # Leer el registro de estado SPI1STAT
    lw	    $t1, SPI1STAT
    # Comprobar si el SPI esta realizando transacciones (SPITBUSY = 1)
    andi    $t1, $t1, 0x800	    # me fijo en el bit 11 que me dice si esta ocupado o no el SPI
    beq	    $t1, 1, waitTxReady   # Si SPITBUSY es 1, esperar
    
    
    jr      $ra
    
    
    
# FUNCT send_bitmap
# PARAM
# Recibe en a2 puntero inicial del array, recorre mandando por word
send_bitmap:
    # lw $s1, $a2
    li	    $s0, 0 # contador de bytes que se mandaron
    addi    $sp, $sp, -4
    sw	    $ra, ($sp)
 loop:

    lb	    $a0, ($a2)
    li	    $a1, 0x3
    jal	    send
    addi    $s0, $s0, 1 
    addi    $a2, $a2, 1 
    bne	    $s0,1024,loop
    
 fin:
    lw	    $ra, ($sp)
    addi    $sp, $sp, 4
    jr	    $ra
    
    