.globl send_command

send_command:
    # Inicializar PORTD
    li      $t0, 0
    sw      $t0, PORTD
    
    # Escribir comando en SPI1BUF
    sw      $a0, SPI1BUF
    
waitTxReady:
    # Leer el registro de estado SPI1STAT
    lw      $t1, SPI1STAT
    # Comprobar si el buffer de transmisión está vacío (SPITBE = 1)
    andi    $t1, $t1, 0x8
    beq	    $t1, $zero, waitTxReady   # Si SPITBE es 0, esperar
    
waitTxComplete:
    li	    $t0, 0x800
    sw	    $t0, PORTD
    

    # Epilog
    jr      $ra
    

