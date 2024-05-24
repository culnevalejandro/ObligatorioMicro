# .equ OLED_COMMAND, 0x00       # Dirección de comando de OLED
# .equ OLED_DATA, 0x01          # Dirección de datos de OLED
# .equ SPI_CONTROL, 0xBF800800  # Dirección del control del SPI
# .equ SPI_DATA, 0xBF800810     # Dirección de datos del SPI
# .equ SPI_STATUS, 0xBF800820   # Dirección de estado del SPI
 
    
# Comandos de inicialización de SSD1306
.equ CMD_DISPLAY_OFF, 0xAE
.equ CMD_SET_DISPLAY_CLOCK_DIV, 0xD5
.equ CMD_SET_DISPLAY_CLOCK_DIV_VALUE, 0x80	# divide entre 1 la velocidad del clock
# .equ CMD_SET_MULTIPLEX, 0xA8
# .equ CMD_SET_DISPLAY_OFFSET, 0xD3
# .equ CMD_SET_START_LINE, 0x40
.equ CMD_CHARGE_PUMP, 0x8D
.equ CMD_MEMORY_MODE, 0x20
# .equ CMD_SEG_REMAP, 0xA1
.equ CMD_COM_SCAN_DEC, 0xC8
# .equ CMD_SET_COM_PINS, 0xDA
.equ CMD_SET_CONTRAST, 0x81
.equ CMD_SET_CONTRAST_VALUE, 0x8F
# .equ CMD_SET_PRECHARGE, 0xD9
# .equ CMD_SET_VCOM_DETECT, 0xDB
.equ CMD_DISPLAY_ALL_ON_RESUME, 0xA4
# .equ CMD_NORMAL_DISPLAY, 0xA6
.equ CMD_DISPLAY_ON, 0xAF
    
# No se utiliza 0xA7, no necesitamos invertir la visualizacion del display
    
    
.globl main
.text
.ent main
    
main:
    
    jal	    init_pins
    jal	    init_spi
    jal	    init_ssd1306
    
    

# 
#     
#     
# # Rutina para enviar comandos a la OLED
# send_command:
#     li $t1, OLED_COMMAND
#     sw $t0, 0($t1)      # Enviar comando al registro correspondiente
#     # Esperar a que el SPI esté listo
# wait_spi_ready:
#     lw $t2, 0($t1)
#     andi $t2, $t2, 0x01
#     beq $t2, $zero, wait_spi_ready
#     jr $ra
    
    
    

#    j main
    
    
    li	    $v0, 10
    syscall
    