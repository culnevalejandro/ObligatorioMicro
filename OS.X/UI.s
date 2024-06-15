.globl menu_principal1
.globl menu_principal2
.globl menu_principal3
	.data
	calculadora: .byte 0x00, 0x00, 0xFE, 0x02, 0xFA, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A,0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x8A, 0x8A, 0x8A, 0x8A, 0x0A, 0xFA, 0x02, 0xFE, 0x00, 0x00,0x00, 0x00, 0xFF, 0x00, 0xF3, 0x02, 0xF2, 0x92, 0x92, 0xF2, 0x02, 0x02, 0xF2, 0x92, 0x92, 0xF2,0x02, 0x02, 0xF2, 0x92, 0x92, 0xF2, 0x02, 0x02, 0xF2, 0x92, 0x92, 0xF3, 0x00, 0xFF, 0x00, 0x00,0x00, 0x00, 0xFF, 0x00, 0xDE, 0x00, 0xDE, 0x52, 0x52, 0xDE, 0x00, 0x00, 0xDE, 0x52, 0x52, 0xDE,0x00, 0x00, 0xDE, 0x52, 0x52, 0xDE, 0x00, 0x00, 0xDE, 0x52, 0x52, 0xDE, 0x00, 0xFF, 0x00, 0x00,0x00, 0x00, 0x7F, 0x40, 0x43, 0x40, 0x43, 0x42, 0x42, 0x43, 0x40, 0x40, 0x43, 0x42, 0x42, 0x43,0x40, 0x40, 0x43, 0x42, 0x42, 0x43, 0x40, 0x40, 0x43, 0x42, 0x42, 0x43, 0x40, 0x7F, 0x00, 0x00
	calculadora_invertido: .byte 0xFF, 0xFF, 0x01, 0xFD, 0x05, 0xF5, 0xF5, 0xF5, 0xF5, 0xF5, 0xF5, 0xF5, 0xF5, 0xF5, 0xF5, 0xF5,0xF5, 0xF5, 0xF5, 0xF5, 0xF5, 0xF5, 0x75, 0x75, 0x75, 0x75, 0xF5, 0x05, 0xFD, 0x01, 0xFF, 0xFF,0xFF, 0xFF, 0x00, 0xFF, 0x0C, 0xFD, 0x0D, 0x6D, 0x6D, 0x0D, 0xFD, 0xFD, 0x0D, 0x6D, 0x6D, 0x0D,0xFD, 0xFD, 0x0D, 0x6D, 0x6D, 0x0D, 0xFD, 0xFD, 0x0D, 0x6D, 0x6D, 0x0C, 0xFF, 0x00, 0xFF, 0xFF,0xFF, 0xFF, 0x00, 0xFF, 0x21, 0xFF, 0x21, 0xAD, 0xAD, 0x21, 0xFF, 0xFF, 0x21, 0xAD, 0xAD, 0x21,0xFF, 0xFF, 0x21, 0xAD, 0xAD, 0x21, 0xFF, 0xFF, 0x21, 0xAD, 0xAD, 0x21, 0xFF, 0x00, 0xFF, 0xFF,0xFF, 0xFF, 0x80, 0xBF, 0xBC, 0xBF, 0xBC, 0xBD, 0xBD, 0xBC, 0xBF, 0xBF, 0xBC, 0xBD, 0xBD, 0xBC,0xBF, 0xBF, 0xBC, 0xBD, 0xBD, 0xBC, 0xBF, 0xBF, 0xBC, 0xBD, 0xBD, 0xBC, 0xBF, 0x80, 0xFF, 0xFF
	
	rot13: .byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xC0, 0xE0, 0x30, 0x18, 0x0C, 0x04, 0x06, 0x06, 0x06,0x06, 0x06, 0x04, 0x04, 0x0C, 0x18, 0x30, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0xE0, 0x20, 0x31, 0x33, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x3F, 0x3F, 0x30, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x7C, 0xC6, 0x02,0xC6, 0x7C, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x1F, 0x30, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x21, 0x21,0x21, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x1F, 0x00, 0x00, 0x00, 0x00, 0x00
	rot13_invertido: .byte 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 0x3F, 0x1F, 0xCF, 0xE7, 0xF3, 0xFB, 0xF9, 0xF9, 0xF9,0xF9, 0xF9, 0xFB, 0xFB, 0xF3, 0xE7, 0xCF, 0x1F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0x1F, 0xDF, 0xCE, 0xCC, 0xCF, 0xCF, 0xCF, 0xCF, 0xCF, 0xCF, 0xCF, 0xCF,0xCF, 0xCF, 0xCF, 0xCF, 0xCF, 0xCF, 0xCF, 0xC0, 0xC0, 0xCF, 0x1F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xE7, 0x83, 0x39, 0xFD,0x39, 0x83, 0xE7, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,0xFF, 0xFF, 0xFF, 0xFF, 0xE0, 0xCF, 0xDF, 0xDF, 0xDF, 0xDF, 0xDF, 0xDF, 0xDF, 0xDF, 0xDE, 0xDE,0xDE, 0xDF, 0xDF, 0xDF, 0xDF, 0xDF, 0xDF, 0xDF, 0xDF, 0xDF, 0xE0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	
	calculadora_texto: .asciiz "CALCULADORA"
	rot13_texto: .asciiz "ROT 13"
	tateti_texto: .asciiz "TA-TE-TI"
	.text
	
menu_principal1:

	addi    $sp, $sp, -4
    sw	    $ra, ($sp)
	
	jal		black_screen
	
	li		$a0, 0x0114
	li		$a1, 0x2020
	la		$a2, calculadora_invertido
 	jal		draw_bitmap
	
	
	li		$a0, 0x014c
	li		$a1, 0x2020
	la		$a2, rot13
	jal		draw_bitmap
	
	li		$a0, 0x0714
 	la		$a2, calculadora_texto
 	jal		imprimir_texto
	

	
	lw	    $ra, ($sp)
    addi    $sp, $sp, 4
	
	jr		$ra

	
	
menu_principal2:

	addi    $sp, $sp, -4
    sw	    $ra, ($sp)
	
	jal		black_screen
	
	li		$a0, 0x0114
	li		$a1, 0x2020
	la		$a2, calculadora
 	jal		draw_bitmap
	
	
	li		$a0, 0x014c
	li		$a1, 0x2020
	la		$a2, rot13_invertido
	jal		draw_bitmap
	
	li		$a0, 0x0728
 	la		$a2, rot13_texto
 	jal		imprimir_texto
	
		

	lw	    $ra, ($sp)
    addi    $sp, $sp, 4
	
	jr		$ra
	
menu_principal3:
	
	addi    $sp, $sp, -4
    sw	    $ra, ($sp)
	
	jal		black_screen
	
	li		$a0, 0x0114
	li		$a1, 0x2020
	la		$a2, calculadora
 	jal		draw_bitmap
	

	li		$a0, 0x0728
 	la		$a2, tateti_texto
 	jal		imprimir_texto
	
		

	lw	    $ra, ($sp)
    addi    $sp, $sp, 4
	
	jr		$ra
	
	