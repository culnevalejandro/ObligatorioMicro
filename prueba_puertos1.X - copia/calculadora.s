.globl menu_calculadora
	.data
memoria_stack: .space 1024 # Espacio de memoria para el stack
finalDeStack: .word 0 # Puntero al final del stack
stack_pointer: .word 0 # puntero al tope del stack
string_STACK: .asciiz "STACK: "
string_invalida: .asciiz "ENTRADA INVALIDA"
string_insuficientes: .asciiz "OPERANDOS INSUFICIENTES"
string_potNegativa: .asciiz "POTENCIA NEGATIVA, INVALIDO"
string_entrada: .asciiz "ENTRADA: "
numeroDeElementos: .word 0 # Contador de elementos del stack
espacio_entrada: .space 100 # Espacio para almacenar la entrada del usuario
operacion_actual: .byte 0x0 # 0-suma, 1-resta, 2-producto
buffer_entrada: .word 0x0
cifras_buffer_entrada:.byte 0x0
ingreso_distinto_cero:.byte 0x0
		
.text
	
menu_calculadora:

	
addi $sp, $sp,-4
sw $ra, ($sp)
	
jal inicializarStack
	
loopPrincipal:

jal			black_screen
	
# Imprimir string "STACK: "
li			$a0,0x0
la			$a2,string_STACK
jal			imprimirTexto
	
jal			imprimirStack


pedirEntrada: 
	
	li			$a0, 0x0600 # Imprimir entrada en la parte de abajo de la pantalla
	la			$a2, string_entrada
	jal			imprimirTexto
	esperarEntrada:
	jal			keypad_read
	
	beqz		$v0, esperarEntrada
	
	beq			$v0, 66, esperarEntrada
	beq			$v0, 67, clear
	beq			$v0, 35, borrar
	beq			$v0, 42, ingreso_operador
	beq			$v0, 65, finCalculadora # A, escape
	beq			$v0, 68, esperarEntrada # D, enter
	
	li			$t0,1
	sb			$t0, cifras_buffer_entrada
	
	move		$t0, $v0
	addi		$t0, $t0, -48 # Pasar entrada a int

	sw			$t0, buffer_entrada
	
	la			$a0, buffer_entrada
	li			$a1, 1
	jal			convert_int_to_ascii
		
	la			$a0,0x0648
	move		$a2, $v0
	jal			imprimirTexto
	
	
	ingreso_numeros:
	
	jal			keypad_read
	
	beqz		$v0, ingreso_numeros

	
	beq			$v0, 66, ingreso_numeros
	beq			$v0, 67, ingreso_numeros
	beq			$v0, 35, borrar
	beq			$v0, 42, ingreso_numeros
	beq			$v0, 65, finCalculadora # A, escape
	beq			$v0, 68, enter_nro # D, enter
	
	lb			$t0, cifras_buffer_entrada
	addi		$t0,$t0,1
	sb			$t0, cifras_buffer_entrada
	
	move		$t0, $v0
	addi		$t0, $t0, -48 # Pasar entrada a int
	
	lw			$t1,buffer_entrada
	mul			$t1,$t1,10
	add			$t0,$t0,$t1
	sw			$t0, buffer_entrada
	
	la			$a0, buffer_entrada
	li			$a1, 1
	jal			convert_int_to_ascii
		
	la			$a0,0x0648
	move		$a2, $v0
	jal			imprimirTexto
		
	lb			$t0, cifras_buffer_entrada
	beq			$t0,6,enter_nro
	
	j ingreso_numeros
	
	borrar:
	
	#resto 1 cantidad cifras del buffer
	lb			$t0, cifras_buffer_entrada
	beqz $t0,esperarEntrada
	addi		$t0,$t0,-1
	sb			$t0, cifras_buffer_entrada
	
	
	
	lw $t0, buffer_entrada
	div $t0,10
	mflo $t0
	sw $t0, buffer_entrada
	
	# apago todo
	jal			black_screen
	
	#imprimo stack
li			$a0,0x0
la			$a2,string_STACK
jal			imprimirTexto
	
jal			imprimirStack

# imprimo entrada
	li			$a0, 0x0600 # Imprimir entrada en la parte de abajo de la pantalla
	la			$a2, string_entrada
	jal			imprimirTexto
	

	lb			$t0, cifras_buffer_entrada
	beqz $t0,ingreso_numeros
	
	#imprimo buffer entrada
	la			$a0, buffer_entrada
	li			$a1, 1
	jal			convert_int_to_ascii
		
	la			$a0,0x0648
	move		$a2, $v0
	jal			imprimirTexto
	

	j ingreso_numeros
	
	enter_nro:
	
	lb		$t0, cifras_buffer_entrada
	beqz	$t0,esperarEntrada
	lw $a0,buffer_entrada
	jal push
	j loopPrincipal
	

	ingreso_operador:
	
	suma:
	la			$a0,0x0648
	li		$a2, 43		# imprimo suma
	sw $a2, buffer_entrada
	la $a2, buffer_entrada
	jal			imprimirTexto
	loop_suma:
	jal			keypad_read
	beq			$v0, 42, resta
	beq			$v0, 65, finCalculadora # A, escape
	beq			$v0, 68, hacer_suma # D, enter
	j loop_suma
	
	resta:
	la			$a0,0x0648
	li		$a2, 45		# imprimo resta
	sw $a2, buffer_entrada
	la $a2, buffer_entrada
	jal			imprimirTexto
	loop_resta:
	jal			keypad_read
	beq			$v0, 42, producto
	beq			$v0, 65, finCalculadora # A, escape
	beq			$v0, 68, hacer_resta # D, enter
	j loop_resta
	
	producto:
	la			$a0,0x0648
	li		$a2, 42		# imprimo prducto
	sw $a2, buffer_entrada
	la $a2, buffer_entrada
	jal			imprimirTexto
	loop_producto:
	jal			keypad_read
	beq			$v0, 42, suma
	beq			$v0, 65, finCalculadora # A, escape
	beq			$v0, 68, hacer_producto # D, enter
	j loop_producto

	clear:
	j limpiarStack
	
	


	
	




hacer_suma: # Pide los ultimos 2 elementos del stack y los suma, luego los elimina y agrega el resultado al stack
jal cantElementos
# blt $v0, 2, operandosInsuficientes # Si cantElementos<2, los operandos son insuficientes
jal pop 
move $s1, $v0 # Como el loop principal no es una función, no es necesario protejer los registros s1 y s2
jal pop
move $s2, $v0
add $a0, $s1, $s2
jal push
j loopPrincipal

hacer_resta: # Pide los ultimos 2 elementos del stack y los resta, luego los elimina y agrega el resultado al stack
jal cantElementos
# blt $v0, 2, operandosInsuficientes
jal pop 
move $s1, $v0
jal pop
move $s2, $v0
sub $a0, $s2, $s1
jal push
j loopPrincipal

hacer_producto: # Pide los ultimos 2 elementos del stack y los multiplica, luego los elimina y agrega el resultado al stack
jal cantElementos
#blt $v0, 2, operandosInsuficientes
jal pop 
move $s1, $v0
jal pop
move $s2, $v0
mul $a0, $s2, $s1 
jal push
j loopPrincipal

 
limpiarStack:
jal cantElementos 
beqz $v0, loopPrincipal # Si la lista tiene cero elementos, ya esta limpia y sale del loop
jal pop 
j limpiarStack
# 
# salirPrograma:
# li $v0, 10
# syscall
# 
# operandosInsuficientes:
# la $a0, string_insuficientes
# li $v0, 4
# syscall
# j pedirEntrada
# 
# potenciaNegativa: # Vuelvo a agregar los elementos que elminé del stack y pido entrada nuevamente
# move $a0, $s2 
# jal push
# move $a0, $s1
# jal push
# la $a0, string_potNegativa
# li $v0, 4
# syscall
# j pedirEntrada
# 
	
# ----------------------------------------------------- 
# FUNCIONES DEL STACK

inicializarStack:  
	
	la		$t0, memoria_stack # Dirección del comienzo del espacio del stack
	sw		$t0, stack_pointer # stack_pointer guarda la dirección al tope del stack (comienza en donde cree el espacio y siempre apunta al último elemento agregado)
	sw		$t0, finalDeStack # Guardo en finalDeStack el elemento final del stack
	
	jr		$ra

	# Push: agrega al stack un valor guardado en $a0
	push: 
		lw		$t2, numeroDeElementos
		beq	$t2, 10, fin_push
		lw		$t1, stack_pointer # Dirección del tope del stack
		sw		$a0, ($t1) # Guarda el valor en el tope del stack
		addi	$t1, $t1, 4 # Avanza en 4 bytes el tope del stack
		sw		$t1, stack_pointer # Actualiza la nueva dirección tope
		
		# Incrementa la cantidad de elementos
		lw		$t2, numeroDeElementos
		addi	$t2, $t2, 1
		sw		$t2, numeroDeElementos
		fin_push:
		
		
	jr		$ra
# 	
	# Pop: devuelve en v0 el último elemento del stack y lo elimina
	pop:  
		addi $sp, $sp, -8
		sw $s1, 0($sp)
		sw $s2, 4($sp)
 		
		lw $t1, stack_pointer # Dirección del tope del stack
		addi $t1, $t1, -4 # Retrocede para obtener el último elemento
		lw $v0, ($t1) # Carga el último elemento en v0
		sw $t1, stack_pointer # Actualiza la dirección del tope del stack

		# Decrementar la cantidad de elementos
		lw $t2, numeroDeElementos
		addi $t2, $t2, -1
		sw $t2, numeroDeElementos
		
		lw $s1, ($sp)
		lw $s2, 4($sp)
		addi $sp, $sp, 8
		
		jr $ra
	
	# Top: obtiene en $v1 el valor en el tope del stack
	top: 
		lw $t1, stack_pointer 
		lw $v1, -4($t1)
		jr $ra
	
	# CantElementos: devuelve en v0 la cantidad de elementos en el stack
	cantElementos: 
		addi		$sp, $sp, -8
		sw			$ra, ($sp)
		sw			$s1, 4($sp)
		
		lw			$v0, numeroDeElementos
		
		lw			$s1, 4($sp)
		lw			$ra, 0($sp)
		addi		$sp, $sp, 8
		jr			$ra
	
	# ImprimirStack: imprime los elementos del stack
	imprimirStack:
		addi		$sp, $sp, -4
		sw			$ra, 0($sp)
		
		la			$a0, memoria_stack
		lw			$a1, numeroDeElementos
		jal			convert_int_to_ascii
		
		la			$a0, 0x0038
		move		$a2, $v0
		jal			imprimirTexto
		
		salir:
		lw			$ra, ($sp)
		addi		$sp, $sp, 4
	
		jr			$ra
		
	finCalculadora:
		lw			$ra, ($sp)
		addi		$sp, $sp, 4
	
		jr			$ra




