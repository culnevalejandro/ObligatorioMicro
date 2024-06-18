.globl menu_calculadora
	.data
memoria_stack_calc: .space 1024 # Espacio de memoria para el stack
finalDeStack_calc: .word 0 # Puntero al final del stack
stack_pointer_calc: .word 0 # puntero al tope del stack
string_stack_calc: .asciiz "STACK: "
string_insuficientes_calc: .asciiz "OPERANDOS       INSUFICIENTES"
string_entrada_calc: .asciiz "ENTRADA: "
numero_de_elementos_calc: .word 0 # Contador de elementos del stack
espacio_entrada_calc: .space 100 # Espacio para almacenar la entrada del usuario
buffer_entrada_calc: .word 0x0
cifras_buffer_entrada_calc:.byte 0x0
ingreso_distinto_cero_calc:.byte 0x0
		
.text
	
menu_calculadora:

	
addi $sp, $sp,-12
	
sw $ra, ($sp)
sw $s1, 4($sp)
sw $s2, 8($sp)
	
jal inicializar_stack
	
loop_principal:

jal			black_screen
	
# Imprimir string "STACK: "
li			$a0,0x0
la			$a2,string_stack_calc
jal			imprimir_texto
	
jal			imprimir_stack


pedirEntrada: 
	
	li			$a0, 0x0600 # Imprimir entrada en la parte de abajo de la pantalla
	la			$a2, string_entrada_calc
	jal			imprimir_texto
	esperar_entrada:
	jal			keypad_read
	
	beqz		$v0, esperar_entrada
	
	beq			$v0, 66, esperar_entrada
	beq			$v0, 67, clear
	beq			$v0, 35, borrar
	beq			$v0, 42, ingreso_operador
	beq			$v0, 65, fin_calculadora # A, escape
	beq			$v0, 68, esperar_entrada # D, enter
	
	li			$t0,1
	sb			$t0, cifras_buffer_entrada_calc
	
	move		$t0, $v0
	addi		$t0, $t0, -48 # Pasar entrada a int

	sw			$t0, buffer_entrada_calc
	
	la			$a0, buffer_entrada_calc
	li			$a1, 1
	jal			convert_int_to_ascii
		
	la			$a0,0x0648
	move		$a2, $v0
	jal			imprimir_texto
	
	
	ingreso_numeros:
	
	jal			keypad_read
	
	beqz		$v0, ingreso_numeros

	
	beq			$v0, 66, ingreso_numeros
	beq			$v0, 67, ingreso_numeros
	beq			$v0, 35, borrar
	beq			$v0, 42, ingreso_numeros
	beq			$v0, 65, fin_calculadora # A, escape
	beq			$v0, 68, enter_nro # D, enter
	
	lb			$t0, cifras_buffer_entrada_calc
	addi		$t0,$t0,1
	sb			$t0, cifras_buffer_entrada_calc
	
	move		$t0, $v0
	addi		$t0, $t0, -48 # Pasar entrada a int
	
	lw			$t1,buffer_entrada_calc
	mul			$t1,$t1,10
	add			$t0,$t0,$t1
	sw			$t0, buffer_entrada_calc
	
	la			$a0, buffer_entrada_calc
	li			$a1, 1
	jal			convert_int_to_ascii
		
	la			$a0,0x0648
	move		$a2, $v0
	jal			imprimir_texto
		
	lb			$t0, cifras_buffer_entrada_calc
	beq			$t0,6,enter_nro
	
	j ingreso_numeros
	
	borrar:
	
	#resto 1 cantidad cifras del buffer
	lb			$t0, cifras_buffer_entrada_calc
	beqz $t0,esperar_entrada
	addi		$t0,$t0,-1
	sb			$t0, cifras_buffer_entrada_calc
	
	
	
	lw $t0, buffer_entrada_calc
	div $t0,10
	mflo $t0
	sw $t0, buffer_entrada_calc
	
	# apago todo
	jal			black_screen
	
	#imprimo stack
li			$a0,0x0
la			$a2,string_stack_calc
jal			imprimir_texto
	
jal			imprimir_stack

# imprimo entrada
	li			$a0, 0x0600 # Imprimir entrada en la parte de abajo de la pantalla
	la			$a2, string_entrada_calc
	jal			imprimir_texto
	

	lb			$t0, cifras_buffer_entrada_calc
	beqz $t0,ingreso_numeros
	
	#imprimo buffer entrada
	la			$a0, buffer_entrada_calc
	li			$a1, 1
	jal			convert_int_to_ascii
		
	la			$a0,0x0648
	move		$a2, $v0
	jal			imprimir_texto
	

	j ingreso_numeros
	
	enter_nro:
	
	lb		$t0, cifras_buffer_entrada_calc
	beqz	$t0,esperar_entrada
	lw $a0,buffer_entrada_calc
	jal push
	j loop_principal
	

	ingreso_operador:
	
	suma:
	la			$a0,0x0648
	li		$a2, 43		# imprimo suma
	sw $a2, buffer_entrada_calc
	la $a2, buffer_entrada_calc
	jal			imprimir_texto
	loop_suma:
	jal			keypad_read
	beq			$v0, 42, resta
	beq			$v0, 65, fin_calculadora # A, escape
	beq			$v0, 68, hacer_suma # D, enter
	j loop_suma
	
	resta:
	la			$a0,0x0648
	li		$a2, 45		# imprimo resta
	sw $a2, buffer_entrada_calc
	la $a2, buffer_entrada_calc
	jal			imprimir_texto
	loop_resta:
	jal			keypad_read
	beq			$v0, 42, producto
	beq			$v0, 65, fin_calculadora # A, escape
	beq			$v0, 68, hacer_resta # D, enter
	j loop_resta
	
	producto:
	la			$a0,0x0648
	li		$a2, 42		# imprimo prducto
	sw $a2, buffer_entrada_calc
	la $a2, buffer_entrada_calc
	jal			imprimir_texto
	loop_producto:
	jal			keypad_read
	beq			$v0, 42, suma
	beq			$v0, 65, fin_calculadora # A, escape
	beq			$v0, 68, hacer_producto # D, enter
	j loop_producto

	clear:
	j limpiar_stack
	
	


	
	




hacer_suma: # Pide los ultimos 2 elementos del stack y los suma, luego los elimina y agrega el resultado al stack
jal cant_elementos
blt $v0, 2, operandos_insuficientes # Si cant_elementos<2, los operandos son insuficientes
jal pop 
move $s1, $v0 # Como el loop principal no es una función, no es necesario protejer los registros s1 y s2
jal pop
move $s2, $v0
add $a0, $s1, $s2
jal push
j loop_principal

hacer_resta: # Pide los ultimos 2 elementos del stack y los resta, luego los elimina y agrega el resultado al stack
jal cant_elementos
blt $v0, 2, operandos_insuficientes
jal pop 
move $s1, $v0
jal pop
move $s2, $v0
sub $a0, $s2, $s1
jal push
j loop_principal

hacer_producto: # Pide los ultimos 2 elementos del stack y los multiplica, luego los elimina y agrega el resultado al stack
jal cant_elementos
blt $v0, 2, operandos_insuficientes
jal pop 
move $s1, $v0
jal pop
move $s2, $v0
mul $a0, $s2, $s1 
jal push
j loop_principal



operandos_insuficientes:
	
jal			black_screen
	
li			$a0,0x0
la			$a2, string_insuficientes_calc
jal			imprimir_texto

	
	li $t0, 0
	loop_delay_calc:
	
	addi		$t0, $t0, 1
	bne			$t0, 0x4FFFF, loop_delay_calc
	

j loop_principal



	
# ----------------------------------------------------- 
# FUNCIONES DEL STACK

inicializar_stack:  
	
	la		$t0, memoria_stack_calc # Dirección del comienzo del espacio del stack
	sw		$t0, stack_pointer_calc # stack_pointer guarda la dirección al tope del stack (comienza en donde cree el espacio y siempre apunta al último elemento agregado)
	sw		$t0, finalDeStack_calc # Guardo en finalDeStack el elemento final del stack
	
	jr		$ra

	# Push: agrega al stack un valor guardado en $a0
	push: 
		lw		$t2, numero_de_elementos_calc
		beq	$t2, 10, fin_push
		lw		$t1, stack_pointer_calc # Dirección del tope del stack
		sw		$a0, ($t1) # Guarda el valor en el tope del stack
		addi	$t1, $t1, 4 # Avanza en 4 bytes el tope del stack
		sw		$t1, stack_pointer_calc # Actualiza la nueva dirección tope
		
		# Incrementa la cantidad de elementos
		lw		$t2, numero_de_elementos_calc
		addi	$t2, $t2, 1
		sw		$t2, numero_de_elementos_calc
		fin_push:
		
		
	jr		$ra
# 	
	# Pop: devuelve en v0 el último elemento del stack y lo elimina
	pop:  
		addi $sp, $sp, -8
		sw $s1, 0($sp)
		sw $s2, 4($sp)
 		
		lw $t1, stack_pointer_calc # Dirección del tope del stack
		addi $t1, $t1, -4 # Retrocede para obtener el último elemento
		lw $v0, ($t1) # Carga el último elemento en v0
		sw $t1, stack_pointer_calc # Actualiza la dirección del tope del stack

		# Decrementar la cantidad de elementos
		lw $t2, numero_de_elementos_calc
		addi $t2, $t2, -1
		sw $t2, numero_de_elementos_calc
		
		lw $s1, ($sp)
		lw $s2, 4($sp)
		addi $sp, $sp, 8
		
		jr $ra
	
	# Top: obtiene en $v1 el valor en el tope del stack
	top: 
		lw $t1, stack_pointer_calc 
		lw $v1, -4($t1)
		jr $ra
		
		
	limpiar_stack:
		addi	$sp, $sp, -4
		sw		$ra, ($sp)
		
	limpiar_stack_loop:
		jal cant_elementos 
		beqz $v0, fin_limpiar_stack # Si la lista tiene cero elementos, ya esta limpia y sale del loop
		jal pop 
		j limpiar_stack_loop

	fin_limpiar_stack:
		lw		$ra, ($sp)
		addi	$sp, $sp, 4
		jr		$ra
	
	
	
	# CantElementos: devuelve en v0 la cantidad de elementos en el stack
	cant_elementos: 
		addi		$sp, $sp, -8
		sw			$ra, ($sp)
		sw			$s1, 4($sp)
		
		lw			$v0, numero_de_elementos_calc
		
		lw			$s1, 4($sp)
		lw			$ra, 0($sp)
		addi		$sp, $sp, 8
		jr			$ra
	
	# ImprimirStack: imprime los elementos del stack
	imprimir_stack:
		addi		$sp, $sp, -4
		sw			$ra, 0($sp)
		
		la			$a0, memoria_stack_calc
		lw			$a1, numero_de_elementos_calc
		jal			convert_int_to_ascii
		
		la			$a0, 0x0038
		move		$a2, $v0
		jal			imprimir_texto
		
		salir:
		lw			$ra, ($sp)
		addi		$sp, $sp, 4
	
		jr			$ra
		
	fin_calculadora:
	
		jal			limpiar_stack
	
		lw			$s2, 8($sp)
		lw			$s1, 4($sp)
		lw			$ra, ($sp)
		addi		$sp, $sp, 12
	
		jr			$ra




