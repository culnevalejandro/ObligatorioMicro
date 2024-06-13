.globl menu_calculadora
	.data
memoria_stack: .space 1024 # Espacio de memoria para el stack
finalDeStack: .word 0 # Puntero al final del stack
stack_pointer: .word 0 # puntero al tope del stack
string_STACK: .asciiz "STACK: "
string_invalida: .asciiz "entrada inválida \n"
string_insuficientes: .asciiz "operandos insuficientes \n"
string_potNegativa: .asciiz "Potencia negativa, inválido \n"
string_entrada: .asciiz "Entrada: "
string_espacio: .asciiz "\n"
string_espacio2: .asciiz " "
numeroDeElementos: .word 0 # Contador de elementos del stack
espacio_entrada: .space 100 # Espacio para almacenar la entrada del usuario
numeroAImprimir: .asciiz " " 

.text
	
menu_calculadora:
	
addi $sp, $sp,-4
sw $ra, ($sp)
	
j inicializarStack
agregar:
	li $a0, 1
	jal push
	li $a0, 2
	jal push
	li $a0, 3
	jal push
	li $a0, 4
	jal push
	li $a0, 11
	jal push
	
loopPrincipal:

jal		black_screen
	
# Imprimir string "STACK: "
li $a0,0x0
la $a2,string_STACK
jal imprimirTexto

# Imprimir los elementos de la pila y pedir la entrada al usuario
move $s0,$v0
jal imprimirStack

# la $a0, string_espacio
# li $v0, 4
# syscall
# 
# pedirEntrada: 
# la $a0, string_entrada
# li $v0, 4
# syscall
# 
# li $v0, 8
# la $a0, espacio_entrada
# li $a1, 6  # Permitir entradas de hasta 6 digitos
# syscall
# 
# # Verificar que la entrada sea totalmente numérica
# 
# la $t0, espacio_entrada # Cargar en t0 la dirección donde se guarda la entrada
# li $s1, 0 # s1 lleva la entrada convertida en entero
# li $t3, 0 # Mientras no haya ningun numero en la entrada vale 0, cuando se encuentra el primero pasa a 1. Sirve para marcar como invalidas instrucciones que tengan numeros antes
# 
# verificoEsNumerico:
# lb $t1, ($t0)
# beq $t1, 10, esNumerico # si vale 10 es el salto de línea en ASCII, llegó al final del string y es numérico
# beq $t1, 0, esNumerico # si vale 0 es el fin del string y también es numérico
# blt $t1, 48, noNumerico #si es menor a 48 (0 en ASCII) no es numero
# bgt $t1, 57, noNumerico #mayor a 57 (9 en ASCII) no es numero
# 
# li $t3, 1 # Si corre esta línea, se encontró un numero
# 
# # Si es numerico, lo convierto de string a entero y lo guardo en $t2
# sub $t1, $t1, 48 # resto 48 para obtener valor numérico
# mul $s1, $s1, 10 # multiplico lo que tenía en t2 por 10 para agregar el digito nuevo
# add $s1, $s1, $t1 # agrego nuevo digito
# 
# addi $t0, $t0, 1 #avanzo a siguiente byte
# j verificoEsNumerico
# 
# esNumerico:
# beqz $t3, entradaInvalida #Si t3 vale cero, no se encontro ningun numero y el ingreso fue solo un salto de linea, no es valido
# # Verifico que la cantidad de elementos del stack sea menor a 10 para agregar uno
# jal cantElementos
# beq $v0, 10, entradaInvalida # Si ya tiene 10, no puedo agregar más y la entrada numerica es invalida
# 
# # El numero entero que quiero guardar en el stack queda guardado en s1
# 
# move $a0, $s1
# jal push # llamo a la funcion push para guardar en el stack la entrada
# 
# j loopPrincipal
# 
# 
# noNumerico:
# # El valor no numerico está guardado en t1
# bnez $t3, entradaInvalida # Si t3 vale 1, hay numeros antes que el caracter encontado y es invalido
# lb $t3, 1($t0) # Verifico que el siguiente caracter sea un salto o un cero
# beqz $t3, valida
# bne $t3, 10, entradaInvalida
# 
# 
# # Si llegó hasta acá, puede ser una operacion valida y comparo con el código ASCII en cada caso
# valida:
# beq $t1, 43, suma # (+)
# beq $t1, 45, resta # (-)
# beq $t1, 42, multiplicacion # (*)
# beq $t1, 112, potencia # (p)
# beq $t1, 99, limpiarStack # (c)
# beq $t1, 120, salirPrograma # (x)
# j entradaInvalida # si no es ninguna de estas operaciones, es invalido
# 
# entradaInvalida: # Avisa que es inválida y vuelve a pedir la entrada
# la $a0, string_espacio
# li $v0, 4
# syscall
# 
# la $a0, string_invalida
# li $v0, 4
# syscall
# j pedirEntrada
# 
# suma: # Pide los ultimos 2 elementos del stack y los suma, luego los elimina y agrega el resultado al stack
# jal cantElementos
# blt $v0, 2, operandosInsuficientes # Si cantElementos<2, los operandos son insuficientes
# jal pop 
# move $s1, $v0 # Como el loop principal no es una función, no es necesario protejer los registros s1 y s2
# jal pop
# move $s2, $v0
# add $a0, $s1, $s2
# jal push
# j loopPrincipal
# 
# 
# resta: # Pide los ultimos 2 elementos del stack y los resta, luego los elimina y agrega el resultado al stack
# jal cantElementos
# blt $v0, 2, operandosInsuficientes
# jal pop 
# move $s1, $v0
# jal pop
# move $s2, $v0
# sub $a0, $s2, $s1
# jal push
# j loopPrincipal
# 
# multiplicacion: # Pide los ultimos 2 elementos del stack y los multiplica, luego los elimina y agrega el resultado al stack
# jal cantElementos
# blt $v0, 2, operandosInsuficientes
# jal pop 
# move $s1, $v0
# jal pop
# move $s2, $v0
# mul $a0, $s2, $s1 
# jal push
# j loopPrincipal
# 
# potencia: # Pide los ultimos 2 elementos del stack y eleva el penúltimo a una potencia del último, luego los elimina y agrega el resultado al stack
# jal cantElementos
# blt $v0, 2, operandosInsuficientes
# jal pop 
# move $s1, $v0
# jal pop
# move $s2, $v0
# move $t1, $s1 # lleva en t1 un contador de veces que tengo que multiplicar
# bltz $t1, potenciaNegativa # No permite elevar a un numero negativo
# beqz $t1, elevarACero # si es cero, el resultado es 1 independientemente del otro numero
# 
# # la primera vez que multiplico solamente paso el numero a la variable t2 y resto uno en el contador 
# move $t2, $s2
# subi $t1, $t1, 1
# 
# loopPotencia:
# beqz $t1, finPotencia
# mul $t2, $t2, $s2 # va guardando en t2 el resultado
# subi $t1, $t1, 1
# j loopPotencia
# 
# finPotencia:
# move $a0, $t2 # Agregar el resultado al stack 
# jal push
# j loopPrincipal
# 
# elevarACero:
# li $a0, 1
# jal push
# j loopPrincipal
# 
# limpiarStack:
# jal cantElementos 
# beqz $v0, loopPrincipal # Si la lista tiene cero elementos, ya esta limpia y sale del loop
# jal pop 
# j limpiarStack
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
# #----------------------------------------------------- 
# # FUNCIONES DEL STACK
# stack:
# 
inicializarStack:  

la $t0, memoria_stack # Dirección del comienzo del espacio del stack
sw $t0, stack_pointer # stack_pointer guarda la dirección al tope del stack (comienza en donde cree el espacio y siempre apunta al último elemento agregado)
sw $t0, finalDeStack # Guardo en finalDeStack el elemento final del stack
j agregar

	# Push: agrega al stack un valor guardado en $a0
	push: 
		
		lw $t1, stack_pointer # Dirección del tope del stack
		sw $a0, ($t1) # Guarda el valor en el tope del stack
		addi $t1, $t1, 4 # Avanza en 4 bytes el tope del stack
		sw $t1, stack_pointer # Actualiza la nueva dirección tope
		
		# Incrementa la cantidad de elementos
		lw $t2, numeroDeElementos
		addi $t2, $t2, 1
		sw $t2, numeroDeElementos
		
		jr $ra
# 	
# 	# Pop: devuelve en v0 el último elemento del stack y lo elimina
# 	pop:  
# 		addi $sp, $sp, -8
# 		sw $s1, 0($sp)
# 		sw $s2, 4($sp)
# 		
# 		lw $t1, stack_pointer # Dirección del tope del stack
# 		addi $t1, $t1, -4 # Retrocede para obtener el último elemento
# 		lw $v0, ($t1) # Carga el último elemento en v0
# 		sw $t1, stack_pointer # Actualiza la dirección del tope del stack
# 		
# 		# Decrementar la cantidad de elementos
# 		lw $t2, numeroDeElementos
# 		addi $t2, $t2, -1
# 		sw $t2, numeroDeElementos
# 		
# 		lw $s1, ($sp)
# 		lw $s2, 4($sp)
# 		addi $sp, $sp, 8
# 		
# 		jr $ra
# 	
# 	# Top: obtiene en $v1 el valor en el tope del stack
# 	top: 
# 		lw $t1, stack_pointer 
# 		lw $v1, -4($t1)
# 		jr $ra
	
	# CantElementos: devuelve en v0 la cantidad de elementos en el stack
	cantElementos: 
		addi $sp, $sp, -4
		sw $s1, 0($sp)
		
		lw $v0, numeroDeElementos
		
		lw $s1, ($sp)
		addi $sp, $sp, 4
		jr $ra
	
	# ImprimirStack: imprime los elementos del stack
	imprimirStack:
		addi $sp, $sp, -16
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)
		sw $s2, 12($sp)
		
		jal cantElementos # Obtiene la cantidad de elementos en el stack
		move $s2, $v0 # Guarda la cantidad de elementos restantes a imprimir
		lw $s1, finalDeStack # Puntero al final del stack
		
		loopImprimir:
		beqz $s2, salir # Si no quedan elementos, termina el loop
		
		lw $a0, ($s1) # Carga el elemento actual
		addi $a0,$a0,48 # paso a ASCII
		sw $a0, numeroAImprimir
		la $a2, numeroAImprimir
		move $a0, $s0
		jal imprimirTexto
		
		la $a2, string_espacio2
		move $a0, $v0
		jal imprimirTexto
		
		addi $s2, $s2, -1 # Decrementa el contador y avanza al siguiente elemento
		addi $s1, $s1, 4
		j loopImprimir
		
		 
		salir:
		lw $s2, 12($sp)
		lw $s1, 8($sp)
		lw $s0, 4($sp)
		lw $ra, ($sp)
		addi $sp, $sp, 16
		jr $ra
		
	
	




