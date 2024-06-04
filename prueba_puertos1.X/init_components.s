.globl init_pins
.globl init_spi
.globl init_ssd1306
.globl init_res
.globl delay
    
.data
    
    # Inicializacion OLED
    
SSD1306_SETCONTRAST: .byte 0x81
SSD1306_DISPLAYALLON_RESUME: .byte 0xA4
SSD1306_NORMALDISPLAY: .byte 0xA6 
SSD1306_SETDISPLAYCLOCKDIV: .byte 0xD5 
SSD1306_CHARGEPUMP: .byte 0x8D 
SSD1306_MEMORYMODE: .byte 0x20 
SSD1306_DISPLAYON: .byte 0xAF
SSD1306_DISPLAYALLON: .byte 0xA5
SSD1306_DISPLAYOFFSET: .byte 0xD3
SSD1306_COLUMNADDRESS: .byte 0x21
SSD1306_PAGEADDRESS: .byte 0x22



    
.text
    
    
init_pins:
    addi    $sp, $sp, -4
    sw	    $ra, ($sp)
    
    jal	    delay
    
    # pin 26 como salida (RES, RE0), pin 27 (RE1 DC), pin 28 (RE2 CS)
    li	    $t0,0
    sw	    $t0,TRISE
    
    # pin 1 como salida (MOSI D1), pin 38 como salida (SCK1 D0)
    li	    $t0,0
    sw	    $t0,TRISF
    
    
    lw	    $ra, ($sp)
    addi    $sp, $sp, 4
    
    jr	    $ra
    
    

    
init_spi:
    
    addi    $sp, $sp, -4
    sw	    $ra, ($sp)
    
    jal	    delay
    
    li	    $t0, 0x03800000
    sw	    $t0, IEC0CLR
    
    sw	    $zero, SPI1CON
    
    lw	    $t0, SPI1BUF
    
    li      $t0, 0x10000
    sw      $t0, SPI1CONCLR
    
    li	    $t0, 0x0
    sw	    $t0, SPI1BRG
    
    li      $t0, 0x40
    sw      $t0, SPI1STATCLR
    
    li	    $t0, 0x120
    sw	    $t0, SPI1CON
    
    li	    $t0, 0x8000
    sw	    $t0, SPI1CONSET

    
    lw	    $ra, ($sp)
    addi    $sp, $sp, 4
    
    jr	    $ra
    
    
    
    
    
init_ssd1306:
    addi    $sp, $sp, -4
    sw	    $ra, ($sp)
    
    jal	    delay
    
    li	    $t0, 0x0
    sw	    $t0, PORTE
    
    jal	    delay	    # delay > 3 us
    
    li	    $t0, 0x1
    sw	    $t0, PORTE
    
    jal	    delay
    
    
    li	    $a1, 0x1
    li	    $a0, 0xAE
    jal	    enviar
    
    
    
    li	    $a1, 0x1 
    lb	    $a0,SSD1306_SETCONTRAST
    jal	    enviar
    
    li	    $a1, 0x1
    li	    $a0,0x8F
    jal	    enviar
    
    li	    $a1, 0x1  
    lb	    $a0,SSD1306_DISPLAYALLON_RESUME
    jal	    enviar
    
    li	    $a1, 0x1 
    lb	    $a0,SSD1306_NORMALDISPLAY
    jal	    enviar
    
    li	    $a1, 0x1 
    lb	    $a0,SSD1306_SETDISPLAYCLOCKDIV
    jal	    enviar
    li	    $a1, 0x1 
    li	    $a0,0x80
    jal	    enviar
    
    li	    $a1, 0x1 
    lb	    $a0,SSD1306_CHARGEPUMP
    jal	    enviar
    li	    $a1, 0x1 
    li	    $a0,0x14
    jal	    enviar
    
    lb	    $a0,SSD1306_MEMORYMODE
    li	    $a1, 0x1 
    jal	    enviar
    li	    $a1, 0x1 
    li	    $a0,0x00
    jal	    enviar
    
    
    li	    $a1, 0x1 
    lb	    $a0,SSD1306_COLUMNADDRESS
    jal	    enviar
    li	    $a1, 0x1 
    li	    $a0, 0x0
    jal	    enviar
    li	    $a1, 0x1
    li	    $a0, 0x7F
    jal	    enviar
    
    li	    $a1, 0x1 
    lb	    $a0,SSD1306_PAGEADDRESS
    jal	    enviar
    li	    $a1, 0x1 
    li	    $a0, 0x0
    jal	    enviar
    li	    $a1, 0x1
    li	    $a0, 0x7
    jal	    enviar
    
    
    li	    $a1, 0x1 
    lb	    $a0,SSD1306_DISPLAYON
    jal	    enviar

    li	    $a1, 0x1 
    lb	    $a0, SSD1306_DISPLAYALLON
    jal	    enviar
    
    li	    $a1, 0x1 
    li	    $a0, 0xA4
    jal	    enviar
    
    jal	    delay
    

    
    
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
    
    lw	    $ra, ($sp)
    addi    $sp, $sp, 4

    jr      $ra
    