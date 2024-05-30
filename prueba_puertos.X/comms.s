.text
    
    .globl enviar
    .globl mandar_bitmap
# $a0 lo que envia
# $a1 si es data (0x3) o comando (0x1)
enviar:

    # Inicializar DC, RES y CS (PORTE)
    sb      $a1, PORTE
    
    # Escribir comando en SPI1BUF
    sb      $a0, SPI1BUF
    
waitTxReady:
    # Leer el registro de estado SPI1STAT
    lw      $t1, SPI1STAT
    # Comprobar si el SPI esta realizando transacciones (SPITBUSY = 1)
    andi    $t1, $t1, 0x800	    # me fijo en el bit 11 que me dice si esta ocupado o no el SPI
    beq	    $t1, 1, waitTxReady   # Si SPITBUSY es 1, esperar
    
waitTxComplete:
    
    jr      $ra
    
    # Recibe en a2 puntero inicial del array, recorre mandando por word
mandar_bitmap:
    # lw $s1, $a2
    li $s0, 0 # contador de bytes que se mandaron
    addi $sp, $sp, -4
    sw	$ra, ($sp)
 loop:

    lb $a0, ($a2)
    li $a1, 0x3
    jal enviar
    addi $s0, $s0, 1 
    addi $a2, $a2, 1 
    bne $s0,1024,loop
    
 fin:
    jal delay
    li $a1, 0x1 
    li $a0, 0xA4
    jal enviar
    jal delay
    lw $ra, ($sp)
    addi $sp, $sp, 4
    jr $ra
    
    

