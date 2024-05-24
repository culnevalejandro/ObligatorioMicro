.globl send_command

send_command:
    # Inicializar PORTD
    li      $t0, 0
    sw      $t0, PORTD
    
    # Escribir comando en SPI1BUF
    sb      $a0, SPI1BUF
    
waitTxReady:
    # Leer el registro de estado SPI1STAT
    lb      $t1, SPI1STAT
    # Comprobar si el buffer de transmisión está vacío (SPITBE = 1)
    andi    $t1, $t1, 0x800
    bne	    $t1, $0, waitTxReady   # Si SPITBE es 0, esperar
    
waitTxComplete:
    li	    $t0, 0x800
    sw	    $t0, PORTD
    

    # Epilog
    jr      $ra
    

