.globl black_screen
.globl main
.data
dibujo:			.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x0B, 0x0F, 0x0F, 0x03, 0x00, 0x00, 0x00, 0x00, 0x80, 0xC0,0xE0, 0xFC, 0xFE, 0xFF, 0xFF, 0x7F, 0xFF, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 0xFF, 0xFC, 0xF8, 0xF0, 0x80, 0x01, 0x2F, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 0x3F, 0x7F, 0xFF, 0x7F, 0x3F, 0x3F,0x3F, 0x1F, 0x0F, 0x1F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x1F, 0x0F, 0x1F,0x3F, 0x1F, 0x3F, 0x3F, 0x3F, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x80, 0x80, 0x80,0x80, 0x86, 0x0E, 0x08, 0x00, 0x0E, 0x1F, 0x3F, 0x00, 0x00, 0x00, 0xE8, 0xFF, 0xFE, 0xFF, 0xFE,0xFC, 0xF8, 0x70, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xE0, 0x20,0x19, 0x38, 0x3C, 0x38, 0x1C, 0x08, 0x1C, 0x88, 0x18, 0x18, 0x39, 0xBB, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xBF, 0x1D, 0x08, 0x00, 0x88, 0x08, 0x08, 0x0C, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0B,0x7F, 0x3F, 0x1F, 0x0F, 0x07, 0x03, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x80, 0x80, 0xC0, 0xC0, 0xC0, 0xE0, 0xC0, 0xE0, 0xC0, 0xE0,0xC0, 0xE0, 0xC0, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x03, 0x07, 0x0F, 0x1F, 0x3F,0x7F, 0x00, 0x00, 0xC0, 0xE0, 0xF0, 0xF8, 0xFC, 0xFC, 0x7C, 0x3E, 0x3E, 0x3F, 0x1F, 0x3F, 0x1F,0x2F, 0x1F, 0x0F, 0x07, 0x00, 0x1E, 0x3E, 0x70, 0xF8, 0xF8, 0xF8, 0xFC, 0xFF, 0xFF, 0xFF, 0xFF,0x2F, 0x09, 0x38, 0x3C, 0x38, 0x3C, 0x38, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0xD4, 0xFE, 0xFF,0xFC, 0xFC, 0xFE, 0xFE, 0xFE, 0xFC, 0xFA, 0xF8, 0xF8, 0xFC, 0xFE, 0xFF, 0xFE, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFE, 0xFC, 0xE8, 0x98, 0x3A, 0xFC, 0xFA, 0xFC, 0xFC, 0xFC, 0xFE, 0x54, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x80, 0xC0, 0xE0, 0xF0,0xF8, 0xF8, 0xFE, 0xFE, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0xFC, 0xE0, 0xE0, 0xE0, 0xC0, 0x80, 0x80, 0x80, 0x00,0x00, 0x00, 0x00, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFB,0xF7, 0xFA, 0xF7, 0xEA, 0xF4, 0xF8, 0xFD, 0xF8, 0xFD, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xFE, 0xF0, 0xE8, 0xD0, 0xA0, 0x60, 0xE2, 0xE6, 0xEA, 0xF8, 0xE0, 0xE0, 0x80, 0x01, 0xBF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7B, 0x73, 0x38, 0x1D, 0x0F, 0x0F, 0xAF, 0xFF, 0xAB, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC0, 0xF8, 0xF8, 0xF8, 0xFD, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 0x3F,0x1F, 0x0F, 0x07, 0x03, 0x07, 0x83, 0xC3, 0xE3, 0xE1, 0xE3, 0xE3, 0xE3, 0xE3, 0xE3, 0xE7, 0xEF,0xFF, 0xFE, 0xFE, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0xFF, 0xFF, 0xFF, 0xFB, 0xFB, 0xFB, 0xFB,0xFB, 0xFF, 0xFF, 0xE7, 0xE3, 0xC1, 0x83, 0x01, 0x00, 0x1F, 0x3E, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0x2A, 0x05, 0x0F, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0xF8, 0xF8, 0xF3, 0xFE, 0xFF, 0xFE, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xEE, 0xBF, 0x06, 0x00, 0x00, 0x00, 0x0A, 0x07, 0x02, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x07, 0xBF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xE7, 0xE3, 0xC0, 0xE0, 0xC0,0xE0, 0xF0, 0xF8, 0xFC, 0xBE, 0x3F, 0x0F, 0x0F, 0x0F, 0x07, 0x03, 0x07, 0x03, 0x07, 0x0B, 0x47,0x0F, 0x0F, 0x0F, 0x1F, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xE3,0xF9, 0xEE, 0xC6, 0xEF, 0xC7, 0x83, 0x87, 0x8B, 0x93, 0xBB, 0xFB, 0xFB, 0xFB, 0xBB, 0x39, 0xBB,0xF9, 0xB9, 0xB9, 0xB8, 0xB9, 0xB8, 0x18, 0x28, 0x00, 0x00, 0x00, 0x00, 0xDD, 0xFF, 0x7F, 0x2F,0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x03, 0x07, 0x0F, 0x1F, 0x3F, 0x3F, 0x3F, 0x7F, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 0x3E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x03, 0x01, 0x81,0x01, 0x03, 0x01, 0x03, 0x07, 0x0F, 0x1F, 0x2F, 0x1F, 0x3F, 0x3F, 0xFF, 0xDF, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0x8F, 0x01, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x08, 0x06, 0x02, 0x00, 0x00, 0x0F, 0x1F, 0x3F, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xAE, 0x01, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x01, 0x00, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x1F,0xBF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0xFE, 0xFE, 0xFC, 0xFE, 0xFC, 0xFE, 0xFC,0xFE, 0xFC, 0xF8, 0xFE, 0xEE, 0xFE, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x03, 0x03,0x07, 0x0F, 0x0F, 0x0F, 0x1F, 0x0F, 0x1F, 0x1F, 0x1F, 0x3F, 0x3F, 0x3F, 0x7F, 0x7F, 0x7F, 0x7F,0x7F, 0x3F, 0x7F, 0x3F, 0x3F, 0x3F, 0x1F, 0x3F, 0x1F, 0x0A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x05, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xBE, 0xFF, 0xFF,0x7F, 0x3F, 0x1F, 0x8F, 0x0F, 0x08, 0x7C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
menu_actual:	.byte 0x1
tiempo:			.space 1024
	.text
.ent main
    
main:
    
	jal	    init_pins
	jal	    init_spi
	jal	    init_ssd1306
         
    
    
main_loop:
	
menu1:
	jal		menu_principal1

loop:
	jal		keypad_read
	beq		$v0, 54, menu2
	beq		$v0, 68, calculadora
	beq		$v0, 56, menu3
	
	j		loop
	
calculadora:
	jal		menu_calculadora
	j		menu1
	
	
	
menu2:
	jal menu_principal2
		
loop2:
	jal		keypad_read
	beq		$v0, 52, menu1
	beq		$v0, 68, rot13
	beq		$v0, 56, menu4
		
	
	j		loop2
	
rot13:
	jal		menu_rot13
	j		menu2
	
	
menu3:
	
	jal		menu_principal3

loop3:
	jal		keypad_read
	beq		$v0, 50, menu1
	beq		$v0, 68, tateti
	beq		$v0, 54, menu4

	j		loop3
	
tateti:
	jal		menu_tateti
	j		menu3
	
	
menu4:
	
	jal		menu_principal4

loop4:
	jal		keypad_read
	beq		$v0, 50, menu2
	beq		$v0, 68, calculadora1
	beq		$v0, 52, menu3

	j		loop4
	
calculadora1:
	jal		menu_calculadora
	j		menu4


    