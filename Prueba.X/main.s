# Subrutina para inicializar la pantalla OLED
oled_init:
    # Reset de la pantalla
    la      $t1, LATD
    li      $t2, 0x0002  # RD1 (RES) = 0
    sw      $t2, 0($t1)
    li      $t3, 10000   # Espera
wait_reset:
    addi    $t3, $t3, -1   # Decrementar el contador de espera
    bne     $t3, $zero, wait_reset # Saltar si $t3 no es cero

    li      $t2, 0x0000  # RD1 (RES) = 1
    sw      $t2, 0($t1)
    li      $t3, 10000   # Espera
wait_release:
    addi    $t3, $t3, -1   # Decrementar el contador de espera
    bne     $t3, $zero, wait_release # Saltar si $t3 no es cero

    # Enviar comandos de inicialización al OLED
    la      $t4, init_commands
init_loop:
    lw      $t5, 0($t4)
    beq     $t5, $zero, init_done
    jal     send_command
    addi    $t4, $t4, 4
    j       init_loop

init_done:
    jr      $ra

# Subrutina para enviar un comando al OLED
# Subrutina para enviar un comando al OLED
send_command:
    lw      $t6, 0($t5)           # Cargar el comando desde la dirección de memoria en $t5
    li      $t7, 0x0008            # RD3 (CS) = 0
    sw      $t7, 0($t1)           # Poner el pin CS en bajo
    sw      $t6, spi_data          # Cargar el comando en el registro de datos SPI
    li      $t8, 0x0001            # Configurar el bit de transferencia de comando en el registro de control SPI
    sw      $t8, spi_control       # Escribir en el registro de control SPI para iniciar la transferencia
wait_spi_transfer_command:
    lw      $t9, spi_control      # Leer el registro de control SPI
    and     $t10, $t9, 0x0001     # Verificar el bit de transferencia de comando
    beqz    $t10, wait_spi_transfer_command  # Esperar hasta que la transmisión SPI se complete
    li      $t7, 0x0000            # RD3 (CS) = 1
    sw      $t7, 0($t1)           # Poner el pin CS en alto
    jr      $ra



# Subrutina para enviar datos al OLED
send_data:
    lw      $t6, 0($t5)           # Cargar el byte de datos desde la dirección de memoria en $t5
    li      $t7, 0x0004            # RD2 (DC) = 1
    sw      $t7, 0($t1)           # Poner el pin DC en alto
    sw      $t6, spi_data          # Cargar el byte de datos en el registro de datos SPI
    li      $t8, 0x0003            # Configurar el bit de transferencia de datos en el registro de control SPI
    sw      $t8, spi_control       # Escribir en el registro de control SPI para iniciar la transferencia
wait_spi_transfer_data:
    lw      $t9, spi_control      # Leer el registro de control SPI
    andi    $t10, $t9, 0x0001     # Verificar el bit de transferencia de datos
    beqz    $t10, wait_spi_transfer_data  # Esperar hasta que la transmisión SPI se complete
    jr      $ra

# Subrutina para mostrar "Hello World"
display_hello_world:
    # Aquí debes escribir el código para enviar los datos que forman "Hello World" al OLED
    # Puedes usar la función send_data para enviar cada carácter a la pantalla
    # Por ejemplo, para enviar la cadena "Hello World":
    la      $t5, hello_world_str  # Dirección de memoria de la cadena "Hello World"
    move    $t11, $zero           # Inicializar el índice del bucle
loop_send_data:
    lb      $t12, 0($t5)          # Cargar el siguiente carácter de la cadena
    beqz    $t12, done_display    # Si el carácter es nulo, terminar el bucle
    jal     send_data             # Enviar el carácter a la pantalla
    addi    $t5, $t5, 1           # Avanzar al siguiente carácter de la cadena
    addi    $t11, $t11, 1         # Incrementar el índice del bucle
    j       loop_send_data
done_display:
    jr      $ra



# String "Hello World" en ASCII
hello_world_str:
    .asciiz "Hello World"
