.globl menu_rot13
.data
memoria_stack: .space 1024 # Espacio de memoria para el stack
finalDeStack: .word 0 # Puntero al final del stack
stack_pointer: .word 0 # puntero al tope del stack
numeroDeElementos: .word 0 # Contador de elementos del stack
espacio_entrada: .space 100 # Espacio para almacenar la entrada del usuario
 
str_input: .asciiz "INGRESE FRASE: "
str_buffer: .space 41
new_line: .asciiz "\n"
contador_char: .byte 0x0
estado_actual: .byte 0x0
	

uno: .byte ',', '.', '!', '1'
dos: .byte  'A','B','C','2'
tres: .byte  'D','E','F','3'
cuatro: .byte  'G','H','I','4'
cinco: .byte  'J','K','L','5'
seis: .byte  'M','N','0','6'
siete: .byte  'P','Q','R','S','7'
ocho: .byte  'T','U','V','8'
nueve: .byte  'W','X','Y','Z','9'
cero: .byte  ' ','0'
	
temporizador_bajo: .word 0x0


.text

	
menu_rot13:
	
addi $sp, $sp,-20
	
sw $ra, ($sp)
sw $s1, 4($sp)
sw $s0, 8($sp)
sw $s3, 12($sp)
sw $s4, 16($sp)

jal			inicializarStack
	
jal			black_screen
	
# Imprimir "Ingrese frase: "
li			$a0,0x0
la			$a2,str_input
jal			imprimirTexto
	
jal			imprimirStack

esperarLetra:
	jal keypad_read
	
	beqz $v0, esperarLetra
	beq $v0, 66, esperarLetra
	beq $v0, 67, esperarLetra
	
	beq			$v0, 65, finRot13 # A, escape
	beq			$v0, 35, borrar
	beq			$v0, 68, aplicar_rot13
	
	move $s1, $v0 # guardo en s1 la letra presionada
	li $s0, 0 # inicializar temporizador
	li $t0, 0
	sb $t0, estado_actual # primera vez que toca la letra, el estado es cero
	
	beq $s1, 49, teclaUno
	beq $s1, 50, teclaDos
	beq $s1, 51, teclaTres
	beq $s1, 52, teclaCuatro
	beq $s1, 53, teclaCinco
	beq $s1, 54, teclaSeis
	beq $s1, 55, teclaSiete
	beq $s1, 56, teclaOcho
	beq $s1, 57, teclaNueve
	beq $s1, 48, teclaCero
	
	
	teclaCero:
	la $s3, cero
	li $s4, 1
	j agregarLetra
	
	teclaUno:
	la $s3, uno
	li $s4, 3
	j agregarLetra
	
	teclaDos:
	la $s3, dos
	li $s4, 3
	j agregarLetra
	
	teclaTres:
	la $s3, tres
	li $s4, 3
	j agregarLetra
	
	teclaCuatro:
	la $s3, cuatro
	li $s4, 3
	j agregarLetra
	
	teclaCinco:
	la $s3, cinco
	li $s4, 3
	j agregarLetra
	
	teclaSeis:
	la $s3, seis
	li $s4, 3
	j agregarLetra
	
	teclaSiete:
	la $s3, siete
	li $s4, 4
	j agregarLetra
	
	teclaOcho:
	la $s3, ocho
	li $s4, 3
	j agregarLetra
	
	teclaNueve:
	la $s3, nueve
	li $s4, 4
	j agregarLetra

	loopTemporizador:
		addi $s0, $s0, 1 # Sumo 1 al temporizador
		
		beq $s0, 0x2FFF, esperarLetra  # pasaron mas de 5 segundos
		jal keypad_read
		
		beq $v0, 66, loopTemporizador
		beq $v0, 67, loopTemporizador
		beqz $v0, loopTemporizador
		
		beq			$v0, 35, borrar
		beq			$v0, 65, finRot13 # A, escape
		bne $v0, $s1, esperarLetra

		
		# si llega aca es porque toco la misma letra
		
	cambiarLetra:
	lb $t0, estado_actual
	blt $t0, $s4, sumar
	li	$t0, -1
	
	sumar:
	addi $t0, $t0, 1
	sb $t0, estado_actual
	
	jal pop
	li $s0, 0
	
	
	
	# $s2 tiene la direccion de memoria con los caracteres ascii
	# $s3 tiene el estado maximo de esa tecla
	agregarLetra:
	
	move $t0, $s3 # Guardo la direccion de memoria
	lb $t1, estado_actual
	add $t0, $t0, $t1
	lb $a0, ($t0)
	jal push
	li $a0, 0x0100
	la $a2, memoria_stack
	jal imprimirTexto
	li $s0, 0
	j loopTemporizador
		
	
	borrar:
	jal pop
	j esperarLetra
	
	aplicar_rot13: # XXX implementar
	

# # recibir la entrada del usuario
# 
# 
# # realizar un salto de linea para una mejor visualizacion del texto en consola
# 
# 
# 
# rot13:
# 	lb $t1, str_buffer
# 	beqz $t1, end	# Si contenido = 0; fin frase
# 	
# 	# Si contenido (ascii) <A o >z; cargar byte
# 	blt $t1, 'A', load_byte	
# 	bgt $t1, 'z', load_byte
# 	
# 	# Distinguir mayuscula de minuscula
# 	ble $t1, 'Z', mayuscula
# 	bge $t1, 'a', minuscula
# 	
# 	# Si contenido (ascii) fuera de rango, cargar byte
# 	j load_byte
# 	
# 	
# 	
# mayuscula:
# 	addi $t1, $t1, 13	# aplicar rot13
# 	ble $t1, 'Z', load_byte	# si caracter ascii dentro de rango mayusculas luego de rot13, cargar byte
# 	
# 	addi, $t1, $t1, -26	# si caracter fuera de rango, 	restar 26
# 	j load_byte # cargar letra mayuscula
# 	
# 	
# minuscula:
# 	addi $t1, $t1, 13	# aplicar rot13
# 	ble $t1, 'z', load_byte	# si caracter ascii dentro de rango minuscula luego de rot13, cargar byte
# 	
# 	addi, $t1, $t1, -26	# si caracter fuera de rango, restar 26
# 	j load_byte # cargar letra minuscula
# 
# 
# 
# load_byte:
# 	# cargar caracter ascii y mostrarlo en consola
# 	la $a0, 0($t1)
# 	li $v0, 11
# 	syscall
# 	addi $t0, $t0, 1
# 	j rot13
# 
# 
# end:
		
		
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
		# beq	$t2, 10, fin_push
		lw		$t1, stack_pointer # Dirección del tope del stack
		sb		$a0, ($t1) # Guarda el valor en el tope del stack
		addi	$t1, $t1, 1 # Avanza en 4 bytes el tope del stack
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
		addi $t1, $t1, -1 # Retrocede para obtener el último elemento
		lb $v0, ($t1) # Carga el último elemento en v0
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
		
		
		la			$a0, 0x0
		la			$a2, memoria_stack
		jal			imprimirTexto
		
		salir:
		lw			$ra, ($sp)
		addi		$sp, $sp, 4
	
		jr			$ra
		
		

finRot13:
	
		lw			$s4, 16($sp)
		lw			$s3, 12($sp)
		lw			$s0, 8($sp)
		lw			$s1, 4($sp)
		lw			$ra, ($sp)
		addi		$sp, $sp, 20
	
		jr			$ra

	