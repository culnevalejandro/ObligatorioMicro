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
	j wait_input_state_change
	
	uno:
	li      $v0, 49
	j wait_input_state_change
	
	dos:
	li      $v0, 50
	j wait_input_state_change
	
	tres:
	li      $v0, 51
	j wait_input_state_change
	
	cuatro:
	li      $v0, 52
	j wait_input_state_change
	
	cinco:
	li      $v0, 53
	j wait_input_state_change
	
	seis:
	li      $v0, 54
	j wait_input_state_change
	
	siete:
	li      $v0, 55
	j wait_input_state_change
	
	ocho:
	li      $v0, 56
	j wait_input_state_change
	
	nueve:
	li      $v0, 57
	j wait_input_state_change
	
	letraA:
	li      $v0, 65
	j wait_input_state_change
	
	letraB:
	li      $v0, 66
	j wait_input_state_change
	
	letraC:
	li      $v0, 67
	j wait_input_state_change
	
	letraD:
	li      $v0, 68
	j wait_input_state_change
	
	asterisco:
	li      $v0, 42
	j wait_input_state_change
	
	numeral:
	li      $v0, 35
	j wait_input_state_change
	
	
	wait_input_state_change:
	lb		$t7, PORTD
	andi	$t7, $t7, 0xF
	bnez	$t7, wait_input_state_change
	j return

	
	exit:
    li      $v0, 0
	
	return:
    li      $t3, 0xF0       # PORTD = 0xF0 salidas PIC a 1
    sw      $t3, PORTD		# Guardar en PORTD

	
	lw		$ra,($sp)
	addi	$sp, $sp, 4
	
    jr      $ra           



delay_ms:
    lw      $t7, delay_count
delay_loop:
    addi    $t7, $t7, -1
    bne		$t7, $zero,  delay_loop
	jr		$ra
	
