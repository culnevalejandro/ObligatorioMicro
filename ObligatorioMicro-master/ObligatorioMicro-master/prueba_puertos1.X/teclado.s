.globl keypad_read
	.data
delay_count: .word 100000 # Conteo para la función de retardo

.text

keypad_read:
    li      $t0, 0          # count = 0
    li      $t1, 0x10       # bitmask = 0x10
    li      $t2, 0          # keys = 0

    lw      $t3, PORTD      # Cargar el valor de PORTD
    andi    $t3, $t3, 0x0F  # Verificar si alguna de las líneas bajas está alta
    beqz    $t3, exit       # Si no hay, salir y retornar 0

scan_loop:
    lw      $t3, PORTD      # Cargar el valor de PORTD
    andi    $t3, $t3, 0x0F  # PORTD &= 0x0F
    sw      $t3, PORTD     # Guardar en PORTD

    or     $t3, $t3, $t1   # PORTD |= bitmask
    sw      $t3, PORTD     # Guardar en PORTD

    jal     delay_ms        # Retardo de unos milisegundos

    lw      $t3, PORTD      # Cargar el valor de PORTD
    andi    $t5, $t3, 0x0F  # Guardar las columnas leídas
    or      $t2, $t2, $t5   # keys |= (PORTD & 0x0F)

    li      $t6, 3          # Si ya hemos leído las 4 columnas
    beq     $t0, $t6, finish

    sll     $t2, $t2, 4     # keys <<= 4
    sll     $t1, $t1, 1     # bitmask <<= 1
    addi    $t0, $t0, 1     # count++
    j       scan_loop

finish:
    li      $t3, 0xF0       # PORTD = 0xF0
    sw      $t3, 0($t1)     # Guardar en PORTD

    jr      $ra             # Return keys

exit:
    li      $v0, 0
    jr      $ra

delay_ms:
    lw      $t7, delay_count
delay_loop:
    addi    $t7, $t7, -1
    bne    $t7, $zero,  delay_loop
	jr		$ra