
.globl main
.data
    icono: .space 1024
    dibujo: .byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x0B, 0x0F, 0x0F, 0x03, 0x00, 0x00, 0x00, 0x00, 0x80, 0xC0,0xE0, 0xFC, 0xFE, 0xFF, 0xFF, 0x7F, 0xFF, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 0xFF, 0xFC, 0xF8, 0xF0, 0x80, 0x01, 0x2F, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 0x3F, 0x7F, 0xFF, 0x7F, 0x3F, 0x3F,0x3F, 0x1F, 0x0F, 0x1F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x1F, 0x0F, 0x1F,0x3F, 0x1F, 0x3F, 0x3F, 0x3F, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x80, 0x80, 0x80,0x80, 0x86, 0x0E, 0x08, 0x00, 0x0E, 0x1F, 0x3F, 0x00, 0x00, 0x00, 0xE8, 0xFF, 0xFE, 0xFF, 0xFE,0xFC, 0xF8, 0x70, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xE0, 0x20,0x19, 0x38, 0x3C, 0x38, 0x1C, 0x08, 0x1C, 0x88, 0x18, 0x18, 0x39, 0xBB, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xBF, 0x1D, 0x08, 0x00, 0x88, 0x08, 0x08, 0x0C, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0B,0x7F, 0x3F, 0x1F, 0x0F, 0x07, 0x03, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x80, 0x80, 0xC0, 0xC0, 0xC0, 0xE0, 0xC0, 0xE0, 0xC0, 0xE0,0xC0, 0xE0, 0xC0, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x03, 0x07, 0x0F, 0x1F, 0x3F,0x7F, 0x00, 0x00, 0xC0, 0xE0, 0xF0, 0xF8, 0xFC, 0xFC, 0x7C, 0x3E, 0x3E, 0x3F, 0x1F, 0x3F, 0x1F,0x2F, 0x1F, 0x0F, 0x07, 0x00, 0x1E, 0x3E, 0x70, 0xF8, 0xF8, 0xF8, 0xFC, 0xFF, 0xFF, 0xFF, 0xFF,0x2F, 0x09, 0x38, 0x3C, 0x38, 0x3C, 0x38, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0xD4, 0xFE, 0xFF,0xFC, 0xFC, 0xFE, 0xFE, 0xFE, 0xFC, 0xFA, 0xF8, 0xF8, 0xFC, 0xFE, 0xFF, 0xFE, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFE, 0xFC, 0xE8, 0x98, 0x3A, 0xFC, 0xFA, 0xFC, 0xFC, 0xFC, 0xFE, 0x54, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x80, 0xC0, 0xE0, 0xF0,0xF8, 0xF8, 0xFE, 0xFE, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0xFC, 0xE0, 0xE0, 0xE0, 0xC0, 0x80, 0x80, 0x80, 0x00,0x00, 0x00, 0x00, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFB,0xF7, 0xFA, 0xF7, 0xEA, 0xF4, 0xF8, 0xFD, 0xF8, 0xFD, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xFE, 0xF0, 0xE8, 0xD0, 0xA0, 0x60, 0xE2, 0xE6, 0xEA, 0xF8, 0xE0, 0xE0, 0x80, 0x01, 0xBF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7B, 0x73, 0x38, 0x1D, 0x0F, 0x0F, 0xAF, 0xFF, 0xAB, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC0, 0xF8, 0xF8, 0xF8, 0xFD, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 0x3F,0x1F, 0x0F, 0x07, 0x03, 0x07, 0x83, 0xC3, 0xE3, 0xE1, 0xE3, 0xE3, 0xE3, 0xE3, 0xE3, 0xE7, 0xEF,0xFF, 0xFE, 0xFE, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0xFF, 0xFF, 0xFF, 0xFB, 0xFB, 0xFB, 0xFB,0xFB, 0xFF, 0xFF, 0xE7, 0xE3, 0xC1, 0x83, 0x01, 0x00, 0x1F, 0x3E, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0x2A, 0x05, 0x0F, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0xF8, 0xF8, 0xF3, 0xFE, 0xFF, 0xFE, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xEE, 0xBF, 0x06, 0x00, 0x00, 0x00, 0x0A, 0x07, 0x02, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x07, 0xBF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xE7, 0xE3, 0xC0, 0xE0, 0xC0,0xE0, 0xF0, 0xF8, 0xFC, 0xBE, 0x3F, 0x0F, 0x0F, 0x0F, 0x07, 0x03, 0x07, 0x03, 0x07, 0x0B, 0x47,0x0F, 0x0F, 0x0F, 0x1F, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xE3,0xF9, 0xEE, 0xC6, 0xEF, 0xC7, 0x83, 0x87, 0x8B, 0x93, 0xBB, 0xFB, 0xFB, 0xFB, 0xBB, 0x39, 0xBB,0xF9, 0xB9, 0xB9, 0xB8, 0xB9, 0xB8, 0x18, 0x28, 0x00, 0x00, 0x00, 0x00, 0xDD, 0xFF, 0x7F, 0x2F,0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x03, 0x07, 0x0F, 0x1F, 0x3F, 0x3F, 0x3F, 0x7F, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 0x3E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x03, 0x01, 0x81,0x01, 0x03, 0x01, 0x03, 0x07, 0x0F, 0x1F, 0x2F, 0x1F, 0x3F, 0x3F, 0xFF, 0xDF, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0x8F, 0x01, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x08, 0x06, 0x02, 0x00, 0x00, 0x0F, 0x1F, 0x3F, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xAE, 0x01, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x01, 0x00, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x1F,0xBF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0xFE, 0xFE, 0xFC, 0xFE, 0xFC, 0xFE, 0xFC,0xFE, 0xFC, 0xF8, 0xFE, 0xEE, 0xFE, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x03, 0x03,0x07, 0x0F, 0x0F, 0x0F, 0x1F, 0x0F, 0x1F, 0x1F, 0x1F, 0x3F, 0x3F, 0x3F, 0x7F, 0x7F, 0x7F, 0x7F,0x7F, 0x3F, 0x7F, 0x3F, 0x3F, 0x3F, 0x1F, 0x3F, 0x1F, 0x0A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x05, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xBE, 0xFF, 0xFF,0x7F, 0x3F, 0x1F, 0x8F, 0x0F, 0x08, 0x7C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    .text
.ent main
    
main:
    
    jal	    init_pins
    jal	    init_spi
    jal	    init_ssd1306
    
    # lleno el array de la pantalla de ceros
    # must be a funct
    la	    $t0,icono
    li	    $t1,0xFF
    li	    $t2,1023
    llenarArray:
	sb	$t1,($t0)
	addi	$t0,$t0,1
	beqz	$t2,finLlenarArray
	addi	$t2,$t2,-1
    j	    llenarArray
    
    finLlenarArray:
    
     la	    $a2, icono
     jal    send_bitmap
     
     la	    $a2, dibujo
     jal    send_bitmap
    
    
    
    main_loop:
    
    li	    $t0, 0
    j	    main_loop
    
    
    
    li	    $v0, 10
    syscall
    