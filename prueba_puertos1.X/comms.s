.data
SSD1306_COLUMNADDRESS: .byte 0x21
SSD1306_PAGEADDRESS: .byte 0x22	
SSD1306_SEND_COMMAND: .byte 0x1
.text
.globl enviar
.globl enviar_bitmap
.globl draw_bitmap
    
    
# FUNCT enviar
# PARAM
# $a0 enviar through spi
# $a1 data (0x3); comm (0x1)
enviar:

    # Inicializar DC, RES y CS (PORTE)
    sb	    $a1, PORTE
    
    # Escribir comando en SPI1BUF
    sb	    $a0, SPI1BUF
    
waitTxReady:
    # Leer el registro de estado SPI1STAT
    lw	    $t1, SPI1STAT
    # Comprobar si el SPI esta realizando transacciones (SPITBUSY = 1)
    andi    $t1, $t1, 0x800	    # me fijo en el bit 11 que me dice si esta ocupado o no el SPI
    beq	    $t1, 1, waitTxReady   # Si SPITBUSY es 1, esperar
    
    
    jr      $ra
    
	
# FUNCT send_bitmap
# PARAM
# Recibe en $a2 puntero inicial del array, recorre mandando por byte
# Recibe en $a3 cantidad de bytes a imprimir
enviar_bitmap:
    # lw $s1, $a2
    li	    $s0, 0 # contador de bytes que se mandaron
    addi    $sp, $sp, -4
    sw	    $ra, ($sp)
 loop:

    lb	    $a0, ($a2)
    li	    $a1, 0x3
    jal	    enviar
    addi    $s0, $s0, 1 
    addi    $a2, $a2, 1		#arreglar
    bne	    $s0,$a3,loop
    
 fin:
    lw	    $ra, ($sp)
    addi    $sp, $sp, 4
    jr	    $ra
	
    
    
# $a0: page y columna inicio   
# $a1: alto y ancho  
# $a2: ilustracion
	
draw_bitmap:
	addi    $sp, $sp, -28
    sw	    $ra, ($sp)
    sw	    $s0, 4($sp)
	sw	    $s1, 8($sp)
    sw	    $s2, 12($sp)
	sw	    $s3, 16($sp)
	sw	    $s4, 20($sp)
	sw	    $s5, 24($sp)
	
	
	andi $s1, $a0, 0xFF # columna inicio
	andi $s0, $a0, 0xFF00
	srl $s0, $s0, 8 # page inicio

	andi $s3, $a1, 0xFF # ancho
	andi $s2, $a1, 0xFF00
	srl $s2, $s2, 8		# alto
	
	
	mul $t5,$s2,$s3 
	div $s5, $t5, 8 # cantidad de bytes a copiar
	
	add $s3, $s1, $s3 # columna final +1
	addi $s3,$s3,-1 # columna final
	

	div $s2, $s2, 8
	mflo $t4 # cantidad de pages que ocupa
	add $s2,$s0,$t4 # page final +1
	addi $s2,$s2,-1 # page final
	
	addi $s4, $a2, 0 # punero a array de ilustracion

	

	li	    $a1, SSD1306_SEND_COMMAND 
    lb	    $a0, SSD1306_COLUMNADDRESS
    jal	    enviar
    li	    $a1, SSD1306_SEND_COMMAND 
    addi    $a0, $s1, 0
    jal	    enviar
    li	    $a1, SSD1306_SEND_COMMAND
    addi    $a0, $s3, 0
    jal	    enviar
    
    li	    $a1, SSD1306_SEND_COMMAND 
    lb	    $a0,SSD1306_PAGEADDRESS
    jal	    enviar
    li	    $a1, SSD1306_SEND_COMMAND 
    addi    $a0, $s0, 0
    jal	    enviar
    li	    $a1, SSD1306_SEND_COMMAND
    addi    $a0, $s2, 0
    jal	    enviar
	
	
	
	addi    $a2, $s4, 0
	addi    $a3, $s5, 0 # cantidad de bytes a imprimir
	jal     enviar_bitmap
	
	
	lw	    $ra, ($sp)
    lw	    $s0, 4($sp)
	lw	    $s1, 8($sp)
    lw	    $s2, 12($sp)
	lw	    $s3, 16($sp)
	lw	    $s4, 20($sp)
	lw	    $s5, 24($sp)
	addi    $sp, $sp, 28
	
	jr $ra