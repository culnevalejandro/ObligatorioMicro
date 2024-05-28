.globl init_pins
.globl init_spi
.globl init_ssd1306
    
# Comandos de inicialización de SSD1306
.equ CMD_DISPLAY_OFF, 0xAE
.equ CMD_SET_DISPLAY_CLOCK_DIV, 0xD5
.equ CMD_SET_DISPLAY_CLOCK_DIV_VALUE, 0x80	# divide entre 1 la velocidad del clock
# .equ CMD_SET_MULTIPLEX, 0xA8
# .equ CMD_SET_DISPLAY_OFFSET, 0xD3
# .equ CMD_SET_START_LINE, 0x40
.equ CMD_CHARGE_PUMP, 0x8D
.equ CMD_CHARGE_PUMP_VALUE, 0x14
.equ CMD_MEMORY_MODE, 0x20
# .equ CMD_SEG_REMAP, 0xA1
.equ CMD_COM_SCAN_DEC, 0xC8
# .equ CMD_SET_COM_PINS, 0xDA
.equ CMD_SET_CONTRAST, 0x81
.equ CMD_SET_CONTRAST_VALUE, 0xCF
# .equ CMD_SET_PRECHARGE, 0xD9
# .equ CMD_SET_VCOM_DETECT, 0xDB
.equ CMD_DISPLAY_ALL_ON_RESUME, 0xA4
# .equ CMD_NORMAL_DISPLAY, 0xA6
.equ CMD_DISPLAY_ON, 0xAF
    
# No se utiliza 0xA7 porque no necesitamos invertir la visualizacion del display
    
    
init_pins:
    addi    $sp, $sp, -4
    sw	    $ra, ($sp)
    
    jal	    delay
    
    # pin 26 como salida y 28 como entrada (RE0-reset)
    li	    $t0,0x4
    sw	    $t0,TRISE
    
    # pin 38 como salida (SCK1-clock)
    li	    $t0,0
    sw	    $t0,TRISF
    
    # pin 41 como salida (RB1 - data)
    li	    $t0,0
    sw	    $t0,TRISB
    
    # pines 34 y 35 como salida (RD5,RD11 - DC,CS)
    li	    $t0,0
    sw	    $t0,TRISD
    
    lw	    $ra, ($sp)
    addi    $sp, $sp, 4
    
    jr	    $ra
    
    

    
init_spi:
    
    addi    $sp, $sp, -4
    sw	    $ra, ($sp)
    
    jal	    delay
    
    li	    $t0, 0x03800000
    sw	    $t0, (IEC0CLR)	# deshabilitar interrupts	*preguntar Isma
    
    sw	    $zero, (SPI1CON)	# reset SPI1			*preguntar Isma
    
    lw	    $t0, (SPI1BUF)
    
    li	    $t0, 0x0
    sw	    $t0, (SPI1BRG)	# *preguntar Isma
    
    li	    $t0, 0x0
    sw	    $t0, SPI1STATCLR
    
    li	    $t0, 0x8120
    sw	    $t0, (SPI1CON)
    
    li	    $t0, 0x0
    sw	    $t0, SPI1STATCLR
    
    lw	    $ra, ($sp)
    addi    $sp, $sp, 4
    
    jr	    $ra
    
    
    
# Rutina de inicialización de la OLED
init_ssd1306:
    addi    $sp, $sp, -4
    sw	    $ra, ($sp)
    
    jal	    delay
    
    # Apagar pantalla
    li	    $a0, 0xAE
    jal	    send_command
    
    # Configurar reloj de pantalla
    li	    $a0, CMD_SET_DISPLAY_CLOCK_DIV
    jal	    send_command
    li	    $a0, CMD_SET_DISPLAY_CLOCK_DIV_VALUE  # Valor de división de reloj
    jal	    send_command
    
    # Habilitar bomba de carga
    li	    $a0, CMD_CHARGE_PUMP
    jal	    send_command
    li	    $a0, CMD_CHARGE_PUMP_VALUE  # Habilitar bomba de carga
    jal	    send_command
    
    # Configurar modo de memoria
    li	    $a0, CMD_MEMORY_MODE
    jal	    send_command
    li	    $a0, 0x00  # Modo horizontal
    jal	    send_command
    
    # Configurar escaneo de COM
    li	    $a0, CMD_COM_SCAN_DEC
    jal	    send_command
    
    # Configurar contraste
    li	    $a0, CMD_SET_CONTRAST
    jal	    send_command
    li	    $a0, CMD_SET_CONTRAST_VALUE
    jal	    send_command
    
    # Activar toda la pantalla
    li	    $a0, CMD_DISPLAY_ALL_ON_RESUME
    jal	    send_command
    
    # Encender pantalla
    li	    $a0, CMD_DISPLAY_ON
    jal	    send_command
    
    lw	    $ra, ($sp)
    addi    $sp, $sp, 4
    
    jr	    $ra
    
    
    delay:
    
    addi    $sp, $sp, -4
    sw	    $ra, ($sp)
    
    li	    $t0, 2000
    
    delay_loop:
    
    sub	    $t0, $t0, 1
    bne	    $t0, $zero, delay_loop

    li      $t0, 0x800
    sw      $t0, PORTD
    
    lw	    $ra, ($sp)
    addi    $sp, $sp, 4

    jr      $ra
    