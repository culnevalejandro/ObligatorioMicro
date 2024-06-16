.globl menu_rot13
.data
memoria_stack:			.space 1024 # Espacio de memoria para el stack
final_de_stack:			.word 0 # Puntero al final del stack
stack_pointer:			.word 0 # puntero al tope del stack
numero_de_elementos:	.word 0 # Contador de elementos del stack
espacio_entrada:		.space 100 # Espacio para almacenar la entrada del usuario
 
str_input:				.asciiz "INGRESE FRASE: "
str_output:				.asciiz "ROT 13: "
str_refrescar:			.asciiz " REFRESCAR (D)"
estado_actual:			.byte 0x0
	

uno:		.byte ',', '.', '!', '1'
dos:		.byte  'A','B','C','2'
tres:		.byte  'D','E','F','3'
cuatro:		.byte  'G','H','I','4'
cinco:		.byte  'J','K','L','5'
seis:		.byte  'M','N','O','6'
siete:		.byte  'P','Q','R','S','7'
ocho:		.byte  'T','U','V','8'
nueve:		.byte  'W','X','Y','Z','9'
cero:		.byte  ' ','0'
	
temporizador_bajo: .word 0x0


.text

	
menu_rot13:
	
	addi	$sp, $sp,-20
	
	sw		$ra, ($sp)
	sw		$s1, 4($sp)
	sw		$s0, 8($sp)
	sw		$s3, 12($sp)
	sw		$s4, 16($sp)

	jal		inicializar_stack

refrescar:
	
	jal		black_screen
	
# Imprimir "Ingrese frase: "
	li		$a0,0x0
	la		$a2,str_input
	jal		imprimir_texto
	
	jal		imprimirStack

esperarLetra:
	jal		keypad_read
	
	beqz	$v0, esperarLetra
	beq		$v0, 66, esperarLetra
	beq		$v0, 67, esperarLetra
	
	beq		$v0, 65, fin_rot13 # A, escape
	beq		$v0, 35, borrar
	beq		$v0, 68, aplicar_rot13
	
	move	$s1, $v0 # guardo en s1 la letra presionada
	li		$s0, 0 # inicializar temporizador
	li		$t0, 0
	sb		$t0, estado_actual # primera vez que toca la letra, el estado es cero
	
	beq		$s1, 49, teclaUno
	beq		$s1, 50, teclaDos
	beq		$s1, 51, teclaTres
	beq		$s1, 52, teclaCuatro
	beq		$s1, 53, teclaCinco
	beq		$s1, 54, teclaSeis
	beq		$s1, 55, teclaSiete
	beq		$s1, 56, teclaOcho
	beq		$s1, 57, teclaNueve
	beq		$s1, 48, teclaCero
	
	
teclaCero:
	la		$s3, cero
	li		$s4, 1
	j		agregarLetra
	
teclaUno:
	la		$s3, uno
	li		$s4, 3
	j		agregarLetra
	
teclaDos:
	la		$s3, dos
	li		$s4, 3
	j		agregarLetra
	
teclaTres:
	la		$s3, tres
	li		$s4, 3
	j		agregarLetra
	
teclaCuatro:
	la		$s3, cuatro
	li		$s4, 3
	j		agregarLetra
	
teclaCinco:
	la		$s3, cinco
	li		$s4, 3
	j		agregarLetra
	
teclaSeis:
	la		$s3, seis
	li		$s4, 3
	j		agregarLetra
	
teclaSiete:
	la		$s3, siete
	li		$s4, 4
	j		agregarLetra
	
teclaOcho:
	la		$s3, ocho
	li		$s4, 3
	j		agregarLetra
	
teclaNueve:
	la		$s3, nueve
	li		$s4, 4
	j		agregarLetra

loopTemporizador:
	addi	$s0, $s0, 1 # Sumo 1 al temporizador
		
	beq		$s0, 0x2FFF, esperarLetra  # pasaron mas de 5 segundos
	jal		keypad_read
		
	beq		$v0, 66, loopTemporizador
	beq		$v0, 67, loopTemporizador
	beqz	$v0, loopTemporizador
		
	beq		$v0, 35, borrar
	beq		$v0, 65, fin_rot13 # A, escape
		
	bne		$v0, $s1, esperarLetra

		
		# si llega aca es porque toco la misma letra
		
cambiarLetra:
	lb		$t0, estado_actual
	blt		$t0, $s4, sumar
	li		$t0, -1
	
sumar:
	addi	$t0, $t0, 1
	sb		$t0, estado_actual
	
	jal		pop
	li		$s0, 0
	
	# $s2 tiene la direccion de memoria con los caracteres ascii
	# $s3 tiene el estado maximo de esa tecla
agregarLetra:
	
	move	$t0, $s3 # Guardo la direccion de memoria
	lb		$t1, estado_actual
	add		$t0, $t0, $t1
	lb		$a0, ($t0)
	jal		push
	
	jal		imprimirStack
	li		$s0, 0
	j		loopTemporizador
		
	
borrar:
	jal		pop
	j		refrescar
	
aplicar_rot13:
	jal		can_elementos
	move	$t0,$v0
	la		$t2, memoria_stack
	
loop_Rot13:
	lb		$t1, ($t2)
	beqz	$t0, end	# Si contenido = 0; fin frase
	
	# Si contenido (ascii) <A o >Z; cargar byte
	blt		$t1, 'A', load_byte	
	bgt		$t1, 'Z', load_byte
		
mayuscula:
	addi	$t1, $t1, 13	# aplicar rot13
	ble		$t1, 'Z', load_byte	# si caracter ascii dentro de rango mayusculas luego de rot13, cargar byte
	
	addi	$t1, $t1, -26	# si caracter fuera de rango, 	restar 26
	j		load_byte # cargar letra mayuscula

load_byte:
	sb		$t1, ($t2)
	addi	$t2, $t2, 1
	addi	$t0,$t0,-1
	j		loop_Rot13
	
end:
	
	la		$a0, 0x0400
	la		$a2, str_output
	jal		imprimir_texto
	
	la		$a0, 0x0500
	la		$a2, memoria_stack
	jal		imprimir_texto
	
	la		$a0, 0x0700
	la		$a2, str_refrescar
	jal		imprimir_texto
	
loop_esperar_D:
	
	jal		keypad_read
	
	beq		$v0,65,fin_rot13
	beq		$v0,68,vuelve_ingresar
	
	j		loop_esperar_D
	
vuelve_ingresar:
	jal		limpiar_stack
	j		refrescar
	
	
	
	
		
		
# ----------------------------------------------------- 
# FUNCIONES DEL STACK

inicializar_stack:  
	
	la		$t0, memoria_stack # Dirección del comienzo del espacio del stack
	sw		$t0, stack_pointer # stack_pointer guarda la dirección al tope del stack (comienza en donde cree el espacio y siempre apunta al último elemento agregado)
	sw		$t0, final_de_stack # Guardo en final_de_stack el elemento final del stack
	
	jr		$ra

	# Push: agrega al stack un valor guardado en $a0
push: 
	lw		$t2, numero_de_elementos
	beq		$t2, 32, fin_push
	lw		$t1, stack_pointer # Dirección del tope del stack
	sb		$a0, ($t1) # Guarda el valor en el tope del stack
	addi	$t1, $t1, 1 # Avanza en 4 bytes el tope del stack
	sw		$t1, stack_pointer # Actualiza la nueva dirección tope
		
		# Incrementa la cantidad de elementos
	lw		$t2, numero_de_elementos
	addi	$t2, $t2, 1
	sw		$t2, numero_de_elementos
fin_push:
		
		
	jr		$ra
# 	
	# Pop: devuelve en v0 el último elemento del stack y lo elimina
pop:  
	addi	$sp, $sp, -8
	sw		$s1, 0($sp)
	sw		$s2, 4($sp)
		
	lw		$t2, numero_de_elementos
	beqz	$t2,fin_pop
		
		# Decrementar la cantidad de elementos
	addi	$t2, $t2, -1
	sw		$t2, numero_de_elementos
		
	lw		$t1, stack_pointer # Dirección del tope del stack
	addi	$t1, $t1, -1 # Retrocede para obtener el último elemento
	sb		$0, ($t1)

	lb		$v0, ($t1) # Carga el último elemento en v0
	sw		$t1, stack_pointer # Actualiza la dirección del tope del stack
		
fin_pop: 
	
	lw		$s1, ($sp)
	lw		$s2, 4($sp)
	addi	$sp, $sp, 8
		
	jr		$ra
	
	# Top: obtiene en $v1 el valor en el tope del stack
top: 
	lw		$t1, stack_pointer 
	lw		$v1, -4($t1)
	jr		$ra
	
	# CantElementos: devuelve en v0 la cantidad de elementos en el stack
can_elementos: 
	lw		$v0, numero_de_elementos

	jr		$ra
	
	# ImprimirStack: imprime los elementos del stack
imprimirStack:
	addi	$sp, $sp, -4
	sw		$ra, 0($sp)
		
		
	la		$a0, 0x0100
	la		$a2, memoria_stack
	jal		imprimir_texto
		
salir:
	lw		$ra, ($sp)
	addi	$sp, $sp, 4
	
	jr		$ra
		
		
limpiar_stack:
	addi	$sp, $sp, -4
	sw		$ra, ($sp)
		
limpiar_stack_loop:
	jal		can_elementos 
	beqz	$v0, fin_limpiar_stack # Si la lista tiene cero elementos, ya esta limpia y sale del loop
	jal		pop 
	j		limpiar_stack_loop

fin_limpiar_stack:
	lw		$ra, ($sp)
	addi	$sp, $sp, 4
	jr		$ra
		
		

fin_rot13:
	la		$a0, 0x0100
	la		$a2, memoria_stack
	jal		imprimir_texto
	jal		limpiar_stack
	
	lw		$s4, 16($sp)
	lw		$s3, 12($sp)
	lw		$s0, 8($sp)
	lw		$s1, 4($sp)
	lw		$ra, ($sp)
	addi	$sp, $sp, 20
	
	jr		$ra

	
	