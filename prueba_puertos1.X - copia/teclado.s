.globl keypad_read
.data
delay_count: .word 1000 # Conteo para la función de retardo

.text

keypad_read:
	addi $sp, $sp, -4
	sw $ra,($sp)
	
	
    li      $t0, 1          # fila = 1
    li      $t1, 0x10       # bitmask = 0x10

    lw      $t3, PORTD      # Cargar el valor de PORTD
    andi    $t3, $t3, 0x0F  # Verificar si alguna de las líneas bajas está alta
    beqz    $t3, exit       # Si no hay, salir y retornar 0
	
scan_loop:

    sw      $t1, PORTD		# prendo fila ( arrancando de arriba )

    jal     delay_ms        # Retardo de unos milisegundos

    lw      $t4, PORTD      # Cargar el valor de PORTD
    andi    $t4, $t4, 0x0F  # guardo solo la entrada al pic
    bne     $t4, $0, finish
	

    sll     $t1, $t1, 1     # muevo fila que pongo en high
    addi    $t0, $t0, 1     # fila++
	beq		$t0,5,exit
    j       scan_loop

finish:
	# $t3-tiene info de columna y $t0-fila
	
	beq		$t3,1,col1
	beq		$t3,2,col2
	beq		$t3,4,col3
	beq		$t3,8,col4
	
	col1:
	beq		$t0,1,uno
	beq		$t0,2,cuatro
	beq		$t0,3,siete
	beq		$t0,4,asterisco
	
	col2:
	beq		$t0,1,dos
	beq		$t0,2,cinco
	beq		$t0,3,ocho
	beq		$t0,4,cero
	
	col3:
	beq		$t0,1,tres
	beq		$t0,2,seis
	beq		$t0,3,nueve
	beq		$t0,4,numeral
	
	col4:
	beq		$t0,1,letraA
	beq		$t0,2,letraB
	beq		$t0,3,letraC
	beq		$t0,4,letraD

	cero:
	li      $v0, 48
	j return 
	
	uno:
	li      $v0, 49
	j return
	
	dos:
	li      $v0, 50
	j return
	
	tres:
	li      $v0, 51
	j return
	
	cuatro:
	li      $v0, 52
	j return
	
	cinco:
	li      $v0, 53
	j return
	
	seis:
	li      $v0, 54
	j return
	
	siete:
	li      $v0, 55
	j return
	
	ocho:
	li      $v0, 56
	j return
	
	nueve:
	li      $v0, 57
	j return
	
	letraA:
	li      $v0, 65
	j return
	
	letraB:
	li      $v0, 66
	j return
	
	letraC:
	li      $v0, 67
	j return
	
	letraD:
	li      $v0, 68
	j return
	
	asterisco:
	li      $v0, 42
	j return
	
	numeral:
	li      $v0, 35
	j return

	exit:
    li      $v0, 0
	
	return:
    li      $t3, 0xF0       # PORTD = 0xF0 salidas PIC a 1
    sw      $t3, PORTD		# Guardar en PORTD
	
	jal		wait_input_state_change
	
	lw		$ra,($sp)
	addi	$sp, $sp, 4
	
    jr      $ra           



delay_ms:
    lw      $t7, delay_count
delay_loop:
    addi    $t7, $t7, -1
    bne		$t7, $zero,  delay_loop
	jr		$ra
	

	
		
wait_input_state_change:
	lb		$t0, PORTD
	andi	$t0, $t0, 0xF
	bnez	$t0, wait_input_state_change

	jr		$ra