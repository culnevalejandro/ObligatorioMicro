    .global main
    .text
    .ent main

main:
    # Configurar puertos F y G como salida
    li      $t0, 0
    la      $t1, TRISF
    sw      $t0, 0($t1)
    la      $t1, TRISG
    sw      $t0, 0($t1)
    # Configurar puertos D como salida
    la      $t1, TRISD
    sw      $t0, 0($t1)

    # Inicialización de la pantalla OLED
    jal     oled_init

loop:
    # Mostrar "Hello World"
    jal     display_hello_world

    # Ciclo infinito
    j       loop

.end main

# Subrutina para inicializar la pantalla OLED
oled_init:
    # Reset de la pantalla
    la      $t1, LATD
    li      $t2, 0x01      # RD0 (RES) = 0
    sw      $t2, 0($t1)
    li      $t3, 10000     # Espera
wait_reset:
    subi    $t3, $t3, 1
    bnez    $t3, wait_reset

    li      $t2, 0x00      # RD0 (RES) = 1
    sw      $t2, 0($t1)
    li      $t3, 10000     # Espera
wait_release:
    subi    $t3, $t3, 1
    bnez    $t3, wait_release

    # Enviar comandos de inicialización al OLED
    # (Esto depende del controlador de la pantalla, se deben enviar los comandos adecuados)
    la      $t4, command_list
    lw      $t5, 0($t4)
init_loop:
    beqz    $t5, init_done
    jal     send_command
    addi    $t4, $t4, 4
    lw      $t5, 0($t4)
    j       init_loop

init_done:
    jr      $ra

# Lista de comandos de inicialización (ejemplo, debe ser ajustado según el controlador)
.data
command_list:
    .word   0xAE    # Display OFF
    .word   0xA8    # Set MUX Ratio
    .word   0x3F    # Multiplex Ratio
    .word   0xD3    # Display Offset
    .word   0x00    # Offset value
    .word   0x40    # Set Display Start Line
    .word   0xA1    # Set Segment Re-map
    .word   0xC8    # COM Output Scan Direction
    .word   0xDA    # COM Pins Hardware Configuration
    .word   0x12
    .word   0x81    # Contrast Control
    .word   0x7F
    .word   0xA4    # Disable Entire Display On
    .word   0xA6    # Set Normal/Inverse Display
    .word   0xD5    # Set Display Clock Divide Ratio/Oscillator Frequency
    .word   0x80
    .word   0x8D    # Enable charge pump regulator
    .word   0x14
    .word   0xAF    # Display ON
    .word   0x00    # End of commands (marker)

# Subrutina para enviar un comando al OLED
send_command:
    # Código para enviar un comando al OLED usando SPI
    # Aquí debes escribir el código que manda un comando específico a la pantalla usando SPI
    jr      $ra

# Subrutina para mostrar "Hello World"
display_hello_world:
    # Código para enviar los datos que forman "Hello World" al OLED
    # Aquí debes escribir el código que manda los datos para mostrar "Hello World" en la pantalla
    jr      $ra
