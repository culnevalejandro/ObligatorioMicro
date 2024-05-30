.globl send_command

send_command:
    # Inicializar DC, RES y CS (PORTE)
    li      $t0, 0x6
    sw      $t0, PORTECLR
    
    # Escribir comando en SPI1BUF
    sw      $a0, SPI1BUF
    
waitTxReady:
    # Leer el registro de estado SPI1STAT
    lw      $t1, SPI1STAT
    # Comprobar si el SPI esta realizando transacciones (SPITBUSY = 1)
    andi    $t1, $t1, 0x800	    #me fijo en el bit 11 que me dice si esta ocupado o no el SPI
    beq	    $t1, 1, waitTxReady   # Si SPITBUSY es 1, esperar
    
waitTxComplete:
    
    jr      $ra
    

