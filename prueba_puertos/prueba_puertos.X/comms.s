.globl send_command

send_command:
    # Prolog
    addi    $sp, $sp, -4
    sw      $ra, 0($sp)

    li      $t0, SPI1STAT

waitTxReady:
    lw      $t1, 0($t0)		    # Leer el registro de estado
    andi    $t1, $t1, 0x00000008    # Comprobar si el buffer de transmisión está lleno
    bnez    $t1, waitTxReady

    li      $t0, SPI1BUF
    sw      $a0, 0($t0)

waitTxComplete:
    lw      $t1, 0($t0)
    andi    $t1, $t1, 0x00000001    # Comprobar si la transmisión se ha completado
    beqz    $t1, waitTxComplete

    lw      $ra, 0($sp)
    addi    $sp, $sp, 4
    jr      $ra
