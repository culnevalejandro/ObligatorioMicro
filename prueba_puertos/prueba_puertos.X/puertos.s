.data
spi_control:    .word   0xBF805800  # Dirección del registro de control SPI2
spi_data:       .word   0xBF805810  # Dirección del registro de datos SPI2
init_commands:  .word   0xAE, 0xA1, 0xC8, 0x81, 0xCF, 0xA6, 0xD5, 0x80, 0xAF  # Comandos de inicialización
hello_world_str: .asciiz "Hello World"

.text
.globl main
.ent main

main:
    # Configurar pines como salida
    la      $t0, TRISD
    li      $t1, 0xFFF8      # Configurar RD0, RD1, RD2 como salida (bits 0, 1, 2 en 0)
    sw      $t1, 0($t0)
    
    # Configurar pines como salida para SPI2
    la      $t0, TRISG
    li      $t1, 0xFFFB      # Configurar SCK2 (RG6) y SDO2 (RG8) como salida (bits 6 y 8 en 0)
    sw      $t1, 0($t0)
    
    # RG6(p13), RG8(p11), RD0(p3), RD1(p5), RD2(p6)

    # Inicializar el SPI2
    jal     spi_init
    
    # Inicializar el OLED
    jal     oled_init
    
    # Mostrar "Hello World"
    jal     display_hello_world

    # Ciclo infinito
loop:
    j       loop

end_loop:

spi_init:
    # Configuración del SPI2
    li      $t0, 0x0000      # Apagar el módulo SPI2
    la      $t1, spi_control
    sw      $t0, 0($t1)

    # Configuración de los registros de control del SPI2
    li      $t0, 0x00000120  # Configuración básica: Master mode, clock idle low, active high, etc.
    sw      $t0, 0($t1)

    # Configurar la tasa de baudios del SPI2 (por ejemplo, 1 MHz)
    li      $t0, 0x0000001F
    la      $t1, 0xBF805040  # Dirección del registro de baud rate SPI2 (SPI2BRG)
    sw      $t0, 0($t1)

    # Encender el módulo SPI2
    lw      $t0, 0($t1)
    ori     $t0, $t0, 0x8000 # Encender el módulo SPI2 (bit 15)
    sw      $t0, 0($t1)

    jr      $ra

oled_init:
    # Reset de la pantalla OLED
    la      $t0, LATD
    li      $t1, 0x0004      # RD2 (RES) = 0
    sw      $t1, 0($t0)
    li      $t2, 10000       # Espera
wait_reset:
    addi    $t2, $t2, -1
    bnez    $t2, wait_reset

    li      $t1, 0x0000      # RD2 (RES) = 1
    sw      $t1, 0($t0)
    li      $t2, 10000       # Espera
wait_release:
    addi    $t2, $t2, -1
    bnez    $t2, wait_release

    # Enviar comandos de inicialización al OLED
    la      $t3, init_commands
init_loop:
    lw      $a0, 0($t3)
    beqz    $a0, init_done
    jal     send_command
    addi    $t3, $t3, 4
    j       init_loop

init_done:
    jr      $ra

send_command:
    lw      $t5, spi_control      # Cargar la dirección del registro de control SPI2
    lw      $t6, spi_data         # Cargar la dirección del registro de datos SPI2

    # Configurar el pin CS (Chip Select) en bajo para iniciar la comunicación
    li      $t7, 0x0001           # Configurar el bit de CS en bajo (activo)
    sw      $t7, 0($t5)           # Escribir en el registro de control SPI2 para activar CS

    # Cargar el comando en el registro de datos SPI2
    sw      $a0, 0($t6)           # Escribir el comando en el registro de datos SPI2

    # Configurar el bit de transferencia de comando en el registro de control SPI2
    li      $t8, 0x0002           # Configurar el bit de transferencia de comando
    sw      $t8, 0($t5)           # Escribir en el registro de control SPI2 para iniciar la transferencia

wait_spi_transfer_command:
    lw      $t9, 0($t5)           # Leer el registro de control SPI2
    andi    $t0, $t9, 0x0001      # Verificar el bit de transferencia de comando
    bnez    $t0, wait_spi_transfer_command  # Esperar hasta que la transmisión SPI se complete

    # Configurar el pin CS en alto para finalizar la comunicación
    li      $t1, 0x0000           # Configurar el bit de CS en alto (inactivo)
    sw      $t1, 0($t5)           # Escribir en el registro de control SPI2 para desactivar CS

    jr      $ra                    # Retornar

send_data:
    lw      $t5, spi_control      # Cargar la dirección del registro de control SPI2
    lw      $t6, spi_data         # Cargar la dirección del registro de datos SPI2

    # Configurar el pin DC (Data/Command) en alto para indicar que se enviarán datos
    li      $t2, 0x0008           # Configurar el bit de DC en alto (datos)
    sw      $t2, 0($t5)           # Escribir en el registro de control SPI2 para indicar que se enviarán datos

    # Configurar el pin CS (Chip Select) en bajo para iniciar la comunicación
    li      $t7, 0x0001           # Configurar el bit de CS en bajo (activo)
    sw      $t7, 0($t5)           # Escribir en el registro de control SPI2 para activar CS

    # Cargar el dato a enviar en el registro de datos SPI2
    sw      $a0, 0($t6)           # Escribir el dato en el registro de datos SPI2

    # Configurar el bit de transferencia de datos en el registro de control SPI2
    li      $t8, 0x0003           # Configurar el bit de transferencia de datos
    sw      $t8, 0($t5)           # Escribir en el registro de control SPI2 para iniciar la transferencia

wait_spi_transfer_data:
    lw      $t9, 0($t5)           # Leer el registro de control SPI2
    andi    $t0, $t9, 0x0001      # Verificar el bit de transferencia de datos
    bnez    $t0, wait_spi_transfer_data  # Esperar hasta que la transmisión SPI se complete

    # Configurar el pin CS en alto para finalizar la comunicación
    li      $t1, 0x0000           # Configurar el bit de CS en alto (inactivo)
    sw      $t1, 0($t5)           # Escribir en el registro de control SPI2 para desactivar CS

    jr      $ra                    # Retornar

display_hello_world:
    # La dirección de memoria donde está almacenada la cadena "Hello World"
    la      $t3, hello_world_str
    # Enviar cada carácter de la cadena al OLED
loop_send_data:
    lb      $a0, 0($t3)           # Cargar el siguiente carácter de la cadena
    beqz    $a0, end_display      # Si el carácter es nulo, terminar
    jal     send_data             # Enviar el carácter al OLED
    addi    $t3, $t3, 1           # Avanzar al siguiente carácter de la cadena
    j       loop_send_data
end_display:
    jr      $ra
